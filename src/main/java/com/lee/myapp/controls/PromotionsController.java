package com.lee.myapp.controls;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.CommentPageMaker;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.PromotionsCommentVO;
import com.lee.myapp.domain.PromotionsVO;
import com.lee.myapp.service.PromotionsService;
import com.lee.myapp.utils.FileDelete;
import com.lee.myapp.utils.UploadFileUtils;

@Controller
@RequestMapping("/promotions/")
public class PromotionsController {
	private static final Logger logger = LoggerFactory.getLogger(PromotionsController.class);

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	PromotionsService promotionsService;
	
	//Update promotion status every 00:00 a.m.
	@Scheduled(cron="0 0 00 * * *")
	public void endPromotions() throws Exception{
		logger.info("-------- PROMOTION STATUS UPDATE --------");
		promotionsService.endPromotion();
	}
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void promotionsMainGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS MAIN METHOD=GET --------");
		logger.info("-------- ACCESSOR NAME ="+ ((MemberVO)session.getAttribute("login")).getName() + ", NUMBER = "+ ((MemberVO)session.getAttribute("login")).getMno() 
				+" METHOD=GET --------");

		//Setting
		model.addAttribute("headerBanners", promotionsService.mainBannerList("헤더")); // Main banner list in this view
		model.addAttribute("promotions", promotionsService.promotionList("all"));
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public void promotionsRegisterGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS REGIST METHOD=GET --------");
		logger.info("-------- ACCESSOR NAME ="+ ((MemberVO)session.getAttribute("login")).getName() + ", NUMBER = "+ ((MemberVO)session.getAttribute("login")).getMno() 
				+" METHOD=GET --------");

		//Setting
		model.addAttribute("headerBanners", promotionsService.mainBannerList("헤더")); // Main banner list in this view
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String promotionsRegisterPOST(HttpSession session, Model model, PromotionsVO promotion,
			@RequestParam("promotions[images_url]") MultipartFile[] images, @RequestParam("promotions[thumbnail_url]") MultipartFile thumb) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS REGIST METHOD=POST --------");
		logger.info("-------- ACCESSOR NAME = "+ ((MemberVO)session.getAttribute("login")).getName() + ", NUMBER = "+ ((MemberVO)session.getAttribute("login")).getMno() 
				+" METHOD=GET --------");
		String path = "";
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			
			//Set inner images naming and upload to server
			String innerUrl = "";
			
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
			
			promotionsService.promotionRegist(promotion);
			
