package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.domain.ReviewVO;

public interface ProductService {
	public int register(ProductVO product) throws Exception;
	public int register_option(ProductOptionVO option) throws Exception;
	public List<ProductVO> list(ProductVO product) throws Exception;
	public ProductVO view(int pno) throws Exception;
	public List<ProductOptionVO> view_option(int pno) throws Exception;
	public int checkInventory(int ono) throws Exception;

	public int isSeller(int mno) throws Exception;
	
	//Review
	public int reviewRegist(ReviewVO review) throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}