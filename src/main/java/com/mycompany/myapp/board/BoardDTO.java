package com.mycompany.myapp.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private String mode; // 글쓰기:insert, 글수정:edit, 답변쓰기:reply
	
	private Integer num;
	private String title;
	private String name;
	private String content;
	private Date register_day;
	private String filename;
	private String filename2;
	private String origin_filename;
	private String origin_filename2;
	private int category;
	private int hits;
	private int origin;
	private String id;
	private String exist;
	private String user_dt; // 일반 = 1, 가게 = 2, 탈퇴회원 = 4, 관리자 =9 
	
    private int refer; // 동일한 글 그룹번호
    private int level; // 답변 레벨
    private int sunbun; // 같은 글그룹 내의 순서
    
    private int newImg;

}
