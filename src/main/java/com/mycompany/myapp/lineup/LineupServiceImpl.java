package com.mycompany.myapp.lineup;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.codehaus.jackson.JsonParser;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.JsonAdapter;
import com.mycompany.common.CommonUtil;
import com.mycompany.common.NaverShortUrl;
import com.mycompany.common.SearchParam;
import com.mycompany.myapp.HomeController;
import com.mycompany.myapp.user.UserService;
import com.mycompany.sms.NaverSmsResponseDTO;
import com.mycompany.sms.NaverSmsService;

@Service("lineupService")
public class LineupServiceImpl implements LineupService{
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	LineupMapper lineupMapper;
	
	@Autowired
	UserService userService;
	
	@Autowired
	private CommonUtil commonUtil;

	@Override
	public int countWaiting(SearchParam param) {
		// TODO Auto-generated method stub
		return lineupMapper.countWaiting(param);
	}

	@Override
	public int enroll(LineupDTO lineup, String msg) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException {
		// TODO Auto-generated method stub
		int result = 0;
		if (msg.equals("등록")) {		
			String date= "";
			String time= "";
			if (lineup.getLineup_yn() == 2) {			
				date = lineup.getDate();
				time = lineup.getTime();
				lineup.setDateTime(lineup.getDate()+" "+lineup.getTime()+":00");
				
				lineup.setLineup_visit(4); // 임시예약				
			}else {
				lineup.setLineup_visit(0); // 입장전
			}			
			result = lineupMapper.insertLineup(lineup);
			if (result > 0 && lineup.getLineup_yn() == 2) {				
				int idx = lineup.getIdx();
				Map<String, Object> storeUser = lineupMapper.getStoreUser(idx);
				String storeName = storeUser.get("storeName").toString();
				String storeMobile = storeUser.get("storeMobile").toString();
				String oneclick0 = "192.168.25.5:8080/happyhour/lineup/oneclick/0/"+date+"/"+time+"?idx="+lineup.getIdx();		        
		        System.out.println(oneclick0);
				String oneclick5 = "192.168.25.5:8080/happyhour/lineup/oneclick/5/"+date+"/"+time+"?idx="+lineup.getIdx();
				NaverShortUrl shortUrl = new NaverShortUrl();
				JSONParser jsonParser = new JSONParser();
				String mataData = "";
				try {
					mataData = shortUrl.shortUrl(oneclick0);
					JSONObject jobj = (JSONObject) jsonParser.parse(mataData);
					Gson gson = new Gson();
					JSONObject jobjResult = (JSONObject) jsonParser.parse(gson.toJson(jobj.get("result")));
					oneclick0 = jobjResult.get("url").toString();
					mataData = shortUrl.shortUrl(oneclick5);
					jobj = (JSONObject) jsonParser.parse(mataData);
					jobjResult = (JSONObject) jsonParser.parse(gson.toJson(jobj.get("result")));
					oneclick5 = jobjResult.get("url").toString();
				} catch (org.json.simple.parser.ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				String cont = new String("["+storeName+"]\n예약: "+date+" "+time+"\n승인: "+oneclick0+"\n반려: "+oneclick5);
				System.out.println(cont);
				if (lineup.getLineup_yn() == 2 && result > 0) {
					NaverSmsService naverSms = new NaverSmsService();
					naverSms.sendSms(storeMobile, cont, null, null, null, "LMS");
				}
			}
		}else {
			result = lineupMapper.updateLineup(lineup);
		}
		return result;
	}

	@Override
	public List<LineupDTO> getLineupAll(SearchParam param) {
		// TODO Auto-generated method stub
		return lineupMapper.getLineupAll(param);
	}

	@Override
	public int visitTeam(Map<String, Object> param) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException {
		// TODO Auto-generated method stub
		NaverSmsService naverSms = new NaverSmsService();
		String recipient = "";
		String msg = "";
		
		if ("1".equals(param.get("path").toString()) && "2".equals(param.get("visit").toString())) {			
			LineupDTO nowTeam = lineupMapper.nowTeam(param);
			recipient = nowTeam.getLineup_tel();
			msg = "대기순번에 방문하지 않으셔서 줄서기가 취소되었습니다.";			
			naverSms.sendSms(recipient, msg, null, null, null, "SMS");
		}
		
		if ("2".equals(param.get("path").toString()) && ("3".equals(param.get("visit").toString())|| "2".equals(param.get("visit").toString()))) {
			LineupDTO nowTeam = lineupMapper.nowTeam(param);
			String smsId = nowTeam.getSms_id();
			NaverSmsResponseDTO apiResp = naverSms.sendSms(null, null ,null, null, smsId, null);
			System.out.println(apiResp);
			if ("2".equals(param.get("visit").toString())) {
				recipient = nowTeam.getLineup_tel();
				msg = "예약시간에 방문하지 않으셔서 예약이 취소되었습니다.";
				naverSms.sendSms(recipient, msg, null, null, null, "SMS");
			}
		}
		
		int result = lineupMapper.visitTeam(param);
			
		if ("1".equals(param.get("path").toString()) && result == 1) {
			param.put("idx", null);
			LineupDTO nextTeam = lineupMapper.nowTeam(param);
			
			if (nextTeam != null) {				
				recipient = nextTeam.getLineup_tel();
				msg = "다음 입장순번입니다. 지금 바로 방문해주세요.";
				naverSms.sendSms(recipient, msg, null, null, null, "SMS");			
			}
		}
		return result;
	}

	@Override
	public boolean isMyLineup(int userIdx, int idx) {
		// TODO Auto-generated method stub
		Map<String, Object> isMyLineup = lineupMapper.isMyLineup(idx);
		int user = Integer.parseInt(isMyLineup.get("USER").toString().trim());
		int store = Integer.parseInt(isMyLineup.get("STORE").toString().trim());
		return userIdx == user || userIdx == store;
	}

	@Override
	public int oneclick(int idx, String dateTime, int approval, String userMsg) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException {
		// TODO Auto-generated method stub
		String reserveTime = null;
		String reserveTimeZone ="Asia/Seoul";	
			
		String standard = dateTime+":00";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			Date date = df.parse(standard);
			Calendar cal = Calendar.getInstance();
		    cal.setTime(date);
		    cal.add(Calendar.HOUR, +8);
		    df.setTimeZone(TimeZone.getTimeZone("UTC"));
		    String beforeHour = df.format(cal.getTime());
		    reserveTime = beforeHour.substring(0,16);
		} catch (java.text.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println(reserveTime);
		System.out.println(reserveTimeZone);
		LineupDTO lineup = new LineupDTO();
		lineup.setIdx(idx);
		lineup.setLineup_visit(approval);
		int result = lineupMapper.oneclick(lineup);
		NaverSmsService naverSms = new NaverSmsService();
		String tel = null;
		String rmsg = null;
		String msg = null;
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("idx", idx);
		LineupDTO nowTeam = lineupMapper.nowTeam(param);
		if (result > 0) {		
			tel = nowTeam.getLineup_tel();
			if (approval == 0) {
				// 예약 승인
				rmsg = dateTime+"에 예약하셨습니다.";
				NaverSmsResponseDTO apiResp = naverSms.sendSms(tel, rmsg ,reserveTime, reserveTimeZone, null, "SMS");
				String smsId = apiResp.getRequestId();
				lineup.setSms_id(smsId);
				lineupMapper.updateSmsId(lineup);
				msg = userMsg == null? dateTime+"에 예약이 확정되었습니다." : userMsg;
				naverSms.sendSms(tel, msg, null, null, null, "SMS");
			}else {
				msg = userMsg == null? "식당의 사정으로 예약이 반려되었습니다." : userMsg;
				naverSms.sendSms(tel, msg, null, null, null, "SMS");
			}			
		}
		return result;
	}
	
	
}
