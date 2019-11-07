package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.ProductVO;

public interface ProductService {
	public int register(ProductVO pd) throws Exception;
	public List<ProductVO> list(String category) throws Exception;
	public ProductVO view(int pno) throws Exception;
}
