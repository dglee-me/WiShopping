package com.lee.myapp.controls;

import java.sql.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.util.WebUtils;

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
	public String loginPOST(HttpServletRequest request, HttpServletResponse response, MemberVO member, RedirectAttributes rttr) throws Exception{
		logger.info("-------- AUTH : MEMBER LOGIN METHOD=POST --------");

		HttpSession session = request.getSession();
		
		MemberVO loginMember = memberService.loginInfo(member);
		
		//������ login Session�� ������ ��� ���� �� ����
		if(session.getAttribute("login") != null) {
			session.removeAttribute("login");
		}
		
		if(loginMember == null) {
			session.setAttribute("login", null);
			rttr.addFlashAttribute("msg", false);
			
			return "redirect:/auth/login";
		}else {
			if(loginMember.getAuth().equals("Y")) {
				session.setAttribute("login", loginMember);
				if(member.isUseCookie()) {
					Cookie cookie = new Cookie("loginCookie",session.getId());
					cookie.setPath("/");
					
					int amount = 60*60*24*7; 
					cookie.setMaxAge(amount);//7�Ϸ� ��ȿ�ð� ����
					
					//Cookie ����
					response.addCookie(cookie);
					
					Date sessionLimit = new Date(System.currentTimeMillis() + (1000*amount));
					
					memberService.keepLogin(loginMember.getEmail(), session.getId(), sessionLimit);
				}
			}else {
				session.setAttribute("login", null);
				rttr.addFlashAttribute("msg",true);
				return "redirect:/auth/login";
			}
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/auth/logout", method=RequestMethod.GET)
	public String logoutGET(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.info("-------- AUTH : MEMBER LOGOUT --------");
		
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("login");
		
		if(obj != null) {
			MemberVO member = (MemberVO) obj;
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				
				response.addCookie(loginCookie);
				Date date = new Date(System.currentTimeMillis());
				try {
					memberService.keepLogin(member.getEmail(), session.getId(), date);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}

		return "redirect:/";
	}
}