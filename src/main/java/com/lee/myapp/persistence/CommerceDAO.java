package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.ProductVO;

public interface CommerceDAO {
	public List<ProductVO> bestList(String category) throws Exception;
}
