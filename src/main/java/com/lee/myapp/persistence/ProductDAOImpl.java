package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO{
	private static final String namespace = "productMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public int register(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".register",product);
	}

	@Override
	public int register_option(ProductOptionVO option) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".register_option",option);
	}
	
	@Override
	public List<ProductVO> list(String category) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".list",category);
	}

	@Override
	public ProductVO view(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".view",pno);
	}

	@Override
	public List<ProductOptionVO> view_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".view_option",pno);
	}

	@Override
	public int checkInventory(int ono) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".checkInventory",ono);
	}

}
