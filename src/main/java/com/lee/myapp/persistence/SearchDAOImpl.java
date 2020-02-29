package com.lee.myapp.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;

@Repository
public class SearchDAOImpl implements SearchDAO{
	private static final String namespace = "searchMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ProductVO> searchProductList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".searchProductList", map);
	}

	@Override
	public int countResult(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countResult", map);
	}

	@Override
	public String isBrand(String query) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".isBrand",query);
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
