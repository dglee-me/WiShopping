package com.lee.myapp.domain;

public class ProductVO {
	/*
		CREATE TABLE PRODUCT(
			PNO INT NOT NULL,
			CATEGORY1 VARCHAR2(50) NOT NULL,
			CATEGORY2 VARCHAR2(50) NOT NULL,
			PNAME VARCHAR2(100) NOT NULL,
			BRAND VARCHAR2(50) NOT NULL,
			PRICE INT NOT NULL,
			PRODUCT_THUMURL VARCHAR2(500) NOT NULL,
			PRODUCT_URL VARCHAR2(500) NOT NULL,
			SHIPPING_FEE INT NOT NULL,
			SHIPPING_DAY INT NOT NULL,
			PRIMARY KEY(PNO)			
		)
		
		CREATE TABLE TBL_SALES_VOLUME(
		    VNO INT NOT NULL,
		    PNO INT NOT NULL,
		    SALES INT DEFAULT 0,
		    PRIMARY KEY(VNO)
		);
		
		ALTER TABLE TBL_SALES_VOLUME ADD CONSTRAINT TBL_SALES_VOLUME_PNO FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO);
		
		CREATE SEQUENCE TBL_SALES_VOLUME_SEQ START WITH 1;
	 */
	private int pno;
	private String category1; //대분류
	private String category2; //중분류
	private String pname; //제품명
	private String brand; //제조사
	private int price; //가격
	private String producturl; //product detail description url
	private String productthumurl; //product thumnail image url
	private int shippingfee;
	private int shippingday;
	
	public int getPno() {
		return pno;
	}
	public ProductVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public String getCategory1() {
		return category1;
	}
	public ProductVO setCategory1(String category1) {
		this.category1 = category1;
		return this;
	}
	public String getCategory2() {
		return category2;
	}
	public ProductVO setCategory2(String category2) {
		this.category2 = category2;
		return this;
	}
	public String getPname() {
		return pname;
	}
	public ProductVO setPname(String pname) {
		this.pname = pname;
		return this;
	}
	public String getBrand() {
		return brand;
	}
	public ProductVO setBrand(String brand) {
		this.brand = brand;
		return this;
	}
	public int getPrice() {
		return price;
	}
	public ProductVO setPrice(int price) {
		this.price = price;
		return this;
	}
	public String getProducturl() {
		return producturl;
	}
	public ProductVO setProducturl(String producturl) {
		this.producturl = producturl;
		return this;
	}
	public String getProductthumurl() {
		return productthumurl;
	}
	public ProductVO setProductthumurl(String productthumurl) {
		this.productthumurl = productthumurl;
		return this;
	}
	public int getShippingfee() {
		return shippingfee;
	}
	public ProductVO setShipping_fee(int shippingfee) {
		this.shippingfee = shippingfee;
		return this;
	}
	public int getShippingday() {
		return shippingday;
	}
	public ProductVO setShippingday(int shippingday) {
		this.shippingday = shippingday;
		return this;
	}
	
	public String toString() {
		return "ProductVO = [pno= "+pno+", category1= "+category1+", category2= "+category2+", pname= "+pname+", brand= "+brand+", price= "+price+", producturl= "
				+producturl+", productthumurl= "+productthumurl+", shippingfee= "+shippingfee+", shippingday= "+shippingday
				+"]";
	}
}