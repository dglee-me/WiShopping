package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.ProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO{
	private static final String namespace = "productMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public int register(ProductVO pd) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".register",pd);
	}

	@Override
	public List<ProductVO> list(String category) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".list",category);
	}

}
