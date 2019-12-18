package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.ProductVO;

@Repository
public class SearchDAOImpl implements SearchDAO{
	private static final String namespace = "searchMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ProductVO> searchProductList(String query) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".searchProductList",query);
	}

	@Override
	public int countResult(String query) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countResult",query);
	}

	@Override
	public String isBrand(String query) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".isBrand",query);
	}
	
}
