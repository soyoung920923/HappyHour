package com.mycompany.myapp.user;

import java.sql.Date;

import org.hibernate.validator.constraints.Length;

import lombok.Data;

@Data
public class UserDTO {
	
	private Integer origin_num; //pk
	private String name; // 이름
	@Length(min=4, max=12) 
	private String id;  // 아이디
	private String password; // 비밀번호
	private String postcode; // 이메일	
	private String address; // 주소
	private String address_dt; // 상세주소
	private String tel;  // 전화번호
	private String email; // 이메일
	private String email_idt; // 이메일 인증
	private String agree1; // 개인정보 동의 
	private String agree2; // 마케팅 수신 동의 
	private String user_dt; // 일반 = 1, 가게 = 2, 탈퇴회원 = 4, 관리자 =9 
	private Date jdate;
	
	
}
