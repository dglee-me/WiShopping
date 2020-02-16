package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;

public interface OrderService {
	public List<OrderListVO> cartToOrderList(Map<String,Object> map) throws Exception; 
	public OrderListVO productToOrderList(Map<String,Object> map) throws Exception; 
	public void orderInfo(OrderVO order) throws Exception;
	public int cart_orderInfo_detail(Map<String,Object> map) throws Exception;
	public int product_orderInfo_detail(Map<String,Object> map) throws Exception;
	public void cartDelete(Map<String,Object> map) throws Exception;
	public void updateInventory(Map<String,Object> map) throws Exception;
	public int checkInventory(String ono) throws Exception;
	public int cartCheckInventory(String cartno) throws Exception;
	
	public int cartUpdateSalesVolume(String cartno) throws Exception;
	public int productToUpdateSalesVolume(Map<String,Object> map) throws Exception;

	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}