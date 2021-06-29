package com.mycompany.myapp.store;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.myapp.HomeController;

@Controller
@RequestMapping(value="/store")
public class StroreController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	StoreService storeService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		return null;
	}
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(Model model) {
		return null;
	}
	@RequestMapping(value = "/enroll", method = RequestMethod.GET)
	public String enroll(Model model) {
		logger.info("store enroll", model);
		System.out.println("store enroll");
		return "/store/storeEnroll";
	}
	@RequestMapping(value = "/enroll-action", method = RequestMethod.GET)
	public String enrollAction(Model model) {
		return null;
	}
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Model model) {
		return null;
	}

}
