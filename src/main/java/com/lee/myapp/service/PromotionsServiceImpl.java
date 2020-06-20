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
import com.lee.myapp.domain.PromotionsCommentVO;
import com.lee.myapp.domain.PromotionsReportVO;
import com.lee.myapp.domain.PromotionsVO;
import com.lee.myapp.persistence.PromotionsDAO;
import com.lee.myapp.utils.FileDelete;
import com.lee.myapp.utils.UploadFileUtils;

@Service
public class PromotionsServiceImpl implements PromotionsService{
	
	@Inject
	PromotionsDAO promotionsDAO;
	
	@Resource(name="uploadPath")
	private String uploadPath;

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.mainBannerList(area);
	}

	@Override
	public List<PromotionsVO> promotionList(String parameter) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.promotionList(parameter);
	}
	
	@Override
	public int promotionRegist(PromotionsVO promotion, MultipartFile thumb, MultipartFile[] images) throws Exception {
		// TODO Auto-generated method stub
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);

		//Set inner images naming and upload to server
		String innerUrl = "";
		
		/*
		 * 상세 이미지의 갯수만큼 반복하며 각 이미지를 서버에 업로드, 첫번째에는 이미지 주소를 저장, 그 이후에는 ;로 split 할 수 있는 구분자를 넣어주고 그 뒤에 이미지 주소를 저장하여준다.
		 */
		for(int i=0;i<images.length-1;i++) {
			if(i == 0) {
				innerUrl = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
				continue;
			}
			innerUrl = innerUrl + ";" + "/" + "imgUpload" + ymdPath + "/" +UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
		}
		
		//Set naming and upload image to server
		promotion.setThumbnailurl("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, thumb.getOriginalFilename(), thumb.getBytes(), ymdPath));
		promotion.setImagesurl(innerUrl);
		
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
	public int updateStatus(PromotionsVO promotion) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.updateStatus(promotion);
	}

	@Override
	public int deletePromotion(int pno) throws Exception {
		// TODO Auto-generated method stub
		
		PromotionsVO promotion = promotionView(pno);
		
		//Image file delete
		String thumbnail = promotion.getThumbnailurl();
		FileDelete.deleteFile(thumbnail);

		String[] images = promotion.getImagesurl().split(";");
		
		for(int i=0;i<images.length;i++) {
			FileDelete.deleteFile(images[i]);
		}
		
		return promotionsDAO.deletePromotion(pno);
	}

	@Override
	public int modifyPromotion(PromotionsVO promotion, MultipartFile thumb, MultipartFile[] images) throws Exception {
		// TODO Auto-generated method stub
		String imgUploadPath = uploadPath + "/" + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		
		/*
		 * 기존의 프로모션 정보를 가져온다. 그 이유는 기존의 이미지를 비교하고, 다르다면 기존의 이미지를 삭제해야 하기 때문 
		 */
		PromotionsVO exist_promotion = promotionView(promotion.getPno());
		String[] exist_images = exist_promotion.getImagesurl().split(";");
		
		//If change thumbnail image, change this path and upload image to server
		if(!thumb.getOriginalFilename().equals("")) {
			//Delete exist thumbnail image file
			FileDelete.deleteFile(exist_promotion.getThumbnailurl());
			
			//Upload new thumbnail image file and setting to object
			promotion.setThumbnailurl("/" + "imgUpload" + ymdPath + "/" 
					+ UploadFileUtils.fileUpload(imgUploadPath, thumb.getOriginalFilename(), thumb.getBytes(), ymdPath));
		}
		
		//Confirm image change
		boolean images_change = false;
		
		for(int i=0;i<images.length;i++) {
			if(images[i].getOriginalFilename().equals("")) continue;
			
			images_change = true;
			break;
		}

		//If the inner image has been changed, delete existing saved images and change this path and upload images to server
		if(images_change) {
			for(int i=0;i<exist_images.length;i++) {
				FileDelete.deleteFile(exist_images[i]);
			}

			String imagesUrl = "";
			
			for(int i=0;i<images.length;i++) {
				if(images[i].getOriginalFilename().equals("")) break; //Exception of input file inside btn_add div
				
				if(i == 0) {// When if i is 0
					imagesUrl = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
				}else {//When if not i is 0
					imagesUrl += ";" + "/" + "imgUpload" + ymdPath + "/" +UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
				}
			}

			//Save to object if image changes
			if(!imagesUrl.equals("")) {
				promotion.setImagesurl(imagesUrl);
			}
		}
		
		return promotionsDAO.modifyPromotion(promotion);
	}

	/* Comment */
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

	@Override
	public int deleteComment(int rno) throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.deleteComment(rno);
	}

	@Override
	public void commentReport(PromotionsReportVO report) throws Exception {
		// TODO Auto-generated method stub
		promotionsDAO.commentReport(report);
	}

	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return promotionsDAO.categoryList();
	}
}