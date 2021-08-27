package com.mycompany.myapp.store;

import java.util.List;

import com.mycompany.common.SearchParam;

public interface StoreMapper {

	int enrollStore(StoreDTO store);

	List<StoreDTO> getStoreAll(SearchParam param);

	int getTotalCount(SearchParam param);

	StoreDTO getStoreDt(int idx);

	void hitCountPlusOne(int idx);

	List<StoreDTO> getStoreBest();

	int updateStore(StoreDTO store);

	int deleteStore(int idx);

	String getDelOid(int idx);

	int updateService(StoreDTO store);

}
