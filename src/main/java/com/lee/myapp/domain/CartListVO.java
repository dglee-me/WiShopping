package com.lee.myapp.domain;

public class CartListVO {
	private int num; //list number. index
	private int cartno;
	private int mno;
	private int pno;
	private String cartsize;
	private int cartstock;
	private String brand;
	private String pname;
	private int price;
	private int shipping;
	
	public int getNum() {
		return num;
	}
	public CartListVO setNum(int num) {
		this.num = num;
		return this;
	}
	public int getCartno() {
		return cartno;
	}
	public CartListVO setCartno(int cartno) {
		this.cartno = cartno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public CartListVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public CartListVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public String getCartsize() {
		return cartsize;
	}
	public CartListVO setCartsize(String cartsize) {
		this.cartsize = cartsize;
		return this;
	}
	public int getCartstock() {
		return cartstock;
	}
	public CartListVO setCartstock(int cartstock) {
		this.cartstock = cartstock;
		return this;
	}
	public String getBrand() {
		return brand;
	}
	public CartListVO setBrand(String brand) {
		this.brand = brand;
		return this;
	}
	public String getPname() {
		return pname;
	}
	public CartListVO setPname(String pname) {
		this.pname = pname;
		return this;
	}
	public int getPrice() {
		return price;
	}
	public CartListVO setPrice(int price) {
		this.price = price;
		return this;
	}
	public int getShipping() {
		return shipping;
	}
	public CartListVO setShipping(int shipping) {
		this.shipping = shipping;
		return this;
	}
	
	public String toString() {
		return "CartListVO = [num= "+num+", cartno= "+cartno+", mno= "+mno+", pno= "+pno+", cartsize= "+cartsize+", cartstock= "+cartstock+", brand= "+brand+", pname= "
				+pname+", price= "+price+", shipping= "+shipping+" ]";
	}
}
