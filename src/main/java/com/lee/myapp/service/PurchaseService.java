package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.domain.PurchaseVO;

public interface PurchaseService {
	public List<PurchaseVO> purchaseStatusList(Map<String, Object> map) throws Exception;
	public List<PurchaseVO> purchaseList(Map<String, Object> map) throws Exception;
	public List<OrderVO> ordernoList(Map<String, Object> map) throws Exception;
	public OrderVO viewOrderNo(String orderno) throws Exception;
	public List<PurchaseVO> viewOrder(String orderno) throws Exception;

	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}