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
			RETURN_FEE INT,
			RETURN_PLACE VARCHAR2(100),
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
	private int mno; // Use only for product regist (brand) and product modify (brand)
	private String category1; //��з�
	private String category2; //�ߺз�
	private String pname; //��ǰ��
	private String brand; //������
	private int price; //����
	private String producturl; //product detail description url
	private String productthumurl; //product thumnail image url
	private int shippingfee;
	private int shippingday;
	private int returnfee;
	private String returnplace;
	
	private int category1url;
	private int category2url;
	private int isseller;
	private int isbrand;
	
	public int getPno() {
		return pno;
	}
	public ProductVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public ProductVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public void setShippingfee(int shippingfee) {
		this.shippingfee = shippingfee;
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
	public int getReturnfee() {
		return returnfee;
	}
	public ProductVO setReturnfee(int returnfee) {
		this.returnfee = returnfee;
		return this;
	}
	public String getReturnplace() {
		return returnplace;
	}
	public ProductVO setReturnplace(String returnplace) {
		this.returnplace = returnplace;
		return this;
	}
	
	public int getCategory1url() {
		return category1url;
	}
	public ProductVO setCategory1url(int category1url) {
		this.category1url = category1url;
		return this;
	}
	public int getCategory2url() {
		return category2url;
	}
	public ProductVO setCategory2url(int category2url) {
		this.category2url = category2url;
		return this;
	}
	public int getIsseller() {
		return isseller;
	}
	public ProductVO setIsseller(int isseller) {
		this.isseller = isseller;
		return this;
	}
	public int getIsbrand() {
		return isbrand;
	}
	public ProductVO setIsbrand(int isbrand) {
		this.isbrand = isbrand;
		return this;
	}
	
	public String toString() {
		return "ProductVO = [pno= "+pno+", mno = "+mno+", category1= "+category1+", category2= "+category2+", pname= "+pname+", brand= "+brand+", price= "+price+", producturl= "
				+producturl+", productthumurl= "+productthumurl+", shippingfee= "+shippingfee+", shippingday= "+shippingday+", return_fee = "+returnfee+
				", return_place = "+returnplace+", category1_url = "+category1url+", category2_url = "+category2url+", isseller = "+isseller+", is_brand = "+isbrand+"]";
	}
}