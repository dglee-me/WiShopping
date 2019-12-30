package com.lee.myapp.controls;

import java.io.File;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
	public void adminHome(Model model) throws Exception{
		logger.info("-------- ADMIN : ADMIN HOME METHOD=GET --------");
		
		//Setting
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public void serviceWriteGet(Model model) throws Exception{
		logger.info("-------- Service : ADMIN WRITE METHOD=GET --------");
		
		//Setting
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
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
	public String bannerRegistGET(HttpSession session,Model model) throws Exception{
		logger.info("-------- ADMIN : BANNER REGIST METHOD=GET --------");
		
		String path = "";
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			path = "admin/banner/regist";
		}else {
			path = "redirect:/";
		}

		//Setting
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
		
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
	public String bannerManagementGET(HttpSession session, Model model,String status) throws Exception{
		logger.info("-------- ADMIN : BANNER MANAGETMENT METHOD=GET --------");
		
		String path = "";
		
		MemberVO member = (MemberVO) session.getAttribute("login");

		if(member.getMlevel() == 2) {
			if(status == null) {
				status = "all";
			}
			
			if(status.equals("all")) {
				model.addAttribute("banners",adminService.bannerList("all"));
			}else {
				model.addAttribute("banners",adminService.bannerList("used"));
			}
			
			path = "admin/banner/management";
		}else {
			path = "redirect:/";
		}

		//Setting
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
		
		return path;
	}
	
	@ResponseBody
	@RequestMapping(value="/banner/updateStatus", method=RequestMethod.POST)
	public int bannerUpdateStatusPOST(HttpSession session, Model model, int bno, int status) throws Exception{
		logger.info("-------- ADMIN : BANNER UPDATE STATUS METHOD=POST --------");
		int result = 0;

		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("bno", bno);
			map.put("status", status);
			
			adminService.bannerStatusUpdate(map);
			
			result = 1;
		}
		
		return result;
	}
	
	@RequestMapping(value="/banner/modify", method=RequestMethod.GET)
	public void bannerModifyGET(HttpSession session, Model model,int bno) throws Exception{
		logger.info("-------- ADMIN : BANNER MODIFY METHOD=GET --------");
		logger.info("-------- ACCESSOR : "+((MemberVO)session.getAttribute("login")).getName()+", NUMBER : "+((MemberVO)session.getAttribute("login")).getMno()+" --------");
		logger.info("-------- ACCESS BANNER : "+bno+" --------");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			model.addAttribute("banner",adminService.bannerView(bno));
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/banner/modify", method=RequestMethod.POST)
	public int bannerModifyPOST(HttpSession session, Model model,BannerVO banner, MultipartFile file) throws Exception{
		logger.info("-------- ADMIN : BANNER MODIFY METHOD=POST --------");
		logger.info("-------- ACCESSOR : "+((MemberVO)session.getAttribute("login")).getName()+", NUMBER : "+((MemberVO)session.getAttribute("login")).getMno()+" --------");
		logger.info("-------- ACCESS BANNER : "+banner.getBno()+" --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			if(file != null ) {
				String imgUploadPath = uploadPath + File.separator + "imgUpload";
				String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
				
				//Set image name and upload image to server
				banner.setBannerurl("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath));
			}
			adminService.bannerUpdate(banner);
			
			result = 1;
		}
		
		return result;
	}
	

	@RequestMapping(value="/banner/delete", method=RequestMethod.GET)
	public String bannerDeleteGET(HttpSession session, Model model,int bno) throws Exception{
		logger.info("-------- ADMIN : BANNER DELETE METHOD=GET --------");
		logger.info("-------- ACCESSOR : "+((MemberVO)session.getAttribute("login")).getName()+", NUMBER : "+((MemberVO)session.getAttribute("login")).getMno()+" --------");
		logger.info("-------- ACCESS BANNER : "+bno+" --------");
		
		String path = "";

		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			adminService.bannerDelete(bno);
			
			path = "redirect:/admin/banner/management";
		}
		
		return path;			
	}
 }