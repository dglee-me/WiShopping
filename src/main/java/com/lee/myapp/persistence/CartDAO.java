package com.lee.myapp.persistence;

import com.lee.myapp.domain.CartVO;

public interface CartDAO {
	public void addCart(CartVO cart) throws Exception;
}