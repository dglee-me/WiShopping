package com.lee.myapp.service;

import java.util.HashMap;
import java.util.List;

import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;

public interface CartService {
	public void addCart(HashMap<String,Object> map) throws Exception;
	public List<CartListVO> cartList(int mno) throws Exception;
	public List<CartVO> cartOption(int mno) throws Exception;
	public int cartUpdate(CartVO cart) throws Exception;
	public int cartRemove(CartVO cart) throws Exception;
	public int cartOptionRemove(CartVO cart) throws Exception;
	public String existCart(HashMap<String,Object> map) throws Exception;
	public int upInventory(HashMap<String,Object> map) throws Exception;
}