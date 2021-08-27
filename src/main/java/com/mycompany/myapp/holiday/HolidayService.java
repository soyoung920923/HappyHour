package com.mycompany.myapp.holiday;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.mycompany.common.SearchParam;
import com.mycompany.myapp.user.UserDTO;

public interface HolidayService {

	int enroll(UserDTO user, int store, HttpServletRequest request);

	List<HolidayDTO> getHolidays(SearchParam param);

}
