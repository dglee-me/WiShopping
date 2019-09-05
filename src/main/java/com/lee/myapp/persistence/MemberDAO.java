package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.MemberVO;

public interface MemberDAO {
	public int emailCheck(String email) throws Exception;
	public int authConfirm(MemberVO member) throws Exception;
	
	public int create(MemberVO member) throws Exception;
	public List<MemberVO> list() throws Exception;
	public int update(MemberVO member) throws Exception;
	public int delete(int mno) throws Exception;
	public MemberVO read(int mno) throws Exception;
	public MemberVO loginInfo(MemberVO member) throws Exception;
}