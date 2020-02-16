package com.lee.myapp.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;

@Repository
public class BrandsDAOImpl implements BrandsDAO{
	private static final String namespace = "brandsMapper";

	@Inject
	SqlSession sqlSession;

	@Override
	public List<CategoryVO> mainCategoryList(String brand) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainCategoryList", brand);
	}

	@Override
	public List<CategoryVO> subCategoryList(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".subCategoryList", map);
	}

	@Override
	public CategoryVO selected_sub_category(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".selected_sub_category", map);
	}

	@Override
	public List<ProductVO> brandProductList(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".brandProductList", map);
	}

	@Override
	public int brandProductListCount(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".brandProductListCount", map);
	}

	@Override
	public String brandInfo(String brand) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".brandInfo", brand);
	}

	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".categoryList");
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList", area);
	}
}
