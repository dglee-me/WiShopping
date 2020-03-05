package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductQuestionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.domain.ReviewLikeVO;
import com.lee.myapp.domain.ReviewVO;
import com.lee.myapp.persistence.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService{
	@Inject
	ProductDAO productDAO;
	
	@Override
	public int register(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.register(product);
	}

	@Override
	public int register_option(ProductOptionVO option) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.register_option(option);
	}

	@Override
	public void delete_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		productDAO.delete_option(pno);
	}
	
	@Override
	public List<ProductVO> list(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.list(product);
	}

	@Override
	public ProductVO view(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.view(cri);
	}

	@Override
	public List<ProductOptionVO> view_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.view_option(pno);
	}

	@Override
	public void modifyProduct(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		productDAO.modifyProduct(product);
	}

	@Override
	public void deleteProduct(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		productDAO.deleteProduct(product);
	}

	@Override
	public int checkInventory(int ono) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.checkInventory(ono);
	}

	@Override
	public int isSeller(int mno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.isSeller(mno);
	}

	//Review
	@Override
	public ReviewVO reviewView(int rno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.reviewView(rno);
	}
	
	@Override
	public int reviewRegist(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.reviewRegist(review);
	}

	@Override
	public List<ReviewVO> reviewList(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.reviewList(pno);
	}

	@Override
	public List<ReviewVO> listPaging(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.listPaging(cri);
	}

	@Override
	public int listCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.listCount(pno);
	}

	@Override
	public int deleteReview(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.deleteReview(review);
	}

	@Override
	public int modifyReview(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.modifyReview(review);
	}

	@Override
	public List<ReviewLikeVO> reviewLike(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.reviewLike(review);
	}

	@Override
	public List<ReviewLikeVO> reviewLikeCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.reviewLikeCount(pno);
	}

	@Override
	public int updateReviewStatus(ReviewVO review) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.updateReviewStatus(review);
	}

	@Override
	public int checkLike(ReviewLikeVO like) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.checkLike(like);
	}

	@Override
	public int registLike(ReviewLikeVO like) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.registLike(like);
	}

	@Override
	public int deleteLike(ReviewLikeVO like) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.deleteLike(like);
	}

	//Product question
	@Override
	public void questionRegist(ProductQuestionVO question) throws Exception {
		// TODO Auto-generated method stub
		productDAO.questionRegist(question);
	}

	@Override
	public void answerRegist(ProductQuestionVO question) throws Exception {
		// TODO Auto-generated method stub
		productDAO.answerRegist(question);
	}

	@Override
	public List<ProductQuestionVO> questionList(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.questionList(cri);
	}

	@Override
	public int questionListCount(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.questionListCount(pno);
	}

	@Override
	public int questionStatusUpdate(int qno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.questionStatusUpdate(qno);
	}

	@Override
	public int questionDelete(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.questionDelete(pno);
	}

	@Override
	public int answerDelete(ProductQuestionVO question) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.answerDelete(question);
	}
	
	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return productDAO.categoryList();
	}
	@Override
	public List<CategoryVO> selectCategoryList(String category1) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.selectCategoryList(category1);
	}

	@Override
	public List<CategoryVO> subCategoryList(String category1) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.subCategoryList(category1);
	}

	@Override
	public CategoryVO selectSubCategory(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.selectSubCategory(product);
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.mainBannerList(area);
	}
}