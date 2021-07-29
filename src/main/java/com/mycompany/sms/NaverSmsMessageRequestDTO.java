package com.mycompany.sms;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data 
@Service 
@Getter 
@AllArgsConstructor
@NoArgsConstructor
public class NaverSmsMessageRequestDTO {
	private String to; 
	private String content;

}
