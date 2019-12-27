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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.service.AdminService;
import com.lee.myapp.utils.UploadFileUtils;

@Controller
@RequestMapping("/admin/")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	AdminService adminService;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void adminHome() throws Exception{
		logger.info("-------- ADMIN : ADMIN HOME METHOD=GET --------");
		
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public void serviceWriteGet() throws Exception{
		logger.info("-------- Service : ADMIN WRITE METHOD=GET --------");
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String serviceWritePost(BoardVO board) throws Exception{
		logger.info("-------- Service : ADMIN WRITE METHOD=POST --------");

		adminService.write(board);		
		if(board.getCategory().equals("공지사항")) {
			return "redirect:/notice/list";
		}
		return "redirect:/";
	}
	
	@RequestMapping(value="/banner/regist", method=RequestMethod.GET)
	public String bannerRegistGET(HttpSession session) throws Exception{
		logger.info("-------- ADMIN : BANNER REGIST METHOD=GET --------");
		
		String path = "";
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			path = "admin/banner/regist";
		}else {
			path = "redirect:/";
		}
		
		return path;
	}
	
	@ResponseBody
	@RequestMapping(value="/banner/regist", method=RequestMethod.POST)
	public int bannerRegistPOST(HttpSession session,BannerVO banner, MultipartFile file) throws Exception{
		logger.info("-------- ADMIN : BANNER REGIST METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		//If access member level is 2(Admin) over
		if(member.getMlevel() == 2) {
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			
			//Set image name and upload image to server
			banner.setBannerurl("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath));
			adminService.bannerRegist(banner);
			
			result = 1;
		}else {
			result = 2;
		}
		
		return result;
	}
	
	@RequestMapping(value="/banner/management", method=RequestMethod.GET)
	public String bannerManagementGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- ADMIN : BANNER MANAGETMENT METHOD=GET --------");
		
		String path = "";
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			model.addAttribute("banners",adminService.bannerList());
			
			path = "admin/banner/management";
		}else {
			path = "redirect:/error";
		}
		
		return path;
	}
 }