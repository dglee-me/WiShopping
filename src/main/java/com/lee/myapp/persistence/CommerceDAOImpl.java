package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;

@Repository
public class CommerceDAOImpl implements CommerceDAO{
	private static final String namespace = "commerceMapper";

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ProductVO> bestList(String category) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".bestList",category);
	}

	//Header category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".categoryList");
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList",area);
	}
}
