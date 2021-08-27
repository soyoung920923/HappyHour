package com.mycompany.myapp.store;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.mycompany.common.CommonUtil;

import lombok.Data;

@Data
@JsonInclude
public class StoreDTO implements Serializable{
	/* public static final String FILE_PATH = "D:\\hh-files"; */
	
	private int idx;
	private int origin;
	private String store_Nm;
	private String store_Tel;
	private String store_Address;
	private String store_Address_Dt;
	private Integer hit_Count;
	private Integer store_Idt;
	private MultipartFile file;
	private String store_Img;
	private String store_Img_Oid;
	private String store_Info;
	private Timestamp regist_Date;
	private String regist_Id;
	private Timestamp update_Date;
	private String update_Id;
	
	private String store_open;
	private String store_close;
	private String break_start;
	private String break_end;
	private int store_break;
		
	private String category;
	private String address;
	private String latitude;
	private String longitude;
	private int distance;
	
	private final String PATH = "\\happyImage\\";
	
	private int newRsv;
	private int newLnu;
	private int line_yn;
	private int rsv_yn;
	private String line_notice;
	private String rsv_notice;
	
	private String holidays[];
	private String holiday;
	private String holiday_etc;
	
}
