package com.mycompany.myapp.holiday;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.common.CommonUtil;
import com.mycompany.common.SearchParam;
import com.mycompany.myapp.store.StoreController;
import com.mycompany.myapp.store.StoreDTO;
import com.mycompany.myapp.store.StoreMapper;
import com.mycompany.myapp.store.StoreService;
import com.mycompany.myapp.user.UserDTO;

@Controller
@RequestMapping(value = "/holiday")
public class HolidayController {
	
	private static final Logger logger = LoggerFactory.getLogger(HolidayController.class);
	
	@Autowired
	HolidayService holidayService;
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	HolidayMapper holidayMapper;
	
	@Autowired
	CommonUtil commonUtil;
	
	
	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollAction(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("holiday enroll - action", model);
		System.out.println("holiday enroll - action");
		
		String msg = "";
		String rt = "";
		
		UserDTO user = commonUtil.getUser(session);
		int userIdx = 0;
		int store = 0;
		if (user != null) {
			userIdx = user.getOrigin_num();
			store = Integer.parseInt(request.getParameter("hstore"));
			boolean isMyStore = storeService.isMyStore(userIdx, store);
			if (isMyStore) {
				int result = holidayService.enroll(user, store, request);
				if (result < 1) {
					msg = "등록 실패";
					rt = commonUtil.addMsgBack(model, msg);
				}else {
					msg = "등록 성공";
					rt = commonUtil.addMsgLoc(model, msg, "/happyhour/holiday/list?store="+store);
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
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, HttpSession session,
			@RequestParam(name="store", required = false) Integer store) {
		logger.info("holiday list", model);
		System.out.println("holiday list");
		
		model.addAttribute("store", store);
		String msg = "";
		String rt = "";
		
		UserDTO user = commonUtil.getUser(session);
		int userIdx = 0;
		if (user != null) {
			userIdx = user.getOrigin_num();
			boolean isMyStore = storeService.isMyStore(userIdx, store);
			StoreDTO storeDt = storeService.getStoreDt(store);
			model.addAttribute("storeNm", storeDt.getStore_Nm());
			if (isMyStore) {				
				  SearchParam param = new SearchParam();
				  param.setIdx(store); 
				  int total = holidayMapper.getTotalCount(param);
				  model.addAttribute("total", total);
				  param.setStartCount(0);
				  param.setEndCount(5); 
				  //param.setViewCount(5); 
				  param.setTotalCount(total);			  
				  List<HolidayDTO> holidays = holidayService.getHolidays(param); 
				  model.addAttribute("list", holidays);
				  rt = "/holiday/holiday-list";
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
	
	@ResponseBody
	@RequestMapping(value = "/getMoreList", method = RequestMethod.POST)
	public Map<String, Object> moreList(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		SearchParam param = new SearchParam();
		param.setStartCount(Integer.parseInt(req.getParameter("startCount")));
		param.setEndCount(Integer.parseInt(req.getParameter("startCount"))+Integer.parseInt(req.getParameter("viewCount")));
		//param.setViewCount(Integer.parseInt(req.getParameter("viewCount")));
		param.setTotalCount(Integer.parseInt(req.getParameter("totalCount")));
		param.setIdx(Integer.parseInt(req.getParameter("store")));
		
		List<HolidayDTO> holidays = holidayService.getHolidays(param);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("resultList", holidays);
		result.put("resultCnt",holidays.size());
		return result;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Model model, HttpSession session,
			@RequestParam(name="idx", required = false) Integer idx,
			@RequestParam(name="store", required = false) Integer store) {
		String msg = "";
		String rt = "";
		
		UserDTO user = commonUtil.getUser(session);
		int userIdx = 0;
		if (user != null) {
			userIdx = user.getOrigin_num();
			boolean isMyStore = storeService.isMyStore(userIdx, store);
			if (isMyStore) {
				int result = holidayMapper.delete(idx);
				if (result > 0) {
					msg = "삭제 성공";
					rt = commonUtil.addMsgLoc(model, msg, "/happyhour/holiday/list?store="+store);
				}else {
					msg = "삭제 실패";
					rt = commonUtil.addMsgBack(model, msg);
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
	
}
