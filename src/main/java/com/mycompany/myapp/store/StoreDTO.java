package com.mycompany.myapp.store;

import lombok.Data;

@Data
public class StoreDTO {
	private int idx;
	private int origin;
	private String storeNm;
	private String storeTel;
	private String storeAddress;
	private String storeAddressDT;
	private int hitCount;
	private int storeIdt;
	private String storeImg;
}
