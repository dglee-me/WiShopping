package com.lee.myapp.controls;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.service.MemberService;

@Controller
@RequestMapping("/auth/*")
public class AuthController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	MemberService memberService;
	
	@RequestMapping(value="/auth/emailCheck", method=RequestMethod.GET)
	@ResponseBody
	public int emailCheck(@RequestParam("join_email") String join_email) throws Exception{
		return memberService.emailCheck(join_email);
	}
	
	@RequestMapping(value="/auth/join", method=RequestMethod.GET)
	public void joinMemberGET() throws Exception{
		logger.info("-------- AUTH : MEMBER JOIN METHOD=GET --------");
	}
	
	@RequestMapping(value="/auth/join", method=RequestMethod.POST)
	public String joinMemberPOST(MemberVO member) throws Exception{
		logger.info("-------- AUTH : MEMBER JOIN METHOD=POST --------");
		if(memberService.create(member) == 1) {
			logger.info("-------- AUTH : MEMBER JOIN COMPLETE EMAIL : "+member.getEmail()+"--------");
			return "redirect:/";
		}else {
			logger.info("-------- AUTH : MEMBER JOIN FAIL --------");
			
			return "redirect:/error";
		}
	}

	@RequestMapping(value="/auth/joinConfirm", method=RequestMethod.GET)
	public String joinConfirm(@ModelAttribute("member") MemberVO member, Model model ) throws Exception{
		logger.info(member.getEmail() + " : AUTH Confirmed");
		
		memberService.authConfirm(member);
		
		return "/auth/joinConfirm";
	}
	
	@RequestMapping(value="/auth/login", method=RequestMethod.GET)
	public void loginGET() throws Exception{
		logger.info("-------- AUTH : MEMBER LOGIN METHOD=GET --------");
	}
	
	@RequestMapping(value="/auth/login", method=RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception{
		logger.info("-------- AUTH : MEMBER LOGIN METHOD=POST --------");
		
		HttpSession session = request.getSession();
		
		MemberVO loginMember = memberService.loginInfo(member);
		
		if(loginMember == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			
			return "redirect:/auth/login";
		}else {
			if(loginMember.getAuth().equals("Y")) {
				session.setAttribute("member", loginMember);

				return "redirect:/";
			}else {
				session.setAttribute("member", null);
				rttr.addFlashAttribute("msg",true);
				return "redirect:/auth/login";
			}
		}
	}
	
	@RequestMapping(value="/auth/logout", method=RequestMethod.GET)
	public String logoutGET(HttpServletRequest request) throws Exception{
		logger.info("-------- AUTH : MEMBER LOGOUT --------");
		
		request.getSession().removeAttribute("member");
		
		return "redirect:/";
	}
}
