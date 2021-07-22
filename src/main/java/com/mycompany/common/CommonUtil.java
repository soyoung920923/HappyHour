package com.mycompany.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mycompany.myapp.HomeController;

@Component
public class CommonUtil {
	
	/* private static final String FILEPATH = "\\upload"; */
		private static final String FILEPATH = "c:\\happyImage";
		public static final String PATH = "\\happyImage\\";
	
		private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

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
		
		public String storeCategory(int category) {
			String setCategory = null;
			switch (category) {
			case 1:
				setCategory = "한식";
				break;

			case 2:
				setCategory = "분식";
				break;

			case 3:
				setCategory = "중식";
				break;

			case 4:
				setCategory = "패스트푸드";
				break;

			case 5:
				setCategory = "양식";
				break;
			case 6:
				setCategory = "카페/디저트";
				break;
			case 7:
				setCategory = "일식";
				break;
			case 8:
				setCategory = "아시안";
				break;

			default:
				setCategory = "한식";
				break;
			}
			return setCategory;			
		}
		
		public String storeAddress(String address1, String address2) {
			
			String address = null;
			
			address1 = address1.substring(address1.indexOf("|")+1);
			address = address1.concat(" ").concat(address2);
			
			return address;
			
		}
		
		public Map<String, String> fileUpload(MultipartHttpServletRequest req, String type, String delOid){
			Map<String, String> aboutFile = new HashMap<String, String>();
			
			/*
			 * String applicationPath = req.getServletContext().getRealPath("resources");
			 * String uploadFilePath = applicationPath + FILEPATH;
			 * 
			 * logger.debug(" LOG :: [서버 루트 경로] :: " + applicationPath);
			 * logger.debug(" LOG :: [파일 저장 경로] :: " + uploadFilePath);
			 */
			
			
			MultipartFile file = req.getFile("file");
			if (file != null) {
				
				File fileDir = new File(FILEPATH);
				
				if(!fileDir.exists()) {
					fileDir.mkdirs();
				}			
				
				String extension = FilenameUtils.getExtension(file.getOriginalFilename());
				type = type.concat(generateOid()).concat(".").concat(extension);
				aboutFile.put("img", file.getOriginalFilename());
				aboutFile.put("imgOid", type);
				
				try {
					
					file.transferTo(new File(FILEPATH, type));
					
					if (delOid != null) {
						fileDelete(req, delOid);
					}
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
			}
			
			return aboutFile;
		}
		
		public int fileDelete(MultipartHttpServletRequest req, String delOid){
			int i = 0;
			/*
			 * String applicationPath = req.getServletContext().getRealPath("resources");
			 * String uploadFilePath = applicationPath + FILEPATH;
			 */
			
			File delFile = new File(FILEPATH, delOid);
			if (delFile.exists()) {
				if (delFile.delete()) {
					logger.debug(" LOG :: [파일삭제성공] :: " + delFile);
					i = 1;
				}else {
					logger.debug(" LOG :: [파일삭제실패] :: " + delFile);
				}
			}
			return i;
		}
		
		public List<String> timeSet(){
			List<String> timeSet = new ArrayList<String>();
			for (int i = 0; i < 24; i++) {
				if (i<10) {
					timeSet.add("0"+i+":00");
					timeSet.add("0"+i+":30");
				}else {				
					timeSet.add(i+":00");
					timeSet.add(i+":30");
				}
			}
			return timeSet;
		}
		
		
	}



