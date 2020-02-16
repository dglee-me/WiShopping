package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;

public interface CommerceService {
	public List<ProductVO> bestList(String category) throws Exception;

	//Category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}
