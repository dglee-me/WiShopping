package com.lee.myapp.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductQuestionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.domain.ReviewLikeVO;
import com.lee.myapp.domain.ReviewVO;
import com.lee.myapp.persistence.ProductDAO;
import com.lee.myapp.utils.FileDelete;
import com.lee.myapp.utils.UploadFileUtils;

@Service
public class ProductServiceImpl implements ProductService{
	@Inject
	ProductDAO productDAO;

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Override
	public void register(ProductVO product, MultipartFile file1, MultipartFile[] file2) throws Exception {
		// TODO Auto-generated method stub
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String thumbUrl = null;
		
		//Thumbnail image upload to server
		thumbUrl = UploadFileUtils.fileUpload(imgUploadPath, file1.getOriginalFilename(), file1.getBytes(), ymdPath);
		product.setProductthumurl("/" + "imgUpload" + ymdPath + "/" + thumbUrl);	

		//Detail images upload to server
		String detailUrl = "";
		
		for(int i=0;i<file2.length-1;i++) {
			if(i == 0) {
				detailUrl = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
				continue;
			}
			detailUrl = detailUrl + ";"+ "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
		}
		
		product.setProducturl(detailUrl);
		
		//Insert product into database
		productDAO.register(product);
	}

	@Override
	public void register_option(ProductOptionVO option, int[] inventory, char has_option) throws Exception {
		// TODO Auto-generated method stub
		/*
		 * has_option을 체크한 경우 T로 controller에 넘어오며,옵션을 사용한다는 뜻이다.
		 * has_option이 T인 경우, 옵션갯수만큼 반복문을 수행하여 regist 한다.
		 * has_option이 F인 경우, 옵션 갯수는 1개이므로, 1번만 regist를 수행한다.
		 */
		//Create options for a product and insert into database
		if(has_option == 'T') {
			int inventory_count = 0;
			String[] array_option = option.getOptioncolor().split(",");

			for(int i=0;i<array_option.length;i++) {
				String[] temp = array_option[i].split("\\#\\$\\%");
				
				option.setOptioncolor(temp[0])
					.setOptionsize(temp[1])
					.setInventory(inventory[inventory_count++]);

				productDAO.register_option(option);
			}
		}else {
			productDAO.register_option(option);
		}
	}

	@Override
	public void not_used_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		productDAO.not_used_option(pno);
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
	public void modifyProduct(ProductVO product, MultipartFile file1, MultipartFile[] file2, ProductOptionVO option, int[] inventory, char has_option) throws Exception {
		// TODO Auto-generated method stub
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);

		CommentCriteria cri = new CommentCriteria().setMno(product.getMno()).setPno(product.getPno());
		ProductVO exist_product = view(cri);

		if(file1.getOriginalFilename() != "") {
			//Set thumbnail image name and upload image to server and delete exist image
			FileDelete.deleteFile(exist_product.getProductthumurl());
			product.setProductthumurl("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file1.getOriginalFilename(), file1.getBytes(), ymdPath));
		}
		
		//Detail images upload to server
		for(int i=0;i<file2.length;i++) {
			if(file2[i].getOriginalFilename() == "") break; //만약 i번째 파일이 업로드되지 않았다면 넘어간다.
			
			if(i == 0) {
				product.setProducturl("/" + "imgUpload" + ymdPath + "/" 
										+ UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath));
			}else {
				product.setProducturl(product.getProducturl() 
						+";" + "/" + "imgUpload" + ymdPath + "/" 
						+ UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath));
			}
		}

		/*
		 * 새로 추가한 이미지가 있을 경우, 기존의 url을 가져와서 파일을 삭제해줍니다.
		 */
		if(product.getProducturl() != null) {
			String[] arr_exist = exist_product.getProducturl().split(";");
			
			for(int i=0;i<arr_exist.length;i++) {
				FileDelete.deleteFile(arr_exist[i]);
			}
		}
		
		productDAO.modifyProduct(product);
		
		/*
		 * 상품 옵션을 삭제 후 새로 regist 한다.
		 */
		//Exist option delete and new option regist
		not_used_option(product.getPno());
		register_option(option, inventory, has_option);
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
	public void reviewRegist(ReviewVO review, MultipartFile image) throws Exception {
		// TODO Auto-generated method stub
		/*
		 * 이미지가 있다면 이미지를 서버에 업로드 후 db에 이미지 경로를 저장. 이미지가 없다면 db에 noImage라는 문자열을 저장하며,
		 * 리뷰를 저장한 이후, review_status를 작성완료 상태로 바꾸어준다.
		 */
		if(image != null) {
			String imgUploadPath = uploadPath + "/" + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);

			review.setContentimg("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, image.getOriginalFilename(), image.getBytes(), ymdPath));
		}else {
			review.setContentimg("noImage");
		}
		
		productDAO.updateReviewStatus(review);
		productDAO.reviewRegist(review);
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
	public int modifyReview(ReviewVO review, MultipartFile image, boolean image_check) throws Exception {
		// TODO Auto-generated method stub
		ReviewVO exist_review = reviewView(review.getRno());
		
		if(image_check) {
			if(image != null) {
				if(!exist_review.getContentimg().equals("noImage")) {
					FileDelete.deleteFile(exist_review.getContentimg());
				}
			
				String imgUploadPath = uploadPath + "/" + "imgUpload";
				String ymdPath = UploadFileUtils.calcPath(imgUploadPath);

				review.setContentimg("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, image.getOriginalFilename(), image.getBytes(), ymdPath));
			}
		}else {
			if(!exist_review.getContentimg().equals("noImage")) {
				FileDelete.deleteFile(exist_review.getContentimg());
				
				review.setContentimg("noImage");
			}
		}
		
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