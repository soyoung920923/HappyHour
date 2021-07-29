package com.mycompany.myapp.banner;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BannerMapper {

	int enrollBanner(BannerDTO banner);

	List<Integer> getOrder();

	int postBannerUpdate(Map<String,String> param);

	List<BannerDTO> getAllBanner();

	BannerDTO getThisBanner(String idx);

	int updateBanner(BannerDTO banner);

	void hitCountPlusOne(String idx);

	int deleteBanner(int idx);

	BannerDTO getDelBanner(int idx);

}
