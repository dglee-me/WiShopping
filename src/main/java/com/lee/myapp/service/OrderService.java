package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;

public interface OrderService {
	public List<OrderListVO> orderList(String[] pno) throws Exception; 
	public void orderInfo(OrderVO order) throws Exception;
	public void orderInfo_Detail(Map<String,Object> map) throws Exception;
	public void cartDelete(Map<String,Object> map) throws Exception;
}