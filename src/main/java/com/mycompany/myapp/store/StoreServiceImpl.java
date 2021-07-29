package com.mycompany.myapp.store;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mycompany.common.CommonUtil;
import com.mycompany.common.SearchParam;
import com.mycompany.myapp.HomeController;

@Service("storeService")
public class StoreServiceImpl implements StoreService{
	
	/* String filePath = StoreDTO.FILE_PATH; */
	/* String filePath = "D:\\hh-files"; */
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	StoreMapper storeMapper;
	
	@Autowired
	private CommonUtil commonUtil;

	@Override
	public int enrollStore(StoreDTO store, MultipartHttpServletRequest req, String msg) {
		// TODO Auto-generated method stub
		String delOid = null;
		if (msg.equals("수정")) {
			delOid = store.getStore_Img_Oid();
		}
		if (store.getFile() != null && !store.getFile().isEmpty()) {			
			String type = "S";  //Store
			Map<String, String> aboutFile = commonUtil.fileUpload(req, type, delOid);
			store.setStore_Img(aboutFile.get("img"));
			store.setStore_Img_Oid(aboutFile.get("imgOid"));
		}
		int result = 0;
		if (msg.equals("등록")) {	
			result = storeMapper.enrollStore(store);
		}else {
			result = storeMapper.updateStore(store);	
		}
		
		return result;
	}

	@Override
	public List<StoreDTO> getStoreAll(SearchParam param) {
		// TODO Auto-generated method stub
		 List<StoreDTO> list = storeMapper.getStoreAll(param);
			
		 for (int i = 0; i < list.size(); i++) {
			Integer idt = list.get(i).getStore_Idt();
			String setCategory = commonUtil.storeCategory(idt);
			list.get(i).setCategory(setCategory);
		}	 
			 
		return list;
	}

	@Override
	public StoreDTO getStoreDt(int idx) {
		// TODO Auto-generated method stub
		
		StoreDTO store = storeMapper.getStoreDt(idx);
		Integer idt = store.getStore_Idt();
		String setCategory = commonUtil.storeCategory(idt);
		store.setCategory(setCategory);
		
		String address = commonUtil.storeAddress(store.getStore_Address(), store.getStore_Address_Dt());
		store.setAddress(address);
		
		return store;
	}

	@Override
	public List<StoreDTO> getStoreBest() {
		// TODO Auto-generated method stub
		
		List<StoreDTO> best = storeMapper.getStoreBest();
		for (int i = 0; i < best.size(); i++) {
			Integer idt = best.get(i).getStore_Idt();
			String setCategory = commonUtil.storeCategory(idt);
			best.get(i).setCategory(setCategory);
			
			String address = commonUtil.storeAddress(best.get(i).getStore_Address(), best.get(i).getStore_Address_Dt());
			best.get(i).setAddress(address);
		}
		
		return best;
	}

	@Override
	public int deleteStore(MultipartHttpServletRequest req, int idx) {
		// TODO Auto-generated method stub
		String delOid = storeMapper.getDelOid(idx);
		int i = storeMapper.deleteStore(idx);
		if (i == 0) return i;
		try {
			commonUtil.fileDelete(req, delOid);
		} catch (Exception e) {
			// TODO: handle exception
			logger.info("deleteStore 파일 삭제 실패: ", e);
		}				
		return i;
	}
	
	
	
	
	
	
	
	
}
