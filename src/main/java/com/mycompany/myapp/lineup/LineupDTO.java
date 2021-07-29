package com.mycompany.myapp.lineup;

import java.io.Serializable;
import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.mycompany.common.CommonUtil;

import lombok.Data;

@Data
@JsonInclude
public class LineupDTO implements Serializable{
	
	private Integer idx;
	private Integer store_origin;
	private Integer user_origin;
	private Integer lineup_count;
	private Integer lineup_yn;
	private Integer lineup_visit;
	private String lineup_nm;
	private String store_nm;
	private String lineup_tel;
	private String sms_id;
	
	private MultipartFile file;
	
	private String lineup_Date;
	private String date;
	private String time;
	private String dateTime;
	
	private Timestamp regist_date;
	private String regist_id;
	private Timestamp update_date;
	private String update_id;
	
	private Integer waiting;
	
	private final String PATH = CommonUtil.PATH;
}
