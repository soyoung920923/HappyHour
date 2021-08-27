package com.mycompany.myapp.store;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mycompany.common.CommonUtil;
import com.mycompany.common.SearchParam;
import com.mycompany.myapp.HomeController;
import com.mycompany.myapp.holiday.HolidayDTO;
import com.mycompany.myapp.holiday.HolidayMapper;
import com.mycompany.myapp.holiday.HolidayService;
import com.mycompany.myapp.lineup.LineupDTO;
import com.mycompany.myapp.lineup.LineupMapper;
import com.mycompany.myapp.user.UserDTO;

@Controller
@RequestMapping(value = "/store")
public class StoreController {

	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);

	@Autowired
	StoreService storeService;

	@Autowired
	StoreMapper storeMapper;
	
	@Autowired
	LineupMapper lineupMapper;
	
	@Autowired
	HolidayMapper holidayMapper;
	
	@Autowired
	CommonUtil commonUtil;

	@RequestMapping(value = {"/list", "/list/{path}"})
	public String list(Model model, @PathVariable(name="path", required = false) String path, 
			@RequestParam(name="search", required = false) String search, 
			@RequestParam(name="business", required = false) String business, HttpSession session) {

		logger.info("store list", model);
		System.out.println("store list");
		
		String rt = "/store/store-list";
		String msg = "";
		
		int userIdx = 0;
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			model.addAttribute("userIdx", user.getOrigin_num());
			userIdx = user.getOrigin_num();
		}
		
		SearchParam param = new SearchParam();
		
		boolean isBusiness = (business != null && business != "");
		
		// 식당 관리 메뉴로 접근했을 때는 위치 정보를 셋팅하지 않는다.
		if (!isBusiness) {			
			@SuppressWarnings("unchecked")
			Map<String, String> myPoint = (Map<String, String>) session.getAttribute("myPoint");
			if (myPoint != null && !myPoint.isEmpty()) {			
				param.setMyLat(myPoint.get("lat"));
				param.setMyLon(myPoint.get("lon"));
			}
		}else {
			if (user != null && user.getUser_dt().equals("2")) {				
				param.setIdx(userIdx);
				rt = "/store/store-business";
			}else if(user != null && !user.getUser_dt().equals("2")){
				msg = "잘못된 접근입니다.";
				rt = commonUtil.addMsgBack(model, msg);
			}else {
				msg = "로그인 후 이용해주세요.";
				rt = commonUtil.addMsgLoc(model, msg, "/happyhour/login");
			}
		}
		
		if (search != null && search != "") {
			param.setSearch(search);
			model.addAttribute("search", search);
		}

		if (path != null && path != "") {
			param.setPath(Integer.parseInt(path));
			model.addAttribute("path", path);
		}
		
		int total = storeMapper.getTotalCount(param);
		
		param.setStartCount(0);
		param.setEndCount(5);
		//param.setViewCount(5);
		param.setTotalCount(total);
				
		List<StoreDTO> list = storeService.getStoreAll(param);
		if (isBusiness) {
			int store = 0;
			for (int i = 0; i < list.size(); i++) {
				store = list.get(i).getIdx();
				StoreDTO newAlert = lineupMapper.getNewCnt(store);
				if (newAlert != null) {					
					list.get(i).setNewRsv(newAlert.getNewRsv());
				}
			}
		}else {
			Calendar cal = Calendar.getInstance();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getHolidays() != null) {
					for (int j = 0; j < list.get(i).getHolidays().length; j++) {
						if (dayOfWeek == Integer.parseInt(list.get(i).getHolidays()[j])) {
							list.get(i).setHoliday("holiday");
						}else {
							list.get(i).setHoliday(null);
						}
					}
				}
				SearchParam param1 = new SearchParam();
				param1.setIdx(list.get(i).getIdx());
				List<HolidayDTO> tempHolidays = holidayMapper.getHolidays(param1);
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
							list.get(i).setHoliday(tempHolidays.get(j).getHoliday_status());
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
			}
			
		}

		model.addAttribute("total", total);
		model.addAttribute("list", list);
		
		return rt;
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(Model model, @RequestParam(name="idx", required = false) int idx) {
		logger.info("store detail", model);
		System.out.println("store detail - idx: "+ idx);
		
		StoreDTO store = storeService.getStoreDt(idx);
		model.addAttribute("store", store);
		
		storeMapper.hitCountPlusOne(idx);
		
		return "/store/store-detail";
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.GET)
	public String enroll(Model model, @RequestParam(name="idx", required = false) String idx, HttpSession session) {

		logger.info("store enroll", model);
		System.out.println("store enroll");
		
		String rt = "";
		String msg = "";
		
		UserDTO user = commonUtil.getUser(session);
		int userIdx = 0;
		String userDt = "";
		if (user != null) {
			model.addAttribute("userIdx", user.getOrigin_num());
			userIdx = user.getOrigin_num();
			userDt = user.getUser_dt();
			if (!"2".equals(userDt)) {
				msg = "잘못된 접근입니다.";
				rt = commonUtil.addMsgBack(model, msg);
			}else {
				List<String> timeSet = commonUtil.timeSet();
				model.addAttribute("timeSet", timeSet);				
				if (idx != null && idx != "") {
					/*수정페이지*/
					StoreDTO store = storeService.getStoreDt(Integer.parseInt(idx));
					if (store.getOrigin() != userIdx) {
						msg = "잘못된 접근입니다.";
						rt = commonUtil.addMsgBack(model, msg);
					}else {					
						model.addAttribute("store", store);
						rt = "/store/store-enroll";
					}
				}else {
					/*등록페이지*/
					rt = "/store/store-enroll";
				}						
			}
		}else {
			msg = "로그인 후 이용해주세요.";
			rt = commonUtil.addMsgLoc(model, msg, "/happyhour/login"); 
		}
		
		
		return rt;
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollAction(Model model, HttpSession session, @ModelAttribute(value = "store") StoreDTO store,
			HttpServletRequest request) {
		logger.info("store enroll - action", model);
		System.out.println("store enroll - action");

		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		
		String msg = "";
		String rt = "";
		
		UserDTO user = commonUtil.getUser(session);

		if (user != null) {
			store.setOrigin(user.getOrigin_num());
			store.setRegist_Id(user.getId());
			store.setUpdate_Id(user.getId());
			int result = 0;
			if (store.getIdx() == 0) {
				msg = "등록";
			}else {
				msg = "수정";
			}
			result = storeService.enrollStore(store, req, msg);			
			if (result == 0) {
				msg = msg+" 실패";
				rt = commonUtil.addMsgBack(model, msg);
			} else {
				msg = msg+" 성공";
				rt = commonUtil.addMsgLoc(model, msg, "/happyhour/store/list");
			}
		}else {
			msg = "로그인 후 이용해주세요.";
			rt = commonUtil.addMsgLoc(model, msg, "/happyhour/login");
		}
	
		return rt;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMoreList", method = RequestMethod.POST)
	public Map<String, Object> moreList(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		
		int userIdx = 0;
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			model.addAttribute("userIdx", user.getOrigin_num());
			userIdx = user.getOrigin_num();
		}
		
		SearchParam param = new SearchParam();
		
		boolean isBusiness = (req.getParameter("business") != null && req.getParameter("business") != "");
		
		// 식당 관리 메뉴로 접근했을 때는 위치 정보를 셋팅하지 않는다.
		if (!isBusiness) {			
			@SuppressWarnings("unchecked")
			Map<String, String> myPoint = (Map<String, String>) session.getAttribute("myPoint");
			if (myPoint != null && !myPoint.isEmpty()) {			
				param.setMyLat(myPoint.get("lat"));
				param.setMyLon(myPoint.get("lon"));
			}
		}else {
			if (user != null && user.getUser_dt().equals("2")) {				
				param.setIdx(userIdx);
			}
		}
		
		param.setStartCount(Integer.parseInt(req.getParameter("startCount")));
		param.setEndCount(Integer.parseInt(req.getParameter("startCount"))+Integer.parseInt(req.getParameter("viewCount")));
		//param.setViewCount(Integer.parseInt(req.getParameter("viewCount")));
		param.setTotalCount(Integer.parseInt(req.getParameter("totalCount")));
		
		
		
		String path = req.getParameter("path");
		if (path != null && path != "") {
			param.setPath(Integer.parseInt(path));
		}
		String search = req.getParameter("search");
		if (search != null && search != "") {
			param.setSearch(search);
		}
		
		List<StoreDTO> resultList = storeService.getStoreAll(param);
		
		Calendar cal = Calendar.getInstance();
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		for (int i = 0; i < resultList.size(); i++) {
			if (resultList.get(i).getHolidays() != null) {
				for (int j = 0; j < resultList.get(i).getHolidays().length; j++) {
					if (dayOfWeek == Integer.parseInt(resultList.get(i).getHolidays()[j])) {
						resultList.get(i).setHoliday("holiday");
					}
				}
			}
			
		}
				
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("resultList", resultList);
		result.put("resultCnt",resultList.size());
		
		return result;
	}
	
	@RequestMapping(value = "/deleteStore", method = RequestMethod.POST)
	public String deleteStore(Model model, HttpServletRequest request, @ModelAttribute(value = "store") StoreDTO store, HttpSession session) {
		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		String rt = "";
		String msg = "";
		int userIdx = 0;
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			model.addAttribute("userIdx", user.getOrigin_num());
			userIdx = user.getOrigin_num();
			int idx = store.getIdx();
			boolean isMyStore = storeService.isMyStore(userIdx, idx);
			if (isMyStore) {		
				int result = storeService.deleteStore(req, idx);
				if (result == 0) {
					msg = "삭제 실패";
					rt = commonUtil.addMsgBack(model, msg);
				}else {		
					msg = "삭제 성공";
					rt = commonUtil.addMsgLoc(model, msg, "/happyhour/store/list");		
				}
			}else {
				msg = "잘못된 접근입니다.";
				rt = commonUtil.addMsgBack(model, msg);
			}
		}else {
			msg = "로그인 후 이용해주세요.";
			rt = commonUtil.addMsgLoc(model, msg, "/happyhour/login");
		}
		
		return rt;
	}
	
	@RequestMapping(value = "/setting/{path}", method = RequestMethod.POST)
	public String setting(Model model, HttpServletRequest request, 
			@PathVariable(name="path", required = false) Integer path, 
			@RequestParam(name="idx", required = false) Integer idx,
			HttpSession session) {
		String rt = "";
		String msg = "";
		int userIdx = 0;
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			userIdx = user.getOrigin_num();
			boolean isMyStore = storeService.isMyStore(userIdx, idx);
			if (isMyStore) {
				StoreDTO store = new StoreDTO();
				store.setIdx(idx);
				if (path == 1) {
					store.setLine_yn(Integer.parseInt(request.getParameter("serviceYn")));
					store.setLine_notice(request.getParameter("noticeMsg"));
				}else {
					store.setRsv_yn(Integer.parseInt(request.getParameter("serviceYn")));
					store.setRsv_notice(request.getParameter("noticeMsg"));
				}
				int result = storeMapper.updateService(store);
				if (result == 0) {
					msg = "수정 실패";
					rt = commonUtil.addMsgBack(model, msg);
				}else {		
					msg = "수정 성공";
					rt = commonUtil.addMsgLoc(model, msg, "/happyhour/lineup/list/"+path+"store="+idx+"&myOrStore=store");		
				}
			}else {
				msg = "잘못된 접근입니다.";
				rt = commonUtil.addMsgBack(model, msg);
			}
		}else {
			msg = "로그인 후 이용해주세요.";
			rt = commonUtil.addMsgLoc(model, msg, "/happyhour/login");
		}
		return rt;	
	}
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String holiday(Model model, HttpServletRequest request, 
			@RequestParam(name="idx", required = false) Integer idx,
			HttpSession session) {
		String rt = "";
		String msg = "";
		int userIdx = 0;
		UserDTO user = commonUtil.getUser(session);
		if (user != null) {
			userIdx = user.getOrigin_num();
			boolean isMyStore = storeService.isMyStore(userIdx, idx);
			if (isMyStore) {
				rt = "/store/store-board";
				StoreDTO store = storeService.getStoreDt(idx);
				model.addAttribute("store", store);
				
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM");
				SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
				List<List<LineupDTO>> totalList = new ArrayList<List<LineupDTO>>();
				// 이번달 줄서기count
				Map<String, String> map = new HashMap<String, String>();
				
				map.put("idx", idx.toString());
				map.put("start", df1.format(cal.getTime())+"-01 00:00:00");
				map.put("end", df2.format(cal.getTime())+" 00:00:00");
				map.put("path", "1");
				List<LineupDTO> nowMonthLine = lineupMapper.getCount(map);
				totalList.add(nowMonthLine);				
			
				// 이번달 예약count
				map.put("path", "2");				
				List<LineupDTO> nowMonthRsv = lineupMapper.getCount(map);
				totalList.add(nowMonthRsv);	
				
				// 지난달
				cal.add(Calendar.MONTH, -1);
				int lastMonth = cal.get(Calendar.MONTH);
				int monthEnd = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				String lastMonthDiv = String.valueOf(lastMonth);
				lastMonthDiv = lastMonth < 10 ? "0".concat(lastMonthDiv) : lastMonthDiv;
				// 지난달 줄서기count
				map.put("start", df1.format(cal.getTime())+"-01 00:00:00");
				map.put("end", df1.format(cal.getTime())+"-"+monthEnd+" 00:00:00");
				map.put("path", "1");				
				List<LineupDTO> lastMonthLine = lineupMapper.getCount(map);
				totalList.add(lastMonthLine);
				// 지난달 예약count
				map.put("path", "2");							
				List<LineupDTO> lastMonthRsv = lineupMapper.getCount(map);
				totalList.add(lastMonthRsv);
				
				List<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
				Map<String, String> result = new HashMap<String, String>();
				
				for (List<LineupDTO> list : totalList) {
					int total = list.size();
					int visit = 0;
					int noshow = 0;
					int cancel = 0;
					int etc = 0;
					double visitRate = 0.00;
					for (int i = 0; i < list.size(); i++) {
						if (list.get(i).getLineup_visit() == 1) {
							visit++;
						}else if(list.get(i).getLineup_visit() == 2) {
							noshow++;
						}else if (list.get(i).getLineup_visit() == 3) {
							cancel++;
						}else {
							etc++;
						}
					}			
					if (visit != 0) {
						visitRate = visit / total * 100.00;
					}
					result.put("total", String.valueOf(total));
					result.put("visit", String.valueOf(visit));
					result.put("noshow", String.valueOf(noshow));
					result.put("cancel", String.valueOf(cancel));
					result.put("etc", String.valueOf(etc));
					result.put("visitRate", String.valueOf(visitRate));
					resultList.add(result);
				}
				model.addAttribute("resultList", resultList);
				
			}else {
				msg = "잘못된 접근입니다.";
				rt = commonUtil.addMsgBack(model, msg);
			}
		}else {
			msg = "로그인 후 이용해주세요.";
			rt = commonUtil.addMsgLoc(model, msg, "/happyhour/login");
		}
		return rt;
	}

}
