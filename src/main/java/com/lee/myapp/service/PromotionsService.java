package com.lee.myapp.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.PromotionsCommentVO;
import com.lee.myapp.domain.PromotionsReportVO;
import com.lee.myapp.domain.PromotionsVO;

public interface PromotionsService {
	public List<BannerVO> mainBannerList(String area) throws Exception;	//Header banner
	public List<PromotionsVO> promotionList(String parameter) throws Exception;
	public int promotionRegist(PromotionsVO promotion, MultipartFile thumb, MultipartFile[] images) throws Exception;
	public int endPromotion() throws Exception;
	public PromotionsVO promotionView(int pno) throws Exception;
	public int updateStatus(PromotionsVO promotion) throws Exception;
	public int deletePromotion(int pno) throws Exception;
	public int modifyPromotion(PromotionsVO promotion, MultipartFile thumb, MultipartFile[] images) throws Exception;

	/* Comment */
	public int commentRegist(PromotionsCommentVO comment) throws Exception;
	public List<PromotionsCommentVO> commentList() throws Exception;
	public List<PromotionsCommentVO> listPaging(CommentCriteria cri) throws Exception;
	public int listCount(int pno) throws Exception;
	public int deleteComment(int rno) throws Exception;
	public void commentReport(PromotionsReportVO report) throws Exception;
	
	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
}