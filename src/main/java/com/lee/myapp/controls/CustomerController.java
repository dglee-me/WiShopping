package com.lee.myapp.controls;

import java.io.File;

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
import com.lee.myapp.domain.QuestionsVO;
import com.lee.myapp.service.CustomerService;
import com.lee.myapp.utils.UploadFileUtils;

@Controller
@RequestMapping("/customer/")
public class CustomerController {
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	CustomerService customerService;
	
	@RequestMapping(value="/questions", method=RequestMethod.GET)
	public String customerQuestionsGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- CUSTOMER : QUESTIONS METHOD = GET --------");
		
		String path = "";
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			path = "/customer/questions";
			
			model.addAttribute("headerBanners", customerService.mainBannerList("헤더")); // Main banner list in this view
		}else {
			path = "/auth/login";
		}
		
		return path;
	}
	
	@RequestMapping(value="/questions", method=RequestMethod.POST)
	public String customerQuestionsPOST(HttpSession session, QuestionsVO question, @RequestParam(value="question[images_url]") MultipartFile[] images) throws Exception{
		logger.info("-------- CUSTOMER : QUESTIONS METHOD = POST --------");
		
		String path = "";
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			
			String url = "";
			for(int i=0;i<images.length;i++) {
				if(images[i].getOriginalFilename().equals("")) continue;
				
				if(i == 0) {
					url = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
					continue;
				}
				url = url + ";" + "/" + "imgUpload" + ymdPath + "/" +UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
			}

			question.setMno(member.getMno());
			question.setImagesurl(url);
			
			customerService.questionRegist(question);
			
			path = "/customer/notice";
		}else {
			path = "/auth/login";
		}
		
		return path;
	}
}