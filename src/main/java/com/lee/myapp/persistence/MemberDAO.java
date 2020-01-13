package com.lee.myapp.persistence;

import java.sql.Date;
import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.SellerVO;

public interface MemberDAO {
	//�̸��� Ajax ���� ��ȿ�� �˻�
	public int emailCheck(String email) throws Exception;
	
	//ȸ������ Confirm
	public int authConfirm(MemberVO member) throws Exception;

    // �ڵ��α��� üũ�� ���, Member ���̺� ���ǰ� ��ȿ�ð��� �����ϱ� ���� �޼���
	public void keepLogin(String email, String sessionId, Date next) throws Exception;
	
	// ������ �α����� ���� �ִ���, ��ȿ�ð��� ���� ���� ������ ������ �ִ��� üũ
	public MemberVO checkUserWithSessionKey(String value);
	
	public int create(MemberVO member) throws Exception;
	public List<MemberVO> list() throws Exception;
	public int update(MemberVO member) throws Exception;
	public int delete(int mno) throws Exception;
	public MemberVO read(int mno) throws Exception;
	public MemberVO loginInfo(MemberVO member) throws Exception;
	
	//Reset Password
	public MemberVO newPassword(String email) throws Exception;
	public int newPasswordTokenSet(MemberVO member) throws Exception;
	public int resetPassword(MemberVO member) throws Exception;
	public int resetToken() throws Exception;
	
	//Modify user info
	public int modifyUserInfo(MemberVO member) throws Exception;
	
	//Withdrawal user
	public int withdrawalUser(MemberVO member) throws Exception;
	
	public int sellerRegist(SellerVO seller) throws Exception;
	public int sellerUpdate(int mno) throws Exception;

	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}