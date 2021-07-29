package com.mycompany.myapp.store;

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
import com.mycompany.myapp.user.UserDTO;

@Controller
@RequestMapping(value = "/store")
public class StoreController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	StoreService storeService;

	@Autowired
	StoreMapper storeMapper;
	
	@Autowired
	CommonUtil commonUtil;

	@RequestMapping(value = {"/list", "/list/{path}"})
	public String list(Model model, @PathVariable(name="path", required = false) String path, 
			@RequestParam(name="search", required = false) String search, HttpSession session) {

		logger.info("store list", model);
		System.out.println("store list");
		
		SearchParam param = new SearchParam();
		
		@SuppressWarnings("unchecked")
		Map<String, String> myPoint = (Map<String, String>) session.getAttribute("myPoint");
		if (myPoint != null && !myPoint.isEmpty()) {			
			param.setMyLat(myPoint.get("lat"));
			param.setMyLon(myPoint.get("lon"));
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

		model.addAttribute("total", total);
		model.addAttribute("list", list);
		
		return "/store/store-list";
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
	public String enroll(Model model, @RequestParam(name="idx", required = false) String idx) {

		logger.info("store enroll", model);
		System.out.println("store enroll");
		
		List<String> timeSet = commonUtil.timeSet();
		model.addAttribute("timeSet", timeSet);
		
		if (idx != null && idx != "") {
			/*
			 * 수정페이지
			 * */
			StoreDTO store = storeService.getStoreDt(Integer.parseInt(idx));
			model.addAttribute("store", store);
		}

		return "/store/store-enroll";
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollAction(Model model, HttpSession session, @ModelAttribute(value = "store") StoreDTO store,
			HttpServletRequest request) {
		logger.info("store enroll - action", model);
		System.out.println("store enroll - action");

		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		if (session.getAttribute("loginUser") != null) {
			UserDTO user = (UserDTO) session.getAttribute("loginUser");
			store.setOrigin(user.getOrigin_num());
			store.setRegist_Id(user.getId());
			store.setUpdate_Id(user.getId());
		}

		String msg = "";

		int result = 0;
		if (store.getIdx() == 0) {
			/*
			 * 등록*/
			msg = "등록";
		}else {
			/*
			 * 수정*/
			msg = "수정";
		}
		result = storeService.enrollStore(store, req, msg);

		if (result == 0) {
			msg = msg+" 실패";
		} else {
			msg = msg+" 성공";
		}
		
		return commonUtil.addMsgLoc(model, msg, "/happyhour/store/list");
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMoreList", method = RequestMethod.POST)
	public Map<String, Object> moreList(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		
		SearchParam param = new SearchParam();
		@SuppressWarnings("unchecked")
		Map<String, String> myPoint = (Map<String, String>) session.getAttribute("myPoint");
		if (myPoint != null && !myPoint.isEmpty()) {			
			param.setMyLat(myPoint.get("lat"));
			param.setMyLon(myPoint.get("lon"));
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
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("resultList", resultList);
		result.put("resultCnt",resultList.size());
		
		return result;
	}
	
	@RequestMapping(value = "/deleteStore", method = RequestMethod.POST)
	public String deleteStore(Model model, HttpServletRequest request, @ModelAttribute(value = "store") StoreDTO store) {
		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		int idx = store.getIdx();
		int result = storeService.deleteStore(req, idx);
		if (result == 0) {
			return commonUtil.addMsgBack(model, "삭제 실패");
		}else {			
			return commonUtil.addMsgLoc(model, "삭제 성공", "/happyhour/store/list");		
		}
	}

}
