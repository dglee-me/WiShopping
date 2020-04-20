package com.lee.myapp.controls;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.SellerVO;
import com.lee.myapp.service.MemberService;

@Controller
@RequestMapping("/auth/")
public class AuthController {
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	@Inject
	MemberService memberService;

	//Reset token value at 00:00 a.m. daily
	@Scheduled(cron="0 0 00 * * *")
	public void endPromotions() throws Exception{
		logger.info("-------- RESET MEMBER TOKEN VALUE UPDATE --------");
		memberService.resetToken();
	}
	
	@RequestMapping(value="/emailCheck", method=RequestMethod.GET)
	@ResponseBody
	public int emailCheck(@RequestParam("join_email") String join_email) throws Exception{
		return memberService.emailCheck(join_email);
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void joinMemberGET() throws Exception{
		logger.info("-------- AUTH : MEMBER JOIN METHOD=GET --------");
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinMemberPOST(MemberVO member) throws Exception{
		logger.info("-------- AUTH : MEMBER JOIN METHOD=POST --------");
		
		//기본 설정은 error 페이지로 설정 후, 유저 가입이 성공적으로 완료될 시, 가입 후 index로 이동하도록 설정함
		String path = "redirect:/error";
		
		int result = memberService.create(member);
		
		if(result == 1) {
			logger.info("-------- AUTH : MEMBER JOIN COMPLETE EMAIL : "+member.getEmail()+"--------");
			path = "redirect:/";
		}else {
			logger.info("-------- AUTH : MEMBER JOIN FAIL --------");
		}
		
		return path;
	}

	@RequestMapping(value="/joinConfirm", method=RequestMethod.GET)
	public String joinConfirm(@ModelAttribute("member") MemberVO member) throws Exception{
		logger.info(member.getEmail() + " : AUTH Confirmed");
		
		memberService.authConfirm(member);
		
		return "/auth/joinConfirm";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void loginGET() throws Exception{
		logger.info("-------- AUTH : MEMBER LOGIN METHOD=GET --------");
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, HttpServletResponse response, MemberVO member, RedirectAttributes rttr) throws Exception{
		logger.info("-------- AUTH : MEMBER LOGIN METHOD=POST --------");
		
		return memberService.login(request, response, member, rttr);
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logoutGET(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.info("-------- AUTH : MEMBER LOGOUT --------");
		
		memberService.logout(request, response);
		
		return "redirect:/";
	}

	@RequestMapping(value="/seller_regist", method=RequestMethod.GET)
	public String seller_registGET(HttpSession session) throws Exception{
		logger.info("-------- AUTH : SELLER REGIST : GET --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			return "/auth/sellerregist";
		}else {
			return "/auth/login";
		}
	}
	
	@RequestMapping(value="/seller_regist", method=RequestMethod.POST)
	public String seller_registPOST(HttpSession session, SellerVO seller) throws Exception{
		logger.info("-------- AUTH : SELLER REGIST : POST --------");

		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			memberService.sellerRegist(seller);
			memberService.sellerUpdate(seller.getMno());
			
			return "redirect:/";
		}else {
			return "redirect:/auth/login";
		}
		
	}
	
	@RequestMapping(value="/password/new", method=RequestMethod.GET)
	public void passwordNewGET() throws Exception{
		logger.info("-------- AUTH : PASSWORD NEW : GET --------");
		logger.info("-------- AUTH : I FORGOT MY PASSWORD. --------");
		logger.info("-------- AUTH : I NEED TO CHANGE MY PASSWORD. --------");
	}
	
	@RequestMapping(value="/password/new", method=RequestMethod.POST)
	public String passwordNewPOST(@RequestParam(value="user[email]") String email) throws Exception{
		logger.info("-------- AUTH : PASSWORD NEW : POST --------");
		
		return memberService.newPassword(email);
	}
	
	@RequestMapping(value="/password/modify", method=RequestMethod.GET)
	public void passwordModifyGET(String token) throws Exception{
		logger.info("-------- AUTH : PASSWORD MODIFY : GET --------");
	}
	
	@RequestMapping(value="/password/modify", method=RequestMethod.POST)
	public String passwordModifyPOST(HttpServletRequest request, HttpServletResponse response, String token
			, @RequestParam(value="user[password]") String password) throws Exception{
		logger.info("-------- AUTH : PASSWORD MODIFY : POST --------");
		
		return memberService.resetPassword(request, token, password);
	}

	@RequestMapping(value="/password/tokenExpire", method=RequestMethod.GET)
	public void tokenExpireGET() throws Exception{
		logger.info("-------- ! TOKEN EXPIRE ! --------");
	}
	
	@RequestMapping(value="/notseller", method=RequestMethod.GET)
	public void notSellerGET() throws Exception{
		logger.info("-------- ! NOT SELLER ! --------");
	}
}
