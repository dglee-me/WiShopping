package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.domain.PurchaseVO;

public interface PurchaseService {
	public List<PurchaseVO> purchaseList(int mno) throws Exception;
	public List<OrderVO> ordernoList(int mno) throws Exception;
}
