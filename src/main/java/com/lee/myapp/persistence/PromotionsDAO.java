package com.lee.myapp.persistence;

import java.sql.Date;
import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.PromotionsVO;

public interface PromotionsDAO {
	public List<BannerVO> mainBannerList(String area) throws Exception;	//Header banner
	public List<PromotionsVO> promotionList() throws Exception;
	public int promotionRegist(PromotionsVO promotion) throws Exception;
	public int endPromotion() throws Exception;
	public PromotionsVO promotionView(int pno) throws Exception;
}