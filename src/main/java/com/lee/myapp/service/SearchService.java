package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;

public interface SearchService {
	public List<ProductVO> searchProductList(Map<String, Object> map) throws Exception;
	public int countResult(Map<String, Object> map) throws Exception;
	public String isBrand(String query) throws Exception;

	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}
