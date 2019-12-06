package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;

public interface ProductService {
	public int register(ProductVO product) throws Exception;
	public int register_option(ProductOptionVO option) throws Exception;
	public List<ProductVO> list(String category) throws Exception;
	public ProductVO view(int pno) throws Exception;
}
