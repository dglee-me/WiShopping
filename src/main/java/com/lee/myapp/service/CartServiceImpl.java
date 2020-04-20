package com.lee.myapp.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService{
	
	@Inject
	CartDAO cartDAO;
	
	@Override
	public void addCart(int mno, String[] ono, String number) throws Exception {
		// TODO Auto-generated method stub
		
		//선택한 상품의 수량을 ;로 나누어 배열로 만들어줍니다.
		String[] inventory = number.split(";");
		
		for(int i=0;i<ono.length;i++) {
			HashMap<String,Object> map = new HashMap<String,Object>();

			map.put("mno", mno);
			map.put("ono", Integer.parseInt(ono[i]));
			map.put("inventory", Integer.parseInt(inventory[i]));

			//If there is already a product and option in the cart
			String cartno = existCart(map);

			if(cartno == null) {
				cartDAO.addCart(map);
			}else {
				map.put("cartno", cartno);
				upInventory(map);
			}
		}
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
	public void cartRemove(int mno, List<String> pno) throws Exception {
		// TODO Auto-generated method stub
		CartVO cart = new CartVO().setMno(mno);
		
		for(int i=0;i<pno.size();i++) {
			cartDAO.cartRemove(cart.setPno(Integer.parseInt(pno.get(i))));
		}
		
		//return cartDAO.cartRemove(cart);
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

	//Header category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.categoryList();
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return cartDAO.mainBannerList(area);
	}
}