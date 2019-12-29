package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.ProductVO;

@Repository
public class HomeDAOImpl implements HomeDAO{
	private static final String namespace = "homeMapper";
	
	@Inject
	SqlSession sqlSession;

	@Override
	public List<ProductVO> selectAllBest() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".selectAllBest");
	}

	@Override
	public List<ProductVO> selectBest(String data) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".selectBest",data);
	}

	@Override
	public List<BannerVO> mainBannerList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList");
	}
}