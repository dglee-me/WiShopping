package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.ProductVO;

public interface SearchService {
	public List<ProductVO> searchProductList(String query) throws Exception;
	public int countResult(String query) throws Exception;
	public String isBrand(String query) throws Exception;
}
