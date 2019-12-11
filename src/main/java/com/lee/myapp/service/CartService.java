package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;

public interface CartService {
	public void addCart(CartVO cart) throws Exception;
	public List<CartListVO> cartList(int mno) throws Exception;
	public List<CartVO> cartOption(int mno) throws Exception;
	public int cartUpdate(CartVO cart) throws Exception;
	public int cartRemove(CartVO cart) throws Exception;
	public int cartOptionRemove(CartVO cart) throws Exception;
}