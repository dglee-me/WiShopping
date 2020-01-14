package com.lee.myapp.controls;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.service.MemberService;

@Controller
@RequestMapping("/mypage/")
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Inject
	MemberService memberService;
	
	@RequestMapping(value="/request", method=RequestMethod.GET)
	public String mypageMainGET(HttpSession session, Model model) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			logger.info("-------- MYPAGE : REQUEST METHOD = GET --------");
			logger.info("-------- ACCESSOR : MNO " + ((MemberVO)session.getAttribute("login")).getMno() + " --------");
			
			//Setting
			model.addAttribute("member", (MemberVO)session.getAttribute("login"));
			
			return "/mypage/request";
		}else {
			logger.info("-------- MYPAGE : REQUEST METHOD = GET --------");
			logger.info("-------- LOGINED MEMBER NONE --------");
			
			return "redirect:/auth/login";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/request", method=RequestMethod.POST)
	public int mypageMainPOST(HttpSession session, Model model, String email, String pw) throws Exception{
		MemberVO member  = (MemberVO)session.getAttribute("login");
		
		int result = 0;
		
		if(member != null) {
			logger.info("-------- MYPAGE : REQUEST METHOD = POST --------");
			logger.info("-------- ACCESSOR : MNO " + ((MemberVO)session.getAttribute("login")).getMno() + " --------");
		
			member = memberService.loginInfo(new MemberVO().setEmail(email).setPw(pw));
			
			if(member != null) result = 1; //If correct email and pw
			else result = 2;
			
		}else {
			logger.info("-------- MYPAGE : REQUEST METHOD = POST --------");
			logger.info("-------- LOGINED MEMBER NONE --------");
			
			result = 3;
		}
		
		return result;
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void mypageModifyGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- MYPAGE : MODIFY METHOD = GET --------");
		
		//Setting
		model.addAttribute("headerBanners", memberService.mainBannerList("헤더")); // Main banner list in this view
		model.addAttribute("member", (MemberVO)session.getAttribute("login")); // Main banner list in this view
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String mypageModifyPOST(MemberVO member
			, @RequestParam(value="user[tel_code]") String tel_code
			, @RequestParam(value="user[tel_1]") String tel_1
			, @RequestParam(value="user[tel_2]") String tel_2) throws Exception{
		logger.info("-------- MYPAGE : MODIFY METHOD = POST --------");
		
		member.setTel(tel_code + tel_1 + tel_2);

		if(member.getPw().equals("")) {
			member.setPw(null);
		}
		
		memberService.modifyUserInfo(member);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="withdrawal", method=RequestMethod.GET)
	public String mypageWithdrawalGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- MYPAGE : WITHDRAWAL METHOD = GET --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		if(member != null) {
			//Setting
			model.addAttribute("headerBanners", memberService.mainBannerList("헤더")); // Main banner list in this view
			
			return "/mypage/withdrawal";
		}else {
			return "redirect:/";
		}
		
	}
	
	@RequestMapping(value="withdrawal", method=RequestMethod.POST)
	public String mypageWithdrawalPOST(HttpSession session) throws Exception{
		logger.info("-------- MYPAGE : WITHDRAWAL METHOD = POST --------");
		

		MemberVO member = (MemberVO)session.getAttribute("login");
		if(member != null) {
			memberService.withdrawalUser((MemberVO)session.getAttribute("login"));
			session.invalidate();
		}else {
			return "redirect:/error";
		}
		
		
		return "redirect:/";
	}
}
