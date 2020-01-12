package com.lee.myapp.service;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		// 임의의 인증 키 생성 및 입력
		String authKey = new TempKey().getKey(50, false);
		member.setAuth(authKey);

		// Mail Send 부분
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("위쇼핑 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("<p>안녕하세요, " + member.getName() + " 님. 이메일 인증을 하시려면 하단의 링크를 클릭하여주세요.</p>")
				.append("<a href='http://15.165.6.133:8080/WiShopping/auth/joinConfirm?email=").append(member.getEmail())
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
	public MemberVO loginInfo(MemberVO member) throws Exception {
		return memberDao.loginInfo(member);
	}

	@Override
	public MemberVO newPassword(String email) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.newPassword(email);
	}

	@Override
	public int newPasswordTokenSet(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.newPasswordTokenSet(member);
	}

	@Override
	public int resetPassword(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.resetPassword(member);
	}

	@Override
	public int resetToken() throws Exception {
		// TODO Auto-generated method stub
		return memberDao.resetToken();
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
}