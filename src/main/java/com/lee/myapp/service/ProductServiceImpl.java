package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.ProductDAO;

@Repository
public class ProductServiceImpl implements ProductService{
	@Inject
	ProductDAO productDAO;
	
	@Override
	public int register(ProductVO pd) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.register(pd);
	}

	@Override
	public List<ProductVO> list(String category) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.list(category);
	}

	@Override
	public ProductVO view(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.view(pno);
	}

}
