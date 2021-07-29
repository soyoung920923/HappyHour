package com.mycompany.myapp.banner;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mycompany.common.CommonUtil;
import com.mycompany.myapp.HomeController;
import com.mycompany.myapp.store.StoreDTO;
import com.mycompany.myapp.user.UserDTO;

@Controller
@RequestMapping(value = "/banner")
public class BannerController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	BannerService bannerService;
	
	@Autowired
	CommonUtil commonUtil;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {

		logger.info("banner list", model);
		System.out.println("banner list");
		
		List<BannerDTO> banners = bannerService.getAllBanner();
		model.addAttribute("banners", banners);

		return "/banner/banner-list";
	}
	
	@RequestMapping(value = "/enroll", method = RequestMethod.GET)
	public String enroll(Model model, @RequestParam(name="idx", required = false) String idx) {

		logger.info("banner enroll", model);
		System.out.println("banner enroll");
		
		List<Integer> order = bannerService.getOrder();
		
		if (idx != null && idx != "") {
			/*
			 * 상세페이지 및 수정페이지
			 * */
			BannerDTO banner = bannerService.getThisBanner(idx);
			model.addAttribute("banner", banner);
		}else {
			/*
			 * 등록페이지
			 * */
			if (order.size()>0) {
				order.add(order.get(order.size()-1)+1);
			}else {
				order.add(1);
			}
		}
		
		
		model.addAttribute("order", order);

		return "/banner/banner-enroll";
	}
	
	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollAction(Model model, HttpSession session, @ModelAttribute(value = "banner") BannerDTO banner,
			HttpServletRequest request) {

		logger.info("banner enroll", model);
		System.out.println("banner enroll");

		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		
		if (session.getAttribute("loginUser") != null) {
			UserDTO user = (UserDTO) session.getAttribute("loginUser");
			banner.setOrigin(user.getOrigin_num());
			banner.setRegist_id(user.getId());
			banner.setUpdate_id(user.getId());
		}
		String msg = "";
		int result = 0;
		if (banner.getIdx() == 0) {
			/*
			 * 등록*/
			msg = "등록";
		}else {
			/*
			 * 수정*/
			msg = "수정";
		}
		
		result = bannerService.enrollBanner(banner, req, msg);

		if (result == 0) {
			msg = msg+" 실패";
		} else {
			msg = msg+" 성공";
		}

		return commonUtil.addMsgLoc(model, msg, "/happyhour/banner/list");
	}
	
	@RequestMapping(value = "/go", method = RequestMethod.GET)
	public String go(Model model, 
			@RequestParam(name="idx", required = false) String idx,
			@RequestParam(name="link", required = false) String link) {
		
		bannerService.hitCountPlusOne(idx);
		if (!link.equals("blank") ) {
			return commonUtil.addMsgLoc(model, null, link);			
		}else {
			return commonUtil.addMsgBack(model, "페이지 준비중입니다.");
		}
	}
	
	@RequestMapping(value = "/deleteBanner", method = RequestMethod.POST)
	public String deleteBanner(Model model, HttpServletRequest request, @ModelAttribute(value = "banner") BannerDTO banner) {
		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		int idx = banner.getIdx();
		int result = bannerService.deleteBanner(req, idx);
		if (result == 0) {
			return commonUtil.addMsgBack(model, "삭제 실패");
		}else {			
			return commonUtil.addMsgLoc(model, "삭제 성공", "/happyhour/banner/list");		
		}
	}
}
