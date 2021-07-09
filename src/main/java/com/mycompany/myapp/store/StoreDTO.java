package com.mycompany.myapp.store;

import java.io.Serializable;
import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude
public class StoreDTO implements Serializable{
	/* public static final String FILE_PATH = "D:\\hh-files"; */
	
	private Integer idx;
	private Integer origin;
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
	
	private String category;
}
