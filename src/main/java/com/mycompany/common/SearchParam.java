package com.mycompany.common;

import lombok.Data;

@Data
public class SearchParam {
	
	private Integer startCount;
	private Integer endCount;
	private Integer viewCount;
	private Integer totalCount;
	private Integer path;
	private String search;
	private String myLat;
	private String myLon;
	private String today;
	private String todayEnd;
	private int store;
	
	
}
