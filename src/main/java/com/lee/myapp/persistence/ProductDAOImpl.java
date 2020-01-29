package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.domain.ReviewLikeVO;
import com.lee.myapp.domain.ReviewVO;

@Repository
public class ProductDAOImpl implements ProductDAO{
	private static final String namespace = "productMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public int register(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".register",product);
	}

	@Override
	public int register_option(ProductOptionVO option) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".register_option",option);
	}
	
	@Override
	public List<ProductVO> list(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".list",product);
	}

	@Override
	public ProductVO view(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".view",pno);
	}

	@Override
	public List<ProductOptionVO> view_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".view_option",pno);
	}

	@Override
	public int checkInventory(int ono) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".checkInventory",ono);
	}

	@Override
	public int isSeller(int mno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".isSeller",mno);
	}

	//Reivew
	@Override
	public int reviewRegist(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".reviewRegist", review);
	}

	@Override
	public List<ReviewVO> reviewList(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".reviewList", pno);
	}

	@Override
	public List<ReviewVO> listPaging(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".reviewListPaging", cri);
	}

	@Override
	public int listCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".reviewListCount", pno);
	}

	@Override
	public List<ReviewLikeVO> reviewLike(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".reviewLike", review);
	}

	@Override
	public List<ReviewLikeVO> reviewLikeCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".reviewLikeCount", pno);
	}

	@Override
	public int updateReviewStatus(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".updateReviewStatus", review);
	}

	@Override
	public int checkLike(ReviewLikeVO like) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".checkLike", like);
	}

	@Override
	public int registLike(ReviewLikeVO like) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".registLike", like);
	}

	@Override
	public int deleteLike(ReviewLikeVO like) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deleteLike", like);
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList",area);
	}
}
