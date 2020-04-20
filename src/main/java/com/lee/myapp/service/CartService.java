package com.lee.myapp.service;

import java.util.HashMap;
import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;
import com.lee.myapp.domain.CategoryVO;

public interface CartService {
	public void addCart(int mno, String[] ono, String number) throws Exception;
	public List<CartListVO> cartList(int mno) throws Exception;
	public List<CartVO> cartOption(int mno) throws Exception;
	public int cartUpdate(CartVO cart) throws Exception;
	public void cartRemove(int mno, List<String> pno) throws Exception;
	public int cartOptionRemove(CartVO cart) throws Exception;
	public String existCart(HashMap<String,Object> map) throws Exception;
	public int upInventory(HashMap<String,Object> map) throws Exception;

	//Category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}