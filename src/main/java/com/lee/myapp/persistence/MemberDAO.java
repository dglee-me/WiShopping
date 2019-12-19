package com.lee.myapp.persistence;

import java.sql.Date;
import java.util.List;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.SellerVO;

public interface MemberDAO {
	//이메일 Ajax 통해 유효성 검사
	public int emailCheck(String email) throws Exception;
	
	//회원가입 Confirm
	public int authConfirm(MemberVO member) throws Exception;

    // 자동로그인 체크한 경우, Member 테이블에 세션과 유효시간을 저장하기 위한 메서드
	public void keepLogin(String email, String sessionId, Date next) throws Exception;
	
	// 이전에 로그인한 적이 있는지, 유효시간이 넘지 않은 세션을 가지고 있는지 체크
	public MemberVO checkUserWithSessionKey(String value);
	
	public int create(MemberVO member) throws Exception;
	public List<MemberVO> list() throws Exception;
	public int update(MemberVO member) throws Exception;
	public int delete(int mno) throws Exception;
	public MemberVO read(int mno) throws Exception;
	public MemberVO loginInfo(MemberVO member) throws Exception;
	
	public int sellerRegist(SellerVO seller) throws Exception;
	public int sellerUpdate(String email) throws Exception;
}