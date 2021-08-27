package com.mycompany.myapp.holiday;

import java.sql.Timestamp;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude
public class HolidayDTO {
	private int idx;
	private int store_origin;
	private String holiday_oid;
	private String store_nm;
	private Date startDate;
	private Date endDate;
	private String holiday_start;
	private String holiday_end;
	private String holiday_status;
	private Timestamp regist_Date;
	private String regist_id;
	private Timestamp update_Date;
	private String update_id;
}
