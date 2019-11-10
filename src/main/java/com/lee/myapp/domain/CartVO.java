package com.lee.myapp.domain;

public class CartVO {
	private int cartno; //cart number
	private int mno; //users number
	private int pno; //product number
	private int cartstock; //product quantity in the cart
	private String cartsize; //product size in the cart
	public int getCartno() {
		return cartno;
	}
	public CartVO setCartno(int cartno) {
		this.cartno = cartno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public CartVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public CartVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public int getCartstock() {
		return cartstock;
	}
	public CartVO setCartstock(int cartstock) {
		this.cartstock = cartstock;
		return this;
	}
	public String getCartsize() {
		return cartsize;
	}
	public CartVO setCartsize(String cartsize) {
		this.cartsize = cartsize;
		return this;
	}
	
	public String toString() {
		return "CartVO = [cartno= "+cartno+", mno= "+mno+", pno= "+pno+", cartStock= "+cartstock+", cartSize= "+cartsize+" ]";
	}
	
}
