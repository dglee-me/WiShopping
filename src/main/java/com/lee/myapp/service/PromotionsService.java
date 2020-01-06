package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.PromotionsCommentVO;
import com.lee.myapp.domain.PromotionsVO;

public interface PromotionsService {
	public List<BannerVO> mainBannerList(String area) throws Exception;	//Header banner
	public List<PromotionsVO> promotionList() throws Exception;
	public int promotionRegist(PromotionsVO promotion) throws Exception;
	public int endPromotion() throws Exception;
	public PromotionsVO promotionView(int pno) throws Exception;

	//Reply
	public int commentRegist(PromotionsCommentVO comment) throws Exception;
	public List<PromotionsCommentVO> commentList() throws Exception;
	public List<PromotionsCommentVO> listPaging(CommentCriteria cri) throws Exception;
	public int listCount(int pno) throws Exception;
}