			path = "redirect:/promotions/main";
		}else {
			path = "redirect:/";
		}
		
		return path;
	}
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public void promotionViewGET(HttpSession session, Model model, CommentCriteria cri) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS VIEW METHOD=GET --------");
		logger.info("-------- VIEW PNO = " + cri.getPno() + " --------");
		
		PromotionsVO promotion = promotionsService.promotionView(cri.getPno());
		
		//Images_url split to show
		String[] images_url = promotion.getImagesurl().split(";");		
		
		List<String> imageList = new ArrayList<String>();
		
		for(int i=0;i<images_url.length;i++) {
			imageList.add(images_url[i]);
		}
		
		//Comment paging setting
		CommentPageMaker pageMaker = new CommentPageMaker();
		pageMaker.setCri(cri);
		int count = promotionsService.listCount(cri.getPno());
		pageMaker.setTotalCount(count);
		
		//Settings
		model.addAttribute("headerBanners", promotionsService.mainBannerList("헤더")); // Main banner list in this view
		model.addAttribute("promotion", promotion);
		model.addAttribute("images", imageList);
		model.addAttribute("comment_count",count);
		model.addAttribute("comments",promotionsService.listPaging(cri));
		model.addAttribute("pageMaker",pageMaker);
	}
	
	@RequestMapping(value="/management", method=RequestMethod.GET)
	public void promotionModifyGET(HttpSession session, Model model, String status) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS PROMOTION MANAGEMENT METHOD=GET --------");
		logger.info("-------- ACCESSOR MNO = " + ((MemberVO)session.getAttribute("login")).getMno() + " --------");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			if(status == null){
				status = "all";
			}
			
			if(status.equals("all")) {
				model.addAttribute("promotions", promotionsService.promotionList("all"));
			}else {
				model.addAttribute("promotions", promotionsService.promotionList("used"));
			}

			//Settings
			model.addAttribute("headerBanners", promotionsService.mainBannerList("헤더")); // Main banner list in this view
		}

	}
	
	@ResponseBody
	@RequestMapping(value="/commentRegist", method=RequestMethod.POST)
	public List<PromotionsCommentVO> promotionCommentRegistPOST(HttpSession session, PromotionsCommentVO comment, CommentCriteria cri) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS COMMENT REGIST METHOD=POST --------");
		logger.info("-------- THIS PNO = " + comment.getPno() + " --------");
		logger.info("-------- REGISTER MNO = " + ((MemberVO)session.getAttribute("login")).getMno() + " --------");

		MemberVO member = (MemberVO)session.getAttribute("login");
		List<PromotionsCommentVO> list = new ArrayList<PromotionsCommentVO>();
		
		if(member != null) {
			comment.setMno(member.getMno());
			
			promotionsService.commentRegist(comment);
			list = promotionsService.listPaging(cri);	
		}

		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/commentListUpdate")
	public List<PromotionsCommentVO> commentListUpdatePOST(CommentCriteria cri) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS COMMENT LIST UPDATE METHOD=POST --------");
		logger.info("-------- THIS PNO = " + cri.getPno() + " --------");
		logger.info("-------- CRITERIA INFO = " + cri.toString() + " --------");
		
		List<PromotionsCommentVO> comments = new ArrayList<PromotionsCommentVO>();
		comments = promotionsService.listPaging(cri);		
		
		return comments;
	}

	@ResponseBody
	@RequestMapping(value="/commentListCount")
	public int commentListCountPOST(int pno) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS COMMENT LIST UPDATE METHOD=POST --------");
		logger.info("-------- THIS PNO = " + pno + " --------");
		
		int count = promotionsService.listCount(pno);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateStatus", method=RequestMethod.POST)
	public int promotionsStatusUpdate(HttpSession session, PromotionsVO promotion) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS UPDATE STATUS METHOD=POST --------");
		logger.info("-------- PNO : "+promotion.getPno()+"ACCESSOR : "+((MemberVO)session.getAttribute("login")).getMno()+" --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			promotionsService.updateStatus(promotion);
			
			result = 1;
		}
		
		return result;
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void promotionModifyGET(HttpSession session, Model model,int pno) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS MODIFY METHOD=GET --------");
		logger.info("-------- PNO : "+pno+" --------");
		logger.info("-------- ACCESSOR : "+((MemberVO)session.getAttribute("login")).getMno()+" --------");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			PromotionsVO promotion = promotionsService.promotionView(pno);
			
			String[] images = promotion.getImagesurl().split(";");
			
			//Settings
			model.addAttribute("headerBanners", promotionsService.mainBannerList("헤더")); // Main banner list in this view
			model.addAttribute("promotion", promotion);
			model.addAttribute("images", images);
		}
	}

	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String promotionModifyPOST(HttpSession session, PromotionsVO promotion,
			@RequestParam("promotions[images_url]") MultipartFile[] images, @RequestParam("promotions[thumbnail_url]") MultipartFile thumb) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS MODIFY METHOD=POST --------");
		logger.info("-------- ACCESSOR NAME = "+ ((MemberVO)session.getAttribute("login")).getName() + ", NUMBER = "+ ((MemberVO)session.getAttribute("login")).getMno() 
				+" --------");
		
		PromotionsVO exist_promotion = promotionsService.promotionView(promotion.getPno());
		String[] exist_images = exist_promotion.getImagesurl().split(";");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			String imgUploadPath = uploadPath + "/" + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			
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
			}
			
			//If the image has been changed, delete existing saved images
			if(images_change) {
				for(int i=0;i<exist_images.length;i++) {
					FileDelete.deleteFile(exist_images[i]);
				}
			}

			//If change inner images, change this path and upload images to server
			String imagesUrl = "";
			for(int i=0;i<images.length;i++) {
				if(images[i].getOriginalFilename().equals("")) break; //Exception of input file inside btn_add div
				
				if(i == 0) {// When if i is 0
					imagesUrl = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
				}else {//When if not i is 0
					imagesUrl += ";" + "/" + "imgUpload" + ymdPath + "/" +UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
				}
			}
			
			//Set imageurl on the promotion object and run modify query
			promotion.setImagesurl(imagesUrl);
			promotionsService.modifyPromotion(promotion);
			
			return "redirect:/promotions/management";
		}
		
		return "redirect:/error";
	}

	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String promotionDeleteGET(HttpSession session, Model model,int pno) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS DELETE METHOD=GET --------");
		logger.info("-------- PNO : "+pno+"ACCESSOR : "+((MemberVO)session.getAttribute("login")).getMno()+" --------");
		
		String path ="redirect:/error";
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			promotionsService.deletePromotion(pno);
			
			path = "redirect:/promotions/management";
		}
		
		return path;
	}
}