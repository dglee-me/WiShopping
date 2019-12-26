package com.lee.myapp.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;

@Repository
public class AdminDAOImpl implements AdminDAO{
	private static final String namespace = "adminMapper";
	
	@Inject
	SqlSession sqlSession;

	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".write",board);
	}

	@Override
	public int bannerRegist(BannerVO banner) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".bannerRegist",banner);
	}
}
