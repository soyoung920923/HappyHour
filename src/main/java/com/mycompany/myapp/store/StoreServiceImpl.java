package com.mycompany.myapp.store;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mycompany.common.CommonUtil;
import com.mycompany.common.SearchParam;

@Service("storeService")
public class StoreServiceImpl implements StoreService{
	
	/* String filePath = StoreDTO.FILE_PATH; */
	/* String filePath = "D:\\hh-files"; */
	
	
	@Autowired
	StoreMapper storeMapper;
	
	@Autowired
	private CommonUtil commonUtil;

	@Override
	public int enrollStore(StoreDTO store, MultipartHttpServletRequest  req) {
		// TODO Auto-generated method stub
		
		String filePath = "\\upload";
		String applicationPath = req.getServletContext().getRealPath("resources");
		String uploadFilePath = applicationPath + filePath;
		
		System.out.println(" LOG :: [서버 루트 경로] :: " + applicationPath);
		System.out.println(" LOG :: [파일 저장 경로] :: " + uploadFilePath);
		
		
		MultipartFile file = req.getFile("file");
		if (file != null) {
			
			File fileDir = new File(uploadFilePath);
			
			if(!fileDir.exists()) {
				fileDir.mkdirs();
			}
			
			String fileOid = "S";
			String extension = FilenameUtils.getExtension(file.getOriginalFilename());
			fileOid = fileOid.concat(commonUtil.generateOid()).concat(".").concat(extension);
			store.setStore_Img(file.getOriginalFilename());
			store.setStore_Img_Oid(fileOid);
			
			try {
				
				file.transferTo(new File(uploadFilePath, fileOid));
				
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
		int result = storeMapper.enrollStore(store);
		
		return result;
	}

	@Override
	public List<StoreDTO> getStoreAll(SearchParam param) {
		// TODO Auto-generated method stub
		 List<StoreDTO> list = storeMapper.getStoreAll(param);
			
		 for (int i = 0; i < list.size(); i++) {
			Integer idt = list.get(i).getStore_Idt();
			switch (idt) {
			case 1:
				list.get(i).setCategory("한식");
				break;

			case 2:
				list.get(i).setCategory("분식");
				break;

			case 3:
				list.get(i).setCategory("중식");
				break;

			case 4:
				list.get(i).setCategory("패스트푸드");
				break;

			case 5:
				list.get(i).setCategory("양식");
				break;
			case 6:
				list.get(i).setCategory("카페/디저트");
				break;
			case 7:
				list.get(i).setCategory("일식");
				break;
			case 8:
				list.get(i).setCategory("아시안");
				break;

			default:
				list.get(i).setCategory("한식");
				break;
			}
		}
			 
		return list;
	}
	
	
	
}
