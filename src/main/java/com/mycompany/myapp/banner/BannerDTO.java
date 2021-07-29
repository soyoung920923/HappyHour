package com.mycompany.myapp.banner;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import com.mycompany.common.CommonUtil;

import lombok.Data;

@Data
public class BannerDTO {
	
	private int idx;
	private int origin;
	private int banner_order;
	private int delete_yn;
	private int hit_count;
	private int banner_caption;
	private int caption_yn;
	private String banner_img;
	private String banner_img_oid;
	private String banner_subject;
	private String banner_contents;
	private String banner_link;
	private String regist_id;
	private String update_id;
	private Timestamp regist_date;
	private Timestamp update_date;
	private MultipartFile file;
	private final String PATH = CommonUtil.PATH;
	
	
	
	
	
}
