package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.ProductVO;

public interface BrandsService {
	//Brands Service
	public List<String> categoryList(String brand) throws Exception;
	public List<ProductVO> brandProductList(String brand) throws Exception;

	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}