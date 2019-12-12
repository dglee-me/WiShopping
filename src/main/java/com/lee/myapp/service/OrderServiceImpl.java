package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Inject
	OrderDAO orderDAO;

	@Override
	public List<OrderListVO> orderList(String[] pno) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.orderList(pno);
	}

	@Override
	public void orderInfo(OrderVO order) throws Exception {
		// TODO Auto-generated method stub
		orderDAO.orderInfo(order);
	}

	@Override
	public int orderInfo_Detail(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.orderInfo_Detail(map);
	}

	@Override
	public void cartDelete(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		orderDAO.cartDelete(map);
	}	
}