package com.lee.myapp.controls;

import java.sql.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.SellerVO;
import com.lee.myapp.service.MemberService;
import com.lee.myapp.utils.MailUtils;
import com.lee.myapp.utils.TempKey;

@Controller
@RequestMapping("/auth/")
public class AuthController {
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	@Inject
	MemberService memberService;
	
	@Inject
	private JavaMailSender mailSender;


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
		if(memberService.create(member) == 1) {
			logger.info("-------- AUTH : MEMBER JOIN COMPLETE EMAIL : "+member.getEmail()+"--------");
			return "redirect:/";
		}else {
			logger.info("-------- AUTH : MEMBER JOIN FAIL --------");
			
			return "redirect:/error";
		}
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

		HttpSession session = request.getSession();
		
		MemberVO loginMember = memberService.loginInfo(member);
		
		//기존에 login Session이 존재할 경우 기존 값 제거
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
					cookie.setMaxAge(amount);//7일로 유효시간 설정
					
					//Cookie 적용
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
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
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
		
		MemberVO member = memberService.newPassword(email);
		
		//Authentication Key create
		String token = new TempKey().getKey(36,false);
		
		member.setToken(token);
		
		memberService.newPasswordTokenSet(member);
		
		// Mail Send 부분
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[위쇼핑] 비밀번호 재설정 안내");
		sendMail.setText(new StringBuffer().append("<h1>[비밀번호 재설정]</h1>")
				.append("<p>안녕하세요, " + member.getName()  + " 님. 비밀번호를 재설정 하시려면 하단의 링크를 클릭하여주세요.</p>")
				.append("<a href='http://localhost:8081/WiShopping/auth/password/modify?token="+token+"'>")
				.append("[비밀번호 재설정]")
				.append("</a>")
				.append("<br/>")
				.append("<p>*만약 본인이 재설정 신청을 한게 아니라면, 본 메일을 무시해도 좋습니다.<p>").toString());

		sendMail.setFrom("dglee.dev@gmail.com ", "WiSHopping");
		sendMail.setTo(member.getEmail());
		sendMail.send();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/password/modify", method=RequestMethod.GET)
	public void passwordModifyGET(String token) throws Exception{
		logger.info("-------- AUTH : PASSWORD MODIFY : GET --------");
	}
	
	@RequestMapping(value="/password/modify", method=RequestMethod.POST)
	public String passwordModifyPOST(HttpServletRequest request, HttpServletResponse response, String token
			, @RequestParam(value="user[password]") String password) throws Exception{
		logger.info("-------- AUTH : PASSWORD MODIFY : POST --------");
		
		String path = "";
		
		String referer = request.getHeader("referer");
		if(token.equals(referer)) {
			logger.info("-------- !!ACCESS! TOKEN IS NULL --------");

			path = "redirect:/error";
		}else {
			MemberVO member = new MemberVO().setToken(token).setPw(password);
			int result = memberService.resetPassword(member);
			
			if(result == 0) { //If the token value has expired
				path = "redirect:/auth/password/tokenExpire";
			}else {
				path = "redirect:/";
			}
		}
		
		return path;
	}
	
	@RequestMapping(value="/password/tokenExpire", method=RequestMethod.GET)
	public void tokenExpireGET() throws Exception{
		logger.info("-------- ! TOKEN EXPIRE ! --------");
	}
}
