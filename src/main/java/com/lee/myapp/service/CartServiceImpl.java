package com.lee.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.CartVO;
import com.lee.myapp.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService{
	@Inject
	CartDAO cartDAO;
	
	@Override
	public void addCart(CartVO cart) throws Exception {
		// TODO Auto-generated method stub
		cartDAO.addCart(cart);
	}

}
