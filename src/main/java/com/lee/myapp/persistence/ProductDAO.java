package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.ProductVO;

public interface ProductDAO {
	public int register(ProductVO pd) throws Exception;
	public List<ProductVO> list(String category) throws Exception;
}
