package com.mycompany.myapp.lineup;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mycompany.common.CommonUtil;
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
			
			String reserveTime =null;
			String reserveTimeZone ="Asia/Seoul";
			String dateTime = "";
			if (lineup.getLineup_yn() == 2) {
				
				String standard = lineup.getDate()+" "+lineup.getTime()+":00";
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
				
				
				dateTime = lineup.getDate()+" "+lineup.getTime()+":00";
				lineup.setDateTime(dateTime);
				
				System.out.println(reserveTime);
				System.out.println(reserveTimeZone);
			}
			
			result = lineupMapper.insertLineup(lineup);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("idx", lineup.getIdx());
			LineupDTO nowTeam = lineupMapper.nowTeam(param);
			
			String cont = dateTime+"에 예약하셨습니다.";
			String msg2 = new String(cont.getBytes("utf-8"), "euc-kr");
			if (lineup.getLineup_yn() == 2 && result > 0) {
				NaverSmsService naverSms = new NaverSmsService();
				NaverSmsResponseDTO apiResp = naverSms.sendSms(nowTeam.getLineup_tel(), msg2 ,reserveTime, reserveTimeZone, null);
				String smsId = apiResp.getRequestId();
				lineup.setSms_id(smsId);
				result = lineupMapper.updateSmsId(lineup);
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
			String msg2 = new String(msg.getBytes("utf-8"), "euc-kr");
			naverSms.sendSms(recipient, msg2, null, null, null);
		}
		
		if ("2".equals(param.get("path").toString()) && ("3".equals(param.get("visit").toString())|| "2".equals(param.get("visit").toString()))) {
			LineupDTO nowTeam = lineupMapper.nowTeam(param);
			String smsId = nowTeam.getSms_id();
			NaverSmsResponseDTO apiResp = naverSms.sendSms(null, null ,null, null, smsId);
			System.out.println(apiResp);
			if ("2".equals(param.get("visit").toString())) {
				recipient = nowTeam.getLineup_tel();
				msg = "예약시간에 방문하지 않으셔서 예약이 취소되었습니다.";
				String msg2 = new String(msg.getBytes("utf-8"), "euc-kr");
				naverSms.sendSms(recipient, msg2, null, null, null);
			}
		}
		
		int result = lineupMapper.visitTeam(param);
			
		if ("1".equals(param.get("path").toString()) && result == 1) {
			param.put("idx", null);
			LineupDTO nextTeam = lineupMapper.nowTeam(param);
			
			if (nextTeam != null) {				
				recipient = nextTeam.getLineup_tel();
				msg = "다음 입장순번입니다. 지금 바로 방문해주세요.";
				String msg2 = new String(msg.getBytes("utf-8"), "euc-kr");
				naverSms.sendSms(recipient, msg2, null, null, null);			}
		}
		return result;
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
}
