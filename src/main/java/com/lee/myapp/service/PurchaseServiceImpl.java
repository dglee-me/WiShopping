package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.domain.PurchaseVO;
import com.lee.myapp.persistence.PurchaseDAO;

@Service
public class PurchaseServiceImpl implements PurchaseService{
	@Inject
	PurchaseDAO purchaseDAO;
	
	@Override
	public List<PurchaseVO> purchaseList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDAO.purchaseList(map);
	}

	@Override
	public List<OrderVO> ordernoList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDAO.ordernoList(map);
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

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDAO.mainBannerList(area);
	}
}