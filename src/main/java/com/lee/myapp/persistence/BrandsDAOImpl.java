package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.ProductVO;

@Repository
public class BrandsDAOImpl implements BrandsDAO{
	private static final String namespace = "brandsMapper";

	@Inject
	SqlSession sqlSession;

	@Override
	public List<String> categoryList(String brand) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".categoryList", brand);
	}

	@Override
	public List<ProductVO> brandProductList(String brand) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".brandProductList", brand);
	}
	
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList", area);
	}
}
