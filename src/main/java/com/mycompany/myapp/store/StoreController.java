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

	@RequestMapping(value = {"/list", "/list/{path}"}, method = RequestMethod.GET)
	public String list(Model model, @PathVariable(name="path", required = false) String path) {

		logger.info("store list", model);
		System.out.println("store list");

		SearchParam param = new SearchParam();
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
	public String detail(Model model) {
		return null;
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.GET)
	public String enroll(Model model) {

		logger.info("store enroll", model);
		System.out.println("store enroll");

		return "/store/store-enroll";
	}

	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollAction(Model model, HttpSession session, @ModelAttribute(value = "store") StoreDTO store,
			HttpServletRequest request) {
		logger.info("store enroll - action", model);
		System.out.println("store enroll - action");

		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		if (session.getAttribute("authUser") != null) {
			UserDTO user = (UserDTO) session.getAttribute("authUser");
			store.setOrigin(user.getOrigin_num());
			store.setRegist_Id(user.getId());
			store.setUpdate_Id(user.getId());
		}

		String msg = "";

		int result = storeService.enrollStore(store, req);

		if (result == 0) {
			msg = "등록 실패";
		} else {
			msg = "등록 성공";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("loc", "/happyhour/store/list");

		return "message";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Model model) {
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMoreList", method = RequestMethod.POST)
	public Map<String, Object> moreList(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		
		SearchParam param = new SearchParam();
		param.setStartCount(Integer.parseInt(req.getParameter("startCount")));
		param.setEndCount(Integer.parseInt(req.getParameter("startCount"))+Integer.parseInt(req.getParameter("viewCount")));
		//param.setViewCount(Integer.parseInt(req.getParameter("viewCount")));
		param.setTotalCount(Integer.parseInt(req.getParameter("totalCount")));
		
		String path = req.getParameter("path");
		if (path != null && path != "") {
			param.setPath(Integer.parseInt(path));
		}
		
		List<StoreDTO> resultList = storeService.getStoreAll(param);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("resultList", resultList);
		result.put("resultCnt",resultList.size());
		
		return result;
	}

}
