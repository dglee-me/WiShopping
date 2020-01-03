package com.lee.myapp.persistence;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.PromotionsVO;

@Repository
public class PromotionsDAOImpl implements PromotionsDAO{
	private static final String namespace = "promotionsMapper";
	
	@Inject
	SqlSession sqlSession;

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList",area);
	}

	@Override
	public List<PromotionsVO> promotionList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".promotionList");
	}

	@Override
	public int promotionRegist(PromotionsVO promotion) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".promotionRegist",promotion);
	}

	@Override
	public int endPromotion() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".endPromotion");
	}

	@Override
	public PromotionsVO promotionView(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".promotionView",pno);
	}
}