package com.lee.myapp.domain;

public class OrderListVO {
	// Product information shown in the pre_order view
	private int cartno;
	private int ono;
	private int pno;
	private String brand;
	private String pname;
	private int price;
	private String productthumurl;
	private String optioncolor;
	private String optionsize;
	private int inventory;
	private int shippingfee;
	
	public int getCartno() {
		return cartno;
	}
	public OrderListVO setCartno(int cartno) {
		this.cartno = cartno;
		return this;
	}
	public int getOno() {
		return ono;
	}
	public OrderListVO setOno(int ono) {
		this.ono = ono;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public OrderListVO setPno(int pno) {
		this.pno = pno;
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
	public String getProductthumurl() {
		return productthumurl;
	}
	public OrderListVO setProductthumurl(String productthumurl) {
		this.productthumurl = productthumurl;
		return this;
	}
	public String getOptioncolor() {
		return optioncolor;
	}
	public OrderListVO setOptioncolor(String optioncolor) {
		this.optioncolor = optioncolor;
		return this;
	}
	public String getOptionsize() {
		return optionsize;
	}
	public OrderListVO setOptionsize(String optionsize) {
		this.optionsize = optionsize;
		return this;
	}
	public int getInventory() {
		return inventory;
	}
	public OrderListVO setInventory(int inventory) {
		this.inventory = inventory;
		return this;
	}
	public int getShippingfee() {
		return shippingfee;
	}
	public OrderListVO setShippingfee(int shippingfee) {
		this.shippingfee = shippingfee;
		return this;
	}

	public String toString() {
		return "OrderListVO = [cartno= "+cartno+", ono= "+ono+", pno= "+pno+", brand= "+brand+", pname= "+pname+", price= "+price+", productthumurl= "+productthumurl+", optioncolor= "
				+optioncolor+", optionsize= "+optionsize+", inventory= "+inventory+", shippingfee= "+shippingfee+"]";
	}
}
