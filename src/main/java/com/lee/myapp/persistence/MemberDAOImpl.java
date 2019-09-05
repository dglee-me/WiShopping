package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	private static final String namespace = "memberMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public int emailCheck(String email) throws Exception{
		return sqlSession.selectOne(namespace+".emailCheck",email);
	}
	
	@Override
	public int authConfirm(MemberVO member) throws Exception{
		return sqlSession.update(namespace+".authConfirm",member);
	}
	
	@Override
	public int create(MemberVO member) throws Exception{
		return sqlSession.insert(namespace+".create",member);
	}
	
	@Override
	public List<MemberVO> list() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".list");
	}

	@Override
	public int update(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".update",member);
	}

	@Override
	public int delete(int mno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".delete",mno);
	}

	@Override
	public MemberVO read(int mno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".read",mno);
	}
	
	@Override
	public MemberVO loginInfo(MemberVO member) throws Exception{
		return sqlSession.selectOne(namespace+".loginInfo",member);
	}
}
