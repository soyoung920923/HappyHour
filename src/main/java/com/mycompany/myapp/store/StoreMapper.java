package com.mycompany.myapp.store;

import java.util.List;

import com.mycompany.common.SearchParam;

public interface StoreMapper {

	int enrollStore(StoreDTO store);

	List<StoreDTO> getStoreAll(SearchParam param);

	int getTotalCount(SearchParam param);

}
