package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductQuestionVO;
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
	public void delete_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+".optionDelete", pno);
	}
	
	@Override
	public List<ProductVO> list(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".list",product);
	}

	@Override
	public ProductVO view(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".view", cri);
	}

	@Override
	public List<ProductOptionVO> view_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".view_option",pno);
	}

	@Override
	public void modifyProduct(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".modifyProduct", product);
	}

	@Override
	public void deleteProduct(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+".productDelete", product);
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
	public int deleteReview(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deleteReview", review);
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

	//Product question and answer
	@Override
	public void questionRegist(ProductQuestionVO question) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".questionRegist", question);
	}

	@Override
	public void answerRegist(ProductQuestionVO question) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".answerRegist", question);
	}

	@Override
	public List<ProductQuestionVO> questionList(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".questionList", cri);
	}

	@Override
	public int questionListCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".questionListCount", pno);
	}

	@Override
	public int questionStatusUpdate(int qno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".questionStatusUpdate", qno);
	}

	@Override
	public int questionDelete(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".questionDelete", pno);
	}

	@Override
	public int answerDelete(ProductQuestionVO question) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".answerDelete", question);
	}
	
	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".categoryList");
	}
	
	@Override
	public List<CategoryVO> selectCategoryList(String category1) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".selectCategoryList", category1);
	}

	@Override
	public List<CategoryVO> subCategoryList(String category1) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".subCategoryList", category1);
	}

	@Override
	public CategoryVO selectSubCategory(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".selectSubCategory", product);
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList",area);
	}
}
