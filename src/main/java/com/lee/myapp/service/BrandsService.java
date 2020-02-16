package com.lee.myapp.service;

import java.util.HashMap;
import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;

public interface BrandsService {
	//Brands Service
	public List<CategoryVO> mainCategoryList(String brand) throws Exception;
	public List<CategoryVO> subCategoryList(HashMap<String, Object> map) throws Exception;
	public CategoryVO selected_sub_category(HashMap<String, Object> map) throws Exception;
	
	public List<ProductVO> brandProductList(HashMap<String, Object> map) throws Exception;
	public int brandProductListCount(HashMap<String, Object> map) throws Exception;
	
	public String brandInfo(String brand) throws Exception;

	//Category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}