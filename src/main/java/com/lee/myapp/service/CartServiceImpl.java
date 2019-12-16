package com.lee.myapp.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;
import com.lee.myapp.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService{
	@Inject
	CartDAO cartDAO;
	
	@Override
	public void addCart(HashMap<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		cartDAO.addCart(map);
	}

	@Override
	public List<CartListVO> cartList(int mno) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.cartList(mno);
	}

	@Override
	public List<CartVO> cartOption(int mno) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.cartOption(mno);
	}
	
	@Override
	public int cartUpdate(CartVO cart) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.cartUpdate(cart);
	}

	@Override
	public int cartRemove(CartVO cart) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.cartRemove(cart);
	}

	@Override
	public int cartOptionRemove(CartVO cart) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.cartOptionRemove(cart);
	}

	@Override
	public String existCart(HashMap<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.existCart(map);
	}

	@Override
	public int upInventory(HashMap<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.upInventory(map);
	}
}