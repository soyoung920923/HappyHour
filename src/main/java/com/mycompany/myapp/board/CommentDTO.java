package com.mycompany.myapp.board;

import java.sql.Date;

import lombok.Data;

@Data
public class CommentDTO {
	
	private Integer num; 
	private Integer cnum; //댓글 번호
	private int crefer;
	private int clevel;
	private int csunbun;
	private String name;
	private String id;
	private String ccontent;
	private Date wdate;
	private Date update_date;


}
