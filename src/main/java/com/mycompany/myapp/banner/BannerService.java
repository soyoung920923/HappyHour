package com.mycompany.myapp.banner;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BannerService {

	int enrollBanner(BannerDTO banner, MultipartHttpServletRequest req, String msg);

	List<Integer> getOrder();

	List<BannerDTO> getAllBanner();

	BannerDTO getThisBanner(String idx);

	void hitCountPlusOne(String idx);

	int deleteBanner(MultipartHttpServletRequest req, int idx);

}
