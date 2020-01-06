package com.lee.myapp.service;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.PromotionsCommentVO;
import com.lee.myapp.domain.PromotionsVO;
import com.lee.myapp.persistence.PromotionsDAO;

@Service
public class PromotionsServiceImpl implements PromotionsService{
	
	@Inject
	PromotionsDAO promotionsDAO;

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.mainBannerList(area);
	}

	@Override
	public List<PromotionsVO> promotionList() throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.promotionList();
	}

	@Override
	public int promotionRegist(PromotionsVO promotion) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.promotionRegist(promotion);
	}

	@Override
	public int endPromotion() throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.endPromotion();
	}

	@Override
	public PromotionsVO promotionView(int pno) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.promotionView(pno);
	}

	@Override
	public int commentRegist(PromotionsCommentVO comment) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.commentRegist(comment);
	}

	@Override
	public List<PromotionsCommentVO> commentList() throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.commentList();
	}

	@Override
	public List<PromotionsCommentVO> listPaging(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.listPaging(cri);
	}

	@Override
	public int listCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.listCount(pno);
	}

}