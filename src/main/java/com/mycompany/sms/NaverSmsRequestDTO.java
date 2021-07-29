package com.mycompany.sms;

import java.util.List;

import lombok.Data;

@Data 
public class NaverSmsRequestDTO {
	
	private String reserveTime;
	private String type; 
	private String contentType; 
	private String countryCode; 
	private String from; 
	private String content; 
	private List<NaverSmsMessageRequestDTO> messages;
	
	
	public NaverSmsRequestDTO(String type, String contentType, String countryCode, String from, String content,
			List<NaverSmsMessageRequestDTO> messages) {
		this.type = type;
		this.contentType = contentType;
		this.countryCode = countryCode;
		this.from = from;
		this.content = content;
		this.messages = messages;
	}
	
	public NaverSmsRequestDTO(String reserveTime, String type, String contentType, String countryCode, String from, String content,
			List<NaverSmsMessageRequestDTO> messages ) {
		this.reserveTime = reserveTime;
		this.type = type;
		this.contentType = contentType;
		this.countryCode = countryCode;
		this.from = from;
		this.content = content;
		this.messages = messages;
		
	}
	
	


}
