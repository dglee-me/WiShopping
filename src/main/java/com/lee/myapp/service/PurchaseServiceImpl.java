package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.domain.PurchaseVO;
import com.lee.myapp.persistence.PurchaseDAO;

@Service
public class PurchaseServiceImpl implements PurchaseService{
	@Inject
	PurchaseDAO purchaseDAO;
	
	@Override
	public List<PurchaseVO> purchaseList(int mno) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDAO.purchaseList(mno);
	}

	@Override
	public List<OrderVO> ordernoList(int mno) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDAO.ordernoList(mno);
	}

	@Override
	public OrderVO viewOrderNo(String orderno) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDAO.viewOrderNo(orderno);
	}
	
	@Override
	public List<PurchaseVO> viewOrder(String orderno) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDAO.viewOrder(orderno);
	}
}