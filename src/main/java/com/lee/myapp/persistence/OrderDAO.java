package com.lee.myapp.persistence;

import java.util.List;
import java.util.Map;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;

public interface OrderDAO {
	public List<OrderListVO> cartToOrderList(Map<String,Object> map) throws Exception; 
	public OrderListVO productToOrderList(Map<String,Object> map) throws Exception; 
	public void orderInfo(OrderVO order) throws Exception;
	public int cart_orderInfo_detail(Map<String,Object> map) throws Exception;
	public int product_orderInfo_detail(Map<String,Object> map) throws Exception;
	public void cartDelete(Map<String,Object> map) throws Exception;
	public void updateInventory(Map<String,Object> map) throws Exception;
	public int checkInventory(String ono) throws Exception;
	public int cartCheckInventory(String cartno) throws Exception;

	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}