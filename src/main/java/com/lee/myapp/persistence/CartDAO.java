package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;

public interface CartDAO {
	public void addCart(CartVO cart) throws Exception;
	public List<CartListVO> cartList(int mno) throws Exception;
	public int cartRemove(CartListVO cart) throws Exception;
}