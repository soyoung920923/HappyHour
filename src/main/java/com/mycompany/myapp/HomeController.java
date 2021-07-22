package com.mycompany.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.common.CommonUtil;
import com.mycompany.myapp.banner.BannerDTO;
import com.mycompany.myapp.banner.BannerService;
import com.mycompany.myapp.store.StoreDTO;
import com.mycompany.myapp.store.StoreService;
import com.mycompany.myapp.user.UserMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	BannerService bannerService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		
	    logger.info("Welcome home! The client locale is {}.", locale);
	   
		/*
		 * Date date = new Date(); DateFormat dateFormat =
		 * DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		 * 
		 * String formattedDate = dateFormat.format(date);
		 * 
		 * model.addAttribute("serverTime", formattedDate );
		 */
		 
		List<StoreDTO> best = storeService.getStoreBest();
		model.addAttribute("best", best);
		
		List<BannerDTO> banners = bannerService.getAllBanner();
		for (int i = 0; i < banners.size(); i++) {
			if (banners.get(i).getBanner_link() == null || banners.get(i).getBanner_link() == "") {
				banners.get(i).setBanner_link("blank");
			}
		}
		model.addAttribute("banners", banners);
		model.addAttribute("size", banners.size());
		 
		
		return "main";
	}
	
	@RequestMapping(value = "/myPoint", method = RequestMethod.GET)
	@ResponseBody
	public String myPoint(@RequestParam(name="lat", required = false) String lat,
			@RequestParam(name="lon", required = false) String lon, HttpSession session, Model model ) {
		
		Map<String, String> myPoint = new HashMap<String, String>();
		
		myPoint.put("lat", lat);
		myPoint.put("lon", lon);
		session.setAttribute("myPoint", myPoint);
		model.addAttribute("myPoint", myPoint);
		System.out.println(myPoint);
		
		return "success";
	}
	
	@RequestMapping(value = "/myPointOff", method = RequestMethod.GET)
	@ResponseBody
	public String myPointOff(HttpSession session ) {
		
		session.setAttribute("myPoint",null);
		System.out.println("off");
		return "success";
	}
	
}
