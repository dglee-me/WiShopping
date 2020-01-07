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
import com.lee.myapp.domain.PageMaker;
import com.lee.myapp.domain.PromotionsCommentVO;
import com.lee.myapp.domain.PromotionsVO;
import com.lee.myapp.service.PromotionsService;
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
		model.addAttribute("promotions", promotionsService.promotionList());
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
	public void promotionModifyGET(HttpSession session, PromotionsVO promotion) throws Exception{
		logger.info("-------- PROMOTIONS : ACCESS PROMOTION MANAGEMENT METHOD=GET --------");
		logger.info("-------- ACCESSOR MNO = " + ((MemberVO)session.getAttribute("login")).getMno() + " --------");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			
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
}