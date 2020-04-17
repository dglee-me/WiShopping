package com.lee.myapp.controls;

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

@Controller
@RequestMapping("/admin/")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	AdminService adminService;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void adminHome(Model model) throws Exception{
		logger.info("-------- ADMIN : ADMIN HOME METHOD=GET --------");
		
		//Setting
		model.addAttribute("categories", adminService.categoryList());
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public void serviceWriteGet(Model model) throws Exception{
		logger.info("-------- Service : ADMIN WRITE METHOD=GET --------");
		
		//Setting
		model.addAttribute("categories", adminService.categoryList());
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String serviceWritePost(BoardVO board) throws Exception{
		logger.info("-------- Service : ADMIN WRITE METHOD=POST --------");
		
		/*
		 *  만약 글 작성 후 category가 공지사항이라면 redirect될 페이지를 고객센터 > 공지사항으로 설정
	     */
		String path = "redirect:/";
		
		if(board.getCategory().equals("공지사항")) {
			path = "redirect:/customer/notice";
		}

		adminService.write(board);
		
		return path;
	}
	
	@RequestMapping(value="/banner/regist", method=RequestMethod.GET)
	public String bannerRegistGET(HttpSession session,Model model) throws Exception{
		logger.info("-------- ADMIN : BANNER REGIST METHOD=GET --------");
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		String path = "";
		
		/*
		 * 로그인한 유저가 관리자일 경우 배너 등록 화면으로, 그렇지 않을 경우 메인화면으로 이동
		 */
		if(member.getMlevel() == 2) {
			path = "admin/banner/regist";
		}else {
			path = "redirect:/";
		}

		//Setting
		model.addAttribute("categories", adminService.categoryList());
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
		
		return path;
	}
	
	@ResponseBody
	@RequestMapping(value="/banner/regist", method=RequestMethod.POST)
	public int bannerRegistPOST(HttpSession session, BannerVO banner, MultipartFile file) throws Exception{
		logger.info("-------- ADMIN : BANNER REGIST METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		//If access member level is 2(Admin) over
		if(member.getMlevel() == 2) {
			adminService.bannerRegist(banner, file);
			
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
			if(status == null) status = "all"; // 만약 status가 null 이라면, all로 설정해준다.
				
			//status에 맞춰 사용 중인 배너만 보여줄 것인지, 전체를 보여줄 것인지 설정해준다.
			if(status.equals("all")) model.addAttribute("banners",adminService.bannerList("all"));
			else model.addAttribute("banners",adminService.bannerList("used"));
			
			path = "admin/banner/management";
		}else {
			path = "redirect:/";
		}

		//Setting
		model.addAttribute("categories", adminService.categoryList());
		model.addAttribute("headerBanners", adminService.mainBannerList("헤더")); // Main banner list in this view
		
		return path;
	}
	
	@ResponseBody
	@RequestMapping(value="/banner/updateStatus", method=RequestMethod.POST)
	public int bannerUpdateStatusPOST(HttpSession session, Model model, BannerVO banner) throws Exception{
		logger.info("-------- ADMIN : BANNER UPDATE STATUS METHOD=POST --------");
		int result = 0;

		MemberVO member = (MemberVO) session.getAttribute("login");
		
		//관리자일 경우에만 동작한다.
		if(member.getMlevel() == 2) {
			/*
			 * 기존 배너 상태가 1일 경우, 0으로 수정하여 종료 상태로 전환, 0일 경우, 1으로 수정하여 사용 중인 상태로 전환한다.
			 */
			adminService.bannerStatusUpdate(banner);
			
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
			//Setting
			model.addAttribute("banner",adminService.bannerView(bno));
			model.addAttribute("categories", adminService.categoryList());
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
			adminService.bannerUpdate(banner, file);
			
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