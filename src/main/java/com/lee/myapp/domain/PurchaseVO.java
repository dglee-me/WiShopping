package com.lee.myapp.domain;

import java.sql.Date;

public class PurchaseVO {
	private int num;
	private String orderno;
	private int pno;
	private int ono;
	private Date orderdate;
	private String brand;
	private String pname;
	private String productthumurl;
	private String optioncolor;
	private String optionsize;
	private int inventory;
	private int price;
	private int shippingfee;
	private int deliverystatus;

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
	public int getOno() {
		return ono;
	}
	public PurchaseVO setOno(int ono) {
		this.ono = ono;
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
	public String getProductthumurl() {
		return productthumurl;
	}
	public PurchaseVO setProductthumurl(String productthumurl) {
		this.productthumurl = productthumurl;
		return this;
	}
	public String getOptioncolor() {
		return optioncolor;
	}
	public PurchaseVO setOptioncolor(String optioncolor) {
		this.optioncolor = optioncolor;
		return this;
	}
	public String getOptionsize() {
		return optionsize;
	}
	public PurchaseVO setOptionsize(String optionsize) {
		this.optionsize = optionsize;
		return this;
	}
	public int getInventory() {
		return inventory;
	}
	public PurchaseVO setInventory(int inventory) {
		this.inventory = inventory;
		return this;
	}
	public int getPrice() {
		return price;
	}
	public PurchaseVO setPrice(int price) {
		this.price = price;
		return this;
	}
	public int getShippingfee() {
		return shippingfee;
	}
	public PurchaseVO setShippingfee(int shippingfee) {
		this.shippingfee = shippingfee;
		return this;
	}
	public int getDeliverystatus() {
		return deliverystatus;
	}
	public PurchaseVO setDeliverystatus(int deliverystatus) {
		this.deliverystatus = deliverystatus;
		return this;
	}

	public String toString() {
		return "PurchaseVO = [num= "+num+", orderno= "+orderno+", pno= "+pno+", ono = "+ono+", orderdate= "+orderdate+", brand= "+brand+", pname= "+pname+", productthumurl= "
				+productthumurl+", optioncolor= "+optioncolor+", optionsize= "+optionsize+", inventory= "+inventory+", price= "+price+", shippingfee= "+shippingfee
				+", deliverystatus= "+deliverystatus+"] ";
	}
}
