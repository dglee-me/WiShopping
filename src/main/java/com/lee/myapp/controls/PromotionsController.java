package com.lee.myapp.controls;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.MemberVO;
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
	
}