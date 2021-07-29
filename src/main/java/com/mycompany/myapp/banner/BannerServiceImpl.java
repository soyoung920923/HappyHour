package com.mycompany.myapp.banner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mycompany.common.CommonUtil;
import com.mycompany.myapp.HomeController;

@Service("bannerService")
public class BannerServiceImpl implements BannerService{
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	BannerMapper bannerMapper;
	
	@Autowired
	private CommonUtil commonUtil;

	@Override
	public int enrollBanner(BannerDTO banner, MultipartHttpServletRequest req, String msg) {
		// TODO Auto-generated method stub
		String delOid = null;
		if (msg.equals("수정")) {
			delOid = banner.getBanner_img_oid();
		}
		if (banner.getFile() != null && !banner.getFile().isEmpty()) {			
			String type = "B";  //Banner
			Map<String, String> aboutFile = commonUtil.fileUpload(req, type, delOid);
			banner.setBanner_img(aboutFile.get("img"));
			banner.setBanner_img_oid(aboutFile.get("imgOid"));
		}
		Map<String,String> param = new HashMap<>();
		param.put("type", "plus");
		param.put("thisOrder", String.valueOf(banner.getBanner_order()));
		bannerMapper.postBannerUpdate(param);
		
		int result = 0;
		if (msg.equals("등록")) {
			result = bannerMapper.enrollBanner(banner);		
		}else {
			result = bannerMapper.updateBanner(banner);	
		}
		return result;
	}

	@Override
	public List<Integer> getOrder() {
		// TODO Auto-generated method stub
		return bannerMapper.getOrder();
	}

	@Override
	public List<BannerDTO> getAllBanner() {
		// TODO Auto-generated method stub
		return bannerMapper.getAllBanner();
	}

	@Override
	public BannerDTO getThisBanner(String idx) {
		// TODO Auto-generated method stub
		return bannerMapper.getThisBanner(idx);
	}

	@Override
	public void hitCountPlusOne(String idx) {
		// TODO Auto-generated method stub
		bannerMapper.hitCountPlusOne(idx);
	}

	@Override
	public int deleteBanner(MultipartHttpServletRequest req, int idx) {
		// TODO Auto-generated method stub
		
		BannerDTO delBanner = bannerMapper.getDelBanner(idx);
		Map<String,String> param = new HashMap<>();
		param.put("type", "minus");
		param.put("thisOrder", String.valueOf(delBanner.getBanner_order()));
		int i = bannerMapper.postBannerUpdate(param);
		if (i == 0) return i;
		i = bannerMapper.deleteBanner(idx);
		if (i == 0) return i;
		try {
			commonUtil.fileDelete(req, delBanner.getBanner_img_oid());
		} catch (Exception e) {
			// TODO: handle exception
			logger.info("deleteBanner 파일 삭제 실패: ", e);
		}		
		return i;
	}
	
	
	
	
	
	
	
}
