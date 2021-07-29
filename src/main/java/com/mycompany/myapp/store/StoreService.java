package com.mycompany.myapp.store;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mycompany.common.SearchParam;

public interface StoreService {

	int enrollStore(StoreDTO store, MultipartHttpServletRequest req, String msg);

	List<StoreDTO> getStoreAll(SearchParam param);

	StoreDTO getStoreDt(int idx);

	List<StoreDTO> getStoreBest();

	int deleteStore(MultipartHttpServletRequest req, int idx);

}
