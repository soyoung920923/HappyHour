package com.mycompany.myapp.lineup;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mycompany.common.CommonUtil;
import com.mycompany.common.SearchParam;
import com.mycompany.myapp.HomeController;
import com.mycompany.myapp.holiday.HolidayDTO;
import com.mycompany.myapp.holiday.HolidayMapper;
import com.mycompany.myapp.store.StoreDTO;
import com.mycompany.myapp.store.StoreMapper;
import com.mycompany.myapp.store.StoreService;
import com.mycompany.myapp.user.UserDTO;

@Controller
@RequestMapping(value = "/lineup")
public class LineupController {

	private static final Logger logger = LoggerFactory.getLogger(LineupController.class);

	@Autowired
	LineupService lineupService;

	@Autowired
	LineupMapper lineupMapper;
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	StoreMapper storeMapper;
	
	@Autowired
	HolidayMapper holidayMapper;
	
	@Autowired
	CommonUtil commonUtil;
	
	@RequestMapping(value = "/myIndex", method = RequestMethod.GET)
	public String myIndex(Model model, HttpSession session){
		String rt = "";
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			rt = "/myLineup/myLineup-index";
		}else {
			rt = commonUtil.addMsgBack(model, "잘못된 접근입니다.");
		}
		return rt;
	}
	
	@RequestMapping(value = "/myStore", method = RequestMethod.GET)
	public String myStore(Model model, HttpSession session){
		
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			model.addAttribute("userIdx", user.getOrigin_num());			
			int userDt = Integer.parseInt(user.getUser_dt());
			if (userDt == 2) {
				SearchParam param = new SearchParam();
				param.setIdx(user.getOrigin_num());
				List<StoreDTO> myStore = storeService.getStoreAll(param);
				model.addAttribute("myStore", myStore);
				return "/store/store-index";
			}else {
				return commonUtil.addMsgBack(model, "잘못된 접근입니다.");
			}
		}else {
			return commonUtil.addMsgLoc(model, "로그인 후 이용해주세요.", "/happyhour/login");
		}
	}

	@RequestMapping(value = {"/list", "/list/{path}"}, method = RequestMethod.GET)
	public String list(Model model, @PathVariable(name="path", required = false) String path,		
			@RequestParam(name="store", required = false) String store,		  
			@RequestParam(name="myOrStore", required = false) String myOrStore, 		  
			@RequestParam(name="past", required = false) String past,		 
			HttpSession session){
		
		// path = 줄서기/예약
		// store = 식당id
		// userIdx = 로그인한 유저의 origin_num
		// myOrStore = 'myPage' 마이페이지로 접속(내 리스트) / 'store' 식당관리로 접속(식당 리스트)
		
		logger.info("lineup list", model);
		System.out.println("lineup list");
		
		String rt = "";
		
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			int userIdx = user.getOrigin_num();
			String userDt = user.getUser_dt();
			
			SearchParam param = new SearchParam();
			Calendar cal = Calendar.getInstance();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String today = df.format(cal.getTime())+" 00:00:00";
			String todayEnd = df.format(cal.getTime())+" 23:59:59";
			param.setToday(today);
			param.setTodayEnd(todayEnd);
			param.setPath(Integer.parseInt(path));
			model.addAttribute("path", path);			
			
			if (user != null && "2".equals(userDt) && "store".equals(myOrStore)) {
				if (store != null && store != "") {
					if (storeService.isMyStore(userIdx, Integer.parseInt(store))) {						
						param.setStore(Integer.parseInt(store));
						model.addAttribute("store", store);
						StoreDTO dto = storeMapper.getStoreDt(Integer.parseInt(store));
						model.addAttribute("storeNm", dto.getStore_Nm());
						int service = 0;
						if ("1".equals(path)) {
							service = dto.getLine_yn();
						}else {
							service = dto.getRsv_yn();
						}
						model.addAttribute("service", service);
						rt = "/lineup/lineup-list";
					}else {
						rt = commonUtil.addMsgBack(model, "잘못된 접근입니다.");
					}
				}
			}
			
			int waiting = 0;
			// isMyLinup: 마이페이지>줄서기/예약 메뉴로 접근
			boolean isMyLinup = user != null && "myPage".equals(myOrStore);
			if (isMyLinup) {
				param.setIdx(userIdx);
				model.addAttribute("userIdx", userIdx);
				waiting = lineupService.countWaiting(param);
				model.addAttribute("waiting",waiting );
				rt = "/myLineup/myLineup-list";
			}
			
			if (past != null && past != "") {
				param.setPast(past);
				model.addAttribute("past",past );
			}
			
			int total = lineupMapper.getTotalCount(param);
			
			param.setStartCount(0);
			param.setEndCount(5);
			//param.setViewCount(5);
			param.setTotalCount(total);
			
			List<LineupDTO> list = lineupService.getLineupAll(param);
			
			String lineupDate = "";
			for (int i = 0; i < list.size(); i++) {
				lineupDate = list.get(i).getLineup_Date();
				lineupDate = lineupDate.substring(0,16);
				list.get(i).setLineup_Date(lineupDate);
				param.setStore(list.get(i).getStore_origin());
				int cnt = 0;
				int visitTeamIdx = 0;
				if (cnt < 2 && list.get(i).getLineup_visit() == 0) {
					visitTeamIdx = list.get(i).getIdx();
					cnt ++;
				}
				model.addAttribute("visitTeamIdx", visitTeamIdx);
			}
			
			
			if (isMyLinup) {
				int storeOrigin = 0;
				int idx = 0;
				for (int i = 0; i < list.size(); i++) {
					storeOrigin = list.get(i).getStore_origin();
					idx = list.get(i).getIdx();
					param.setStore(storeOrigin);
					param.setIdx(idx);
					waiting = lineupService.countWaiting(param);
					list.get(i).setWaiting(waiting);
					
				}
			}
			
			model.addAttribute("total", total);
			model.addAttribute("list", list);
			
			
		}else {
			rt = commonUtil.addMsgLoc(model, "로그인 후 이용해주세요.", "/happyhour/login");			
		}
		
		return rt;
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.GET)
	public String enroll(Model model, @RequestParam(name="store", required = false) String store, HttpSession session) {

		logger.info("lineup enroll", model);
		System.out.println("lineup enroll");
		
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {			
			SearchParam param = new SearchParam();
			Calendar cal = Calendar.getInstance();
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); // 오늘 요일
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String today = df.format(cal.getTime())+" 00:00:00";
			String todayEnd = df.format(cal.getTime())+" 23:59:59";
			param.setToday(today);
			param.setTodayEnd(todayEnd);
			param.setStore(Integer.parseInt(store));
			int waiting = lineupService.countWaiting(param);
			model.addAttribute("waiting",waiting );
			
			StoreDTO storeDt = storeService.getStoreDt(Integer.parseInt(store));
			param.setIdx(Integer.parseInt(store));
			List<HolidayDTO> tempHolidays = holidayMapper.getHolidays(param);
			
			List<String> dateSet = new ArrayList<String>();
			int rsvDay = 0;
			for (int i = 0; i < 3; i++) {			
				cal.add(Calendar.DATE, +1);
				
				String dateSetDay = df.format(cal.getTime());
				String holidayStart = null;
				String holidayEnd = null;
				int ii = 0;
				for (int j = 0; j < tempHolidays.size(); j++) {
					Calendar start = Calendar.getInstance();
					Calendar end = Calendar.getInstance();
					holidayStart = tempHolidays.get(j).getHoliday_start();
					holidayEnd = tempHolidays.get(j).getHoliday_end();
					try {
						Date hStart = df.parse(holidayStart);
						Date hEnd = df.parse(holidayEnd);
						start.setTime(hStart);
						end.setTime(hEnd);					
						while (dateSetDay.equals(df.format(start.getTime())) && ii < 1) {
							cal.add(Calendar.DATE, +1);
							start.add(Calendar.DATE, +1);
							ii++;

							int a = (int) start.getTime().getTime();
							int b = (int) end.getTime().getTime();
							
							if (a>b) {
								System.out.println("탈출");
								break;
							}else {
								System.out.println("반복");
							}
						}
					} catch (java.text.ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				rsvDay = cal.get(Calendar.DAY_OF_WEEK); // 예약일 요일
				// 휴무일 정보로 오늘 휴무인지 여부 및 예약일 세팅
				for (int j = 0; j < storeDt.getHolidays().length; j++) {
					if (dayOfWeek == Integer.parseInt(storeDt.getHolidays()[j])) {
						storeDt.setHoliday("holiday");
					}
					if (rsvDay == Integer.parseInt(storeDt.getHolidays()[j])) {
						cal.add(Calendar.DATE, +1);
					}
				}
				dateSet.add(df.format(cal.getTime()));
			}			
			List<String> timeSet = commonUtil.timeSet();
			
			
			
			
			int openIndex = 0;
			int closeIndex = 0;
			int breakStartIndex = 0;
			int breakEndIndex = 0;
					
			for (int i = 0; i < timeSet.size(); i++) {
				String time = timeSet.get(i);
				if ( !("00:00".equals(storeDt.getStore_open()) && "00:00".equals(storeDt.getStore_close()))) {
					if (time.equals(storeDt.getStore_open())) {
						openIndex = i;
					}
					if (time.equals(storeDt.getStore_close())) {
						closeIndex = i;
					}
				}
				
				if (storeDt.getStore_break() == 1) {
					if (time.equals(storeDt.getBreak_start())) {
						breakStartIndex = i;
					}
					if (time.equals(storeDt.getBreak_end())) {
						breakEndIndex = i;
					}
				}
				
			}
			
			for (int i = 0; i <  timeSet.size(); i++) {
				if ( !("00:00".equals(storeDt.getStore_open()) && "00:00".equals(storeDt.getStore_close()))) {
					
					if (i < openIndex) {
						timeSet.set(i, "-");
					}
					if (i > closeIndex) {
						timeSet.set(i, "-");
					}
				}
				if (storeDt.getStore_break() == 1) {			
					if (breakStartIndex <= i && i < breakEndIndex) {
						timeSet.set(i, "-");
					}		
				}
			}
			
			model.addAttribute("dateSet", dateSet);
			model.addAttribute("timeSet", timeSet);
			model.addAttribute("store_origin", store);
			model.addAttribute("storeDt", storeDt);
			
			return "/lineup/lineup-enroll";
		}else {
			return commonUtil.addMsgLoc(model, "로그인 후 이용해주세요.", "/happyhour/login");
		}
		
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollAction(Model model, HttpSession session, @ModelAttribute(value = "lineup") LineupDTO lineup,
			HttpServletRequest request) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException{
		logger.info("lineup enroll - action", model);
		System.out.println("lineup enroll - action");
		
		String msg = "";
		String rt = "";
		UserDTO user = commonUtil.getUser(session);
		
		if (user != null) {		
			lineup.setUser_origin(user.getOrigin_num());
			lineup.setRegist_id(user.getId());
			lineup.setUpdate_id(user.getId());
			
			int result = 0;
			if (lineup.getIdx() == null|| lineup.getIdx() == 0 ) {
				/*등록*/
				msg = "등록";
			}else {
				/*수정*/
				msg = "수정";
			}
			
			result = lineupService.enroll(lineup, msg);
			
			if (result == 0) {
				msg = msg+" 실패";
			} else {
				msg = msg+" 성공";
			}
			rt = commonUtil.addMsgLoc(model, msg, "/happyhour/store/detail?idx="+lineup.getStore_origin());
		}else {
			msg = "로그인 후 이용해주세요.";
			rt = commonUtil.addMsgLoc(model, msg, "/happyhour/login"); 
		}
					
		return rt;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMoreList", method = RequestMethod.POST)
	public Map<String, Object> moreList(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		
		SearchParam param = new SearchParam();
		
		param.setStartCount(Integer.parseInt(req.getParameter("startCount")));
		param.setEndCount(Integer.parseInt(req.getParameter("startCount"))+Integer.parseInt(req.getParameter("viewCount")));
		//param.setViewCount(Integer.parseInt(req.getParameter("viewCount")));
		param.setTotalCount(Integer.parseInt(req.getParameter("totalCount")));
		Calendar cal = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String today = df.format(cal.getTime())+" 00:00:00";
		String todayEnd = df.format(cal.getTime())+" 23:59:59";
		param.setToday(today);
		param.setTodayEnd(todayEnd);
		if (req.getParameter("userIdx") != null && req.getParameter("userIdx") != "") {
			param.setIdx(Integer.parseInt(req.getParameter("userIdx")));
		}
		
		String path = req.getParameter("path");
		if (path != null && path != "") {
			param.setPath(Integer.parseInt(path));
		}
		String store = req.getParameter("store");
		if (store != null && store != "") {
			param.setStore(Integer.parseInt(store));
		}
		String past = req.getParameter("past");
		if (past != null && past != "") {
			param.setPast(past);
		}
		
		List<LineupDTO> resultList = lineupService.getLineupAll(param);
		String lineupDate = "";
		for (int i = 0; i < resultList.size(); i++) {
			lineupDate = resultList.get(i).getLineup_Date();
			lineupDate = lineupDate.substring(0,16);
			resultList.get(i).setLineup_Date(lineupDate);
			if (path.equals("1") && req.getParameter("userIdx") != null && req.getParameter("userIdx") != "" && req.getParameter("myOrStore").equals("myPage")) {
				int storeOrigin = 0;
				int idx = 0;
				int waiting = 0;
				storeOrigin = resultList.get(i).getStore_origin();
				idx = resultList.get(i).getIdx();
				param.setStore(storeOrigin);
				param.setIdx(idx);
				waiting = lineupService.countWaiting(param);
				resultList.get(i).setWaiting(waiting);			
			}
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("resultList", resultList);
		result.put("resultCnt",resultList.size());
		
		return result;
	}
	
	@RequestMapping(value = "/visitTeam", method = RequestMethod.GET)
	public String visitTeam(Model model, @RequestParam(name="visit", required = false) int visit,
			@RequestParam(name="idx", required = false) int idx,
			@RequestParam(name="path", required = false) String path,
			@RequestParam(name="store", required = false) String store, HttpSession session) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException{
		
		UserDTO user = commonUtil.getUser(session);
		String msg = "";
		String rt = "";
		String url = "";
		if (user != null) {
			int userIdx = user.getOrigin_num();
			
			if (idx == 0) {
				msg = "입장할 팀이 없습니다.";
				rt = commonUtil.addMsgBack(model, msg);
			}else {	
				boolean isMyLineup = lineupService.isMyLineup(userIdx, idx);
				if (isMyLineup) {	
					
					Map<String, Object> param = new HashMap<String, Object>();	
					param.put("visit", visit);
					param.put("idx", idx);
					param.put("path", path);
					param.put("store", store);
					Calendar cal = Calendar.getInstance();
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					String today = df.format(cal.getTime())+" 00:00:00";
					String todayEnd = df.format(cal.getTime())+" 23:59:59";
					param.put("today", today);
					param.put("todayEnd", todayEnd);
					int i = lineupService.visitTeam(param);
					if (visit == 1) {
						msg = "입장 처리";
					}else if(visit == 2){
						msg = "노쇼 처리";
					}else {
						if (path.equals("1")) {
							msg = "줄서기 취소";
						}else {
							msg = "예약 취소";
						}
					}
					if (i == 0) {
						msg = msg+" 실패";
						rt = commonUtil.addMsgBack(model, msg);
					}else {
						msg = msg+" 성공";
						url="/happyhour/lineup/list";
						if (path != null && path != "") {
							url += "/"+path;
							if (store != null && store != "") {
								url += "?store="+store+"&myOrStore=store";
							}else {
								url += "?userIdx="+user.getOrigin_num()+"&myOrStore=myPage";
							}
						}
						rt = commonUtil.addMsgLoc(model, msg, url);
					}
					
				}else {
					msg = "잘못된 접근입니다.";
					rt = commonUtil.addMsgBack(model, msg);
				}
			}
		}else {
			msg = "로그인 후 이용해주세요.";
			url = "/happyhour/login";
			rt = commonUtil.addMsgLoc(model, msg, url);
		}
		return rt;
		
	}
	
	@ResponseBody
	@RequestMapping(value = {"/oneclick/{approval}/{date}/{time}", "/oneclick"}, method= {RequestMethod.GET,  RequestMethod.POST})
	public String oneclick(Model model, @RequestParam(name="idx", required = false) Integer idx,
			@PathVariable(name="date", required = false) String date,
			@PathVariable(name="time", required = false) String time,
			@PathVariable(name="approval", required = false) Integer approval,
			HttpServletRequest request, HttpSession session) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException {
		approval = approval == null ? 0 : approval;
		idx = idx == 0 ? Integer.parseInt(request.getParameter("lidx")) : idx;
		int result = 0;
		String msg = "";
		String url = "";
		String rt = "";
		String dateTime = date == null ? request.getParameter("dateTime") : date+" "+time;
		String userMsg = request.getParameter("userMsg");	
		if (userMsg == null || userMsg.equals("")) {
			/**원클릭*/
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("idx", idx);
			LineupDTO nowTeam = lineupMapper.nowTeam(param);
			if (nowTeam.getLineup_visit() == 4) {			
				result = lineupService.oneclick(idx, dateTime, approval, null);
				if (result > 0) {
					msg = "예약이 완료되었습니다.";
					url = null;			
				}else {
					msg = "처리중 에러가 발생했습니다. 예약페이지를 확인해주세요.";
					url = "/happyhour";
				}			
			}else if(nowTeam.getLineup_visit() == 5){
				msg = "이미 반려된 예약입니다.";
				url = null;	
			}else {
				msg = "이미 처리된 예약입니다.";
				url = null;	
			}
			rt = commonUtil.addMsgLoc(model, msg, url);
		}else {
			/**웹*/
			UserDTO user = commonUtil.getUser(session);
			if (user != null) {
				int userIdx = user.getOrigin_num();
				boolean isMyLineup = lineupService.isMyLineup(userIdx, idx);
				if (isMyLineup) {
					result = lineupService.oneclick(idx, dateTime, approval, userMsg);
					Map<String, Object> map = lineupMapper.getStoreUser(idx);
					if (result > 0) {
						msg = "예약이 완료되었습니다.";
					}else {
						msg = "처리 실패";
					}
					url = "/happyhour/lineup/list/2?store="+map.get("store")+"&myOrStore=store";
					rt = commonUtil.addMsgLoc(model, msg, url);
				}else {
					msg = "잘못된 접근입니다.";
					rt = commonUtil.addMsgBack(model, msg);
				}
			}
		}
	
		return rt;
	}


}
