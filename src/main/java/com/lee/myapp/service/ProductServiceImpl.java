package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService{
	@Inject
	ProductDAO productDAO;
	
	@Override
	public int register(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.register(product);
	}

	@Override
	public int register_option(ProductOptionVO option) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.register_option(option);
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

	@Override
	public List<ProductOptionVO> view_option(int pno) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.view_option(pno);
	}

	@Override
	public int checkInventory(int ono) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.checkInventory(ono);
	}
}