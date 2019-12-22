package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.ProductVO;

public interface HomeService {
	public List<ProductVO> selectAllBest() throws Exception;
	public List<ProductVO> selectBest(String data) throws Exception;
}
