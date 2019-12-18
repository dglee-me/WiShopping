package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.ProductVO;

public interface SearchDAO {
	public List<ProductVO> searchProductList(String query) throws Exception;
	public int countResult(String query) throws Exception;
	public String isBrand(String query) throws Exception;
}
