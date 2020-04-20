package com.lee.myapp.service;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.SellerVO;
import com.lee.myapp.persistence.MemberDAO;
import com.lee.myapp.utils.MailUtils;
import com.lee.myapp.utils.TempKey;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDao;
	
	@Inject
	BCryptPasswordEncoder passEncoder;
	
	@Inject
	private JavaMailSender mailSender;

	@Override
	public int emailCheck(String email) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.emailCheck(email);
	}

	@Override
	public int authConfirm(MemberVO member) throws Exception {
		return memberDao.authConfirm(member);
	}

	@Override
	public void keepLogin(String email, String sessionId, Date next) throws Exception {
		// TODO Auto-generated method stub
		memberDao.keepLogin(email, sessionId, next);
	}

	@Override
	public MemberVO checkUserWithSessionKey(String value) {
		// TODO Auto-generated method stub
		return memberDao.checkUserWithSessionKey(value);
	}

	@Override
	@Transactional
	public int create(MemberVO member) throws Exception {
		// TODO Auto-generated method stub

		//Password encryption
		String encodePassword = passEncoder.encode(member.getPw());
		member.setPw(encodePassword);
		
		// 임의의 인증 키 생성 및 입력
		String authKey = new TempKey().getKey(50, false);
		member.setAuth(authKey);

		// Mail Send 부분
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("위쇼핑 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("<p>안녕하세요, " + member.getName() + " 님. 이메일 인증을 하시려면 하단의 링크를 클릭하여주세요.</p>")
				.append("<a href='http://15.165.119.77:8080/WiShopping/auth/joinConfirm?email=").append(member.getEmail())
				.append("&auth=").append(authKey).append("' target='_blenk'>이메일 인증하기</a>").toString());

		sendMail.setFrom("dglee.dev@gmail.com ", "WiSHopping");
		sendMail.setTo(member.getEmail());
		sendMail.send();

		return memberDao.create(member);
	}

	@Override
	public List<MemberVO> list() throws Exception {
		// TODO Auto-generated method stub
		return memberDao.list();
	}

	@Override
	public int update(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.update(member);
	}

	@Override
	public int delete(int mno) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.delete(mno);
	}

	@Override
	public MemberVO read(int mno) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.read(mno);
	}

	@Override
	public String login(HttpServletRequest request, HttpServletResponse response, MemberVO member, RedirectAttributes rttr) throws Exception{
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		MemberVO loginMember = loginInfo(member.getEmail());

		//Remove existing value if login session already exists
		if(session.getAttribute("login") != null) {
			System.out.println("logined...");
			session.removeAttribute("login");
		}
		
		if(loginMember == null) { // 해당 User가 존재하지 않을 경우 login session을 초기화하며, msg를 view에 전달하여 에러 문구를 출력해줍니다.
			session.setAttribute("login", null);
			rttr.addFlashAttribute("msg",false);
			
			return "redirect:/auth/login";
		}else {
			//Verify that the password you entered matches the one before the password was encrypted
			boolean passwordMatch = passEncoder.matches(member.getPw(), loginMember.getPw());
			
			if(passwordMatch) { // 입력한 비밀번호와 DB 내의 암호화 된 비밀번호가 일치할 경우에만 진입한다.
				if(loginMember.getAuth().equals("Y")) { // User가 이메일 인증을 마친 상태에서만 로그인 가능. 그렇지 않다면, msg를 view에 전달하여 에러 문구를 출력하여줍니다.
					session.setAttribute("login", loginMember);
					
					if(member.isUseCookie()) { //자동로그인을 선택했을 경우, 일주일간 쿠키를 설정하여 로그인을 유지 시킵니다.
						Cookie cookie = new Cookie("loginCookie",session.getId());
						cookie.setPath("/");
						
						int amount = 60*60*24*7; 
						cookie.setMaxAge(amount);	//Set the effective time to 7 days
						
						//Cookie Enabled
						response.addCookie(cookie);
						
						Date sessionLimit = new Date(System.currentTimeMillis() + (1000*amount));
						
						keepLogin(loginMember.getEmail(), session.getId(), sessionLimit);
					}
				}else {
					session.setAttribute("login", null);
					rttr.addFlashAttribute("msg",true);
					return "redirect:/auth/login";
				}
				return "redirect:/";
			}else {
				session.setAttribute("login", null);
				rttr.addFlashAttribute("msg", false);
				
				return "redirect:/auth/login";
			}
		}
	}
	
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("login");
		
		if(obj != null) { // 로그인 Object가 존재할 경우, session을 삭제 후, 초기화한다.
			MemberVO member = (MemberVO) obj;
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) { // 자동로그인이 설정되어 있다면, 만료일자를 현재시각으로 바꾸어 자동로그인 기간을 만료시켜줍니다.
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				
				response.addCookie(loginCookie);
				Date date = new Date(System.currentTimeMillis());
				
				keepLogin(member.getEmail(), session.getId(), date);
			}
		}
	}
	
	@Override
	public MemberVO loginInfo(String email) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.loginInfo(email);
	}

	@Override
	public String newPassword(String email) throws Exception {
		// TODO Auto-generated method stub
		
		/*
		 * email에 해당하는 User를 찾아 token을 셋팅해줍니다. 
		 * 그 이후, mail을 보내 해당 링크를 클릭 시 비밀번호를 재설정해주는 페이지로 이동하게끔 유도합니다.
		 */
		MemberVO member = loginInfo(email);
		
		//Authentication Key create
		String token = new TempKey().getKey(36,false);
		member.setToken(token);
		
		//Reflect tokens in database
		newPasswordTokenSet(member);

		// Mail send method
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[위쇼핑] 비밀번호 재설정 안내");
		sendMail.setText(new StringBuffer().append("<h1>[비밀번호 재설정]</h1>")
				.append("<p>안녕하세요, " + member.getName()  + " 님. 비밀번호를 재설정 하시려면 하단의 링크를 클릭하여주세요.</p>")
				.append("<a href='http://15.165.119.77:8080/WiShopping/auth/password/modify?token="+token+"'>")
				.append("[비밀번호 재설정]")
				.append("</a>")
				.append("<br/>")
				.append("<p>*만약 본인이 재설정 신청을 한게 아니라면, 본 메일을 무시해도 좋습니다.<p>").toString());

		sendMail.setFrom("dglee.dev@gmail.com ", "WiSHopping");
		sendMail.setTo(member.getEmail());
		sendMail.send();
		
		return "redirect:/";
	}

	@Override
	public int newPasswordTokenSet(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.newPasswordTokenSet(member);
	}

	@Override
	public String resetPassword(HttpServletRequest request, String token, String password) throws Exception {
		// TODO Auto-generated method stub
		String referer = request.getHeader("referer");
		
		if(token.equals(referer)) {
			return "redirect:/error";
		}else {
			MemberVO member = new MemberVO().setToken(token).setPw(passEncoder.encode(password));
			
			System.out.println(member.toString());
			
			int result = memberDao.resetPassword(member);
			
			if(result == 0) { //If the token value has expired
				return "redirect:/auth/password/tokenExpire";
			}else {
				return "redirect:/";
			}
		}
	}

	@Override
	public int resetToken() throws Exception {
		// TODO Auto-generated method stub
		return memberDao.resetToken();
	}

	@Override
	public int modifyUserInfo(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.modifyUserInfo(member);
	}

	@Override
	public int withdrawalUser(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.withdrawalUser(member);
	}

	@Override
	public int sellerRegist(SellerVO seller) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.sellerRegist(seller);
	}

	@Override
	public int sellerUpdate(int mno) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.sellerUpdate(mno);
	}

	//Header category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return memberDao.categoryList();
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.mainBannerList(area);
	}
}