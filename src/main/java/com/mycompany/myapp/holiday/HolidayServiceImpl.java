package com.mycompany.myapp.holiday;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.common.SearchParam;
import com.mycompany.myapp.user.UserDTO;

@Service("holidayService")
public class HolidayServiceImpl implements HolidayService{
	
	@Autowired
	HolidayMapper holidayMapper;

	@Override
	public int enroll(UserDTO user, int store, HttpServletRequest request) {
		// TODO Auto-generated method stub
		HolidayDTO holiday = new HolidayDTO();		
		holiday.setStore_origin(store);
		holiday.setRegist_id(user.getId());
		holiday.setUpdate_id(user.getId());
		holiday.setHoliday_status(request.getParameter("holiday_status"));
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = new Date();
		Date endDate = new Date();
		String todayYn = request.getParameter("todayYn");
		if ("1".equals(todayYn)) {
			holiday.setHoliday_start(String.valueOf(df.format(startDate))+" 00:00:00");
			holiday.setHoliday_end(String.valueOf(df.format(endDate))+" 00:00:00");
		}else {			
			try {
				startDate = df.parse(request.getParameter("startDate"));
				endDate = df.parse(request.getParameter("endDate"));
				holiday.setHoliday_start(String.valueOf(df.format(startDate))+" 00:00:00");
				holiday.setHoliday_end(String.valueOf(df.format(endDate))+" 00:00:00");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		int result = holidayMapper.enroll(holiday);
		
		return result;
	}

	@Override
	public List<HolidayDTO> getHolidays(SearchParam param) {
		// TODO Auto-generated method stub
		List<HolidayDTO> result = holidayMapper.getHolidays(param);
		String holiday_start = "";
		String holiday_end = "";
		for (int i = 0; i < result.size(); i++) {
			holiday_start = result.get(i).getHoliday_start().substring(0,10);
			result.get(i).setHoliday_start(holiday_start);
			holiday_end = result.get(i).getHoliday_end().substring(0,10);
			result.get(i).setHoliday_end(holiday_end);
		}
		return result;
	}
	
	
	
}
