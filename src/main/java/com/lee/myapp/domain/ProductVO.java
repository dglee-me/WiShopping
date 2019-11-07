package com.lee.myapp.domain;

public class ProductVO {
	//PRODUCT TBL
	private int pno;
	private String category1; //대분류
	private String category2; //중분류
	private String pname; //제품명
	private String brand; //제조사
	private int price; //가격
	private String product_url; //product detail description url
	private String product_thumurl; //product thumnail image url
	
	//PRODUCT_OPTION TBL
	private int s; // s size inventory
	private int m; // m size inventory
	private int l; // l size inventory
	private int free; // free size inventory
	private int shipping; // shipping cost
	private int shippingday; // shipping date
	
	//PRODUCT TBL
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
	public String getProduct_url() {
		return product_url;
	}
	public ProductVO setProduct_url(String product_url) {
		this.product_url = product_url;
		return this;
	}
	public String getProduct_thumurl() {
		return product_thumurl;
	}
	public ProductVO setProduct_thumurl(String product_thumurl) {
		this.product_thumurl = product_thumurl;
		return this;
	}
	
	//PRODUCT_OPTION TBL
	public int getS() {
		return s;
	}
	public ProductVO setS(int s) {
		this.s = s;
		return this;
	}
	public int getM() {
		return m;
	}
	public ProductVO setM(int m) {
		this.m = m;
		return this;
	}
	public int getL() {
		return l;
	}
	public ProductVO setL(int l) {
		this.l = l;
		return this;
	}
	public int getFree() {
		return free;
	}
	public ProductVO setFree(int free) {
		this.free = free;
		return this;
	}
	public int getShipping() {
		return shipping;
	}
	public ProductVO setShipping(int shipping) {
		this.shipping = shipping;
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
		return "ProductVO [pno= "+pno+", category1= "+category1+", category2= "+category2+", pname= "+pname+", brand= "+brand+
				", price= "+price+", product_url= "+product_url+", product_thumurl= "+product_thumurl+", S size= "+s+", M size= "+m+", L size= "+l+"FREE size= "+free+
				", shipping= "+shipping+", shippingday= "+shippingday+" ]";
	}
}