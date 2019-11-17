package com.lee.myapp.domain;

public class OrderListVO {
	// Product information shown in the pre_order view
	private int pno;
	private int cartno;
	private String brand;
	private String pname;
	private int price;
	private String product_thumurl;
	private String cartsize;
	private int cartstock;
	private int shipping;

	public int getPno() {
		return pno;
	}
	public OrderListVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public int getCartno() {
		return cartno;
	}
	public OrderListVO setCartno(int cartno) {
		this.cartno = cartno;
		return this;
	}
	public String getBrand() {
		return brand;
	}
	public OrderListVO setBrand(String brand) {
		this.brand = brand;
		return this;
	}
	public String getPname() {
		return pname;
	}
	public OrderListVO setPname(String pname) {
		this.pname = pname;
		return this;
	}
	public int getPrice() {
		return price;
	}
	public OrderListVO setPrice(int price) {
		this.price = price;
		return this;
	}
	public String getProduct_thumurl() {
		return product_thumurl;
	}
	public OrderListVO setProduct_thumurl(String product_thumurl) {
		this.product_thumurl = product_thumurl;
		return this;
	}
	public String getCartsize() {
		return cartsize;
	}
	public OrderListVO setCartsize(String cartsize) {
		this.cartsize = cartsize;
		return this;
	}
	public int getCartstock() {
		return cartstock;
	}
	public OrderListVO setCartstock(int cartstock) {
		this.cartstock = cartstock;
		return this;
	}
	public int getShipping() {
		return shipping;
	}
	public OrderListVO setShipping(int shipping) {
		this.shipping = shipping;
		return this;
	}
	
	public String toString() {
		return "OrderListVO = [pno= "+pno+", cartno= "+cartno+", brand= "+brand+", pname= "+pname+", price= "+price+", product_thumurl= "+product_thumurl+", cartsize= "+cartsize+", cartstock= "
				+cartstock+", shipping= "+shipping+"]";
	}
}
