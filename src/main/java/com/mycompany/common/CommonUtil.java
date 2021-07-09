package com.mycompany.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class CommonUtil {

		public String addMsgLoc(Model m, String msg, String loc) {
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			return "message";
		}
		
		public String addMsgBack(Model m, String msg) {
			m.addAttribute("msg", msg);
			m.addAttribute("loc", "javascript:history.back()");
			return "message";
		}
		
		public synchronized String generateOid() {
			Calendar calendar = Calendar.getInstance();
	        java.util.Date date = calendar.getTime();
	        String today = (new SimpleDateFormat("yyMMddHHmmss").format(date));
	        String nanoSeconds = String.valueOf((int)Math.ceil(Math.random()*1000000));
			return "F".concat(today).concat(nanoSeconds);
		}
	}

