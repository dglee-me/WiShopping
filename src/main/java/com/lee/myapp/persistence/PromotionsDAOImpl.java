package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.PromotionsCommentVO;
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
	public List<PromotionsVO> promotionList(String parameter) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".promotionList", parameter);
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

	@Override
	public int updateStatus(PromotionsVO promotion) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".updateStatus", promotion);
	}

	@Override
	public int deletePromotion(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deletePromotion", pno);
	}

	@Override
	public int modifyPromotion(PromotionsVO promotion) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".modifyPromotion",promotion);
	}

	/* Comment */
	@Override
	public int commentRegist(PromotionsCommentVO comment) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".commentRegist",comment);
	}

	@Override
	public List<PromotionsCommentVO> commentList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".commentList");
	}

	@Override
	public List<PromotionsCommentVO> listPaging(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".commentListPaging", cri);
	}

	@Override
	public int listCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".CommentlistCount", pno);
	}

	@Override
	public int deleteComment(int rno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deleteComment",rno);
	}
}