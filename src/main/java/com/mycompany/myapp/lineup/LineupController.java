package com.mycompany.myapp.lineup;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.mycompany.myapp.store.StoreDTO;
import com.mycompany.myapp.store.StoreService;
import com.mycompany.myapp.user.UserDTO;

@Controller
@RequestMapping(value = "/lineup")
public class LineupController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	LineupService lineupService;

	@Autowired
	LineupMapper lineupMapper;
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	CommonUtil commonUtil;
	
	
	
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, @RequestParam(name="store", required = false) String store){
		model.addAttribute("store", store);
		return "/lineup/lineup-index";
	}
	
	@RequestMapping(value = "/myIndex", method = RequestMethod.GET)
	public String myIndex(Model model, HttpSession session){
		if (session.getAttribute("loginUser") != null) {
			UserDTO user = (UserDTO) session.getAttribute("loginUser");
			model.addAttribute("userIdx", user.getOrigin_num());
		}
		return "/myLineup/myLineup-index";
	}

	@RequestMapping(value = {"/list", "/list/{path}"}, method = RequestMethod.GET)
	public String list(Model model, @PathVariable(name="path", required = false) String path,
			@RequestParam(name="store", required = false) String store,
			@RequestParam(name="userIdx", required = false) String userIdx,
			@RequestParam(name="myOrStore", required = false) String myOrStore,
			@RequestParam(name="past", required = false) String past, 
			HttpSession session){
		
		// path = 줄서기/예약
		// store = 식당id
		// userIdx = 로그인한 유저의 origin_num
		// myOrStore = 'myPage' 마이페이지로 접속(내 리스트) / 'store' 식당관리로 접속(식당 리스트)
		
		logger.info("lineup list", model);
		System.out.println("lineup list");
		
		
		SearchParam param = new SearchParam();
		Calendar cal = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String today = df.format(cal.getTime())+" 00:00:00";
		String todayEnd = df.format(cal.getTime())+" 23:59:59";
		param.setToday(today);
		param.setTodayEnd(todayEnd);
		param.setPath(Integer.parseInt(path));
		model.addAttribute("path", path);			
		
		if (store != null && store != "") {		
			param.setStore(Integer.parseInt(store));
			model.addAttribute("store", store);
		}
		
		if (userIdx != null && userIdx != "" && myOrStore.equals("myPage")) {		
			param.setIdx(Integer.parseInt(userIdx));
			model.addAttribute("userIdx", userIdx);
		}
		
		int waiting = 0;
		if (path.equals("1") && store != null && store != "") {
			waiting = lineupService.countWaiting(param);
			model.addAttribute("waiting",waiting );
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
		}
		
		
		if (path.equals("1") && userIdx != null && userIdx != "" && myOrStore.equals("myPage")) {
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
		
		if (store != null && store != "" && !myOrStore.equals("myPage")) {			
			return "/lineup/lineup-list";
		}else {
			return "/myLineup/myLineup-list";
		}
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(Model model, @RequestParam(name="idx", required = false) int idx) {
		logger.info("lineup detail", model);
		System.out.println("lineup detail - idx: "+ idx);
		
		
		
		return "/lineup/lineup-detail";
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.GET)
	public String enroll(Model model, @RequestParam(name="store", required = false) String store,
			@RequestParam(name="idx", required = false) String idx) {

		logger.info("lineup enroll", model);
		System.out.println("lineup enroll");
			
		SearchParam param = new SearchParam();
		Calendar cal = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String today = df.format(cal.getTime())+" 00:00:00";
		String todayEnd = df.format(cal.getTime())+" 23:59:59";
		param.setToday(today);
		param.setTodayEnd(todayEnd);
		param.setStore(Integer.parseInt(store));
		int waiting = lineupService.countWaiting(param);
		model.addAttribute("waiting",waiting );
		
		List<String> dateSet = new ArrayList<String>();
		for (int i = 1; i < 4; i++) {			
			cal.add(Calendar.DATE, +1);
			dateSet.add(df.format(cal.getTime()));
		}
		
		List<String> timeSet = commonUtil.timeSet();
		
		StoreDTO storeDt = storeService.getStoreDt(Integer.parseInt(store));
		
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
			
			if (storeDt.getStore_break() == 0) {
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
			if (storeDt.getStore_break() == 0) {			
				if (breakStartIndex <= i && i < breakEndIndex) {
					timeSet.set(i, "-");
				}		
			}
		}
					
		model.addAttribute("dateSet", dateSet);
		model.addAttribute("timeSet", timeSet);
	    model.addAttribute("store_origin", store); 
		
		return "/lineup/lineup-enroll";
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollAction(Model model, HttpSession session, @ModelAttribute(value = "lineup") LineupDTO lineup,
			HttpServletRequest request) throws ParseException, InvalidKeyException, JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException{
		logger.info("lineup enroll - action", model);
		System.out.println("lineup enroll - action");
		
		if (session.getAttribute("loginUser") != null) {
			UserDTO user = (UserDTO) session.getAttribute("loginUser");
			lineup.setUser_origin(user.getOrigin_num());
			lineup.setRegist_id(user.getId());
			lineup.setUpdate_id(user.getId());
		}
				
		String msg = "";

		int result = 0;
		if (lineup.getIdx() == null|| lineup.getIdx() == 0 ) {
			/*
			 * 등록*/
			msg = "등록";
		}else {
			/*
			 * 수정*/
			msg = "수정";
		}
		result = lineupService.enroll(lineup, msg);

		if (result == 0) {
			msg = msg+" 실패";
		} else {
			msg = msg+" 성공";
		}
		
		
		return commonUtil.addMsgLoc(model, msg, "/happyhour/store/detail?idx="+lineup.getStore_origin());
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
		
		UserDTO user = new UserDTO();
		if (session.getAttribute("loginUser") != null) {
			user = (UserDTO) session.getAttribute("loginUser");
		}
		String msg = "";
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
			return commonUtil.addMsgBack(model, msg);
		}else {
			msg = msg+" 성공";
			String url="/happyhour/lineup/list";
			if (path != null && path != "") {
				url += "/"+path;
				if (store != null && store != "") {
					url += "?store="+store+"&myOrStore=store";
				}else {
					url += "?userIdx="+user.getOrigin_num()+"&myOrStore=myPage";
				}
			}
			return commonUtil.addMsgLoc(model, msg, url);
		}
		
	}


}
