package com.lee.myapp.service;

import java.sql.Date;
import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.PromotionsVO;

public interface PromotionsService {
	public List<BannerVO> mainBannerList(String area) throws Exception;	//Header banner
	public List<PromotionsVO> promotionList() throws Exception;
	public int promotionRegist(PromotionsVO promotion) throws Exception;
	public int endPromotion() throws Exception;
}