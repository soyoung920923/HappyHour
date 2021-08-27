package com.mycompany.myapp.holiday;

import java.util.List;

import com.mycompany.common.SearchParam;

public interface HolidayMapper {

	int getTotalCount(SearchParam param);

	List<HolidayDTO> getHolidays(SearchParam param);

	int enroll(HolidayDTO holiday);

	int delete(Integer idx);

}
