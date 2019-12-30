package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Inject
	OrderDAO orderDAO;

	@Override
	public List<OrderListVO> cartToOrderList(Map<String,Object> map) throws Exception{
		// TODO Auto-generated method stub
		return orderDAO.cartToOrderList(map);
	}

	@Override
	public OrderListVO productToOrderList(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.productToOrderList(map);
	}

	@Override
	public void orderInfo(OrderVO order) throws Exception {
		// TODO Auto-generated method stub
		orderDAO.orderInfo(order);
	}


	@Override
	public int cart_orderInfo_detail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.cart_orderInfo_detail(map);
	}
	
	@Override
	public int product_orderInfo_detail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.product_orderInfo_detail(map);
	}

	@Override
	public void cartDelete(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		orderDAO.cartDelete(map);
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.mainBannerList(area);
	}
}