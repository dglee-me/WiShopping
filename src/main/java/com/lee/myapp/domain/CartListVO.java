package com.lee.myapp.domain;

public class CartListVO {
	private int num; //list number. index
	private int cartno;
	private int mno;
	private int pno;
	private String brand;
	private String pname;
	private String productthumurl;
	private int price;
	private int shippingfee;
	
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
	public String getProductthumurl() {
		return productthumurl;
	}
	public CartListVO setProductthumurl(String productthumurl) {
		this.productthumurl = productthumurl;
		return this;
	}
	public int getPrice() {
		return price;
	}
	public CartListVO setPrice(int price) {
		this.price = price;
		return this;
	}
	public int getShippingfee() {
		return shippingfee;
	}
	public CartListVO setShippingfee(int shippingfee) {
		this.shippingfee = shippingfee;
		return this;
	}
	
	public String toString() {
		return "CartListVO = [num= "+num+", cartno= "+cartno+", mno= "+mno+", pno= "+pno+", brand= "+brand+", pname= "
				+pname+", productthumrul= "+productthumurl+", price= "+price+", shippingfee= "+shippingfee+" ]";
	}
}
