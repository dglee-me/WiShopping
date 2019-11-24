package com.lee.myapp.domain;

import java.sql.Date;

public class PurchaseVO {
	private int num;
	private String orderno;
	private int pno;
	private Date orderdate;
	private String brand;
	private String pname;
	private String product_thumurl;
	private String product_option;
	private int product_stock;
	private int price;
	private int state;
	
	public int getNum() {
		return num;
	}
	public PurchaseVO setNum(int num) {
		this.num = num;
		return this;
	}
	public String getOrderno() {
		return orderno;
	}
	public PurchaseVO setOrderno(String orderno) {
		this.orderno = orderno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public PurchaseVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public PurchaseVO setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
		return this;
	}
	public String getBrand() {
		return brand;
	}
	public PurchaseVO setBrand(String brand) {
		this.brand = brand;
		return this;
	}
	public String getPname() {
		return pname;
	}
	public PurchaseVO setPname(String pname) {
		this.pname = pname;
		return this;
	}
	public String getProduct_thumurl() {
		return product_thumurl;
	}
	public PurchaseVO setProduct_thumurl(String product_thumurl) {
		this.product_thumurl = product_thumurl;
		return this;
	}
	public String getProduct_option() {
		return product_option;
	}
	public PurchaseVO setProduct_option(String product_option) {
		this.product_option = product_option;
		return this;
	}
	public int getProduct_stock() {
		return product_stock;
	}
	public PurchaseVO setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
		return this;
	}
	public int getPrice() {
		return price;
	}
	public PurchaseVO setPrice(int price) {
		this.price = price;
		return this;
	}
	public int getState() {
		return state;
	}
	public PurchaseVO setState(int state) {
		this.state = state;
		return this;
	}
	public String toString() {
		return "PurchaseVO = [num= "+num+", orderno= "+orderno+", pno= "+pno+", orderdate= "+orderdate+", brand= "+brand+", pname= "+pname+", product_option= "+product_option
				+", product_stock= "+product_stock+", price= "+price+", state= "+state+" ]";
	}
}
