package com.lee.myapp.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductQuestionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.domain.ReviewLikeVO;
import com.lee.myapp.domain.ReviewVO;

public interface ProductService {
	public void register(ProductVO product, MultipartFile file1, MultipartFile[] file2) throws Exception;
	public void register_option(ProductOptionVO option, int[] inventory, char has_option) throws Exception;
	public List<ProductOptionVO> view_option(int pno) throws Exception;
	public void not_used_option(int pno) throws Exception;
	public List<ProductVO> list(ProductVO product) throws Exception;
	public ProductVO view(CommentCriteria cri) throws Exception;
	public void modifyProduct(ProductVO product, MultipartFile file1, MultipartFile[] file2, ProductOptionVO option,int[] inventory, char has_option) throws Exception;
	public void deleteProduct(ProductVO product) throws Exception;
	public int checkInventory(int ono) throws Exception;

	public int isSeller(int mno) throws Exception;
	
	//Review
	public ReviewVO reviewView(int rno) throws Exception;
	public void reviewRegist(ReviewVO review, MultipartFile image) throws Exception;
	public List<ReviewVO> reviewList(int pno) throws Exception;
	public List<ReviewVO> listPaging(CommentCriteria cri) throws Exception;
	public int listCount(int pno) throws Exception;
	public int updateReviewStatus(ReviewVO review) throws Exception;
	public int deleteReview(ReviewVO review) throws Exception;
	public int modifyReview(ReviewVO review, MultipartFile image, boolean image_check) throws Exception;
	
	//Review like
	public List<ReviewLikeVO> reviewLike(ReviewVO review) throws Exception;
	public List<ReviewLikeVO> reviewLikeCount(int pno) throws Exception;
	
	public int checkLike(ReviewLikeVO like) throws Exception;
	public int registLike(ReviewLikeVO like) throws Exception;
	public int deleteLike(ReviewLikeVO like) throws Exception;
	
	//Product question
	public void questionRegist(ProductQuestionVO question) throws Exception;
	public void answerRegist(ProductQuestionVO question) throws Exception;
	public List<ProductQuestionVO> questionList(CommentCriteria cri) throws Exception;
	public int questionListCount(int pno) throws Exception;
	public int questionStatusUpdate(int qno) throws Exception;
	public int questionDelete(int pno) throws Exception;
	public int answerDelete(ProductQuestionVO question) throws Exception;

	//Category list
	public List<CategoryVO> categoryList() throws Exception;
	public List<CategoryVO> selectCategoryList(String category1) throws Exception;
	public List<CategoryVO> subCategoryList(String category1) throws Exception;
	public CategoryVO selectSubCategory(ProductVO product) throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}