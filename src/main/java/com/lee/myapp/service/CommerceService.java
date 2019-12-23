package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.ProductVO;

public interface CommerceService {
	public List<ProductVO> bestList(String category) throws Exception;
}
