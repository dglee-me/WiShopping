package com.lee.myapp.domain;

public class ProductVO {
	private int pno;
	private String category1; //대분류
	private String category2; //중분류
	private String pname; //제품명
	private String brand; //제조사
	private int inventory; //수량
	private int price; //가격
	private int shipping; //배송비
	private String product_desc; //제품 설명
	private String product_url; //product detail description url
	private String product_thumurl; //product thumnail image url
	
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
	public int getInventory() {
		return inventory;
	}
	public ProductVO setInventory(int inventory) {
		this.inventory = inventory;
		return this;
	}
	public int getPrice() {
		return price;
	}
	public ProductVO setPrice(int price) {
		this.price = price;
		return this;
	}
	
	public int getShipping() {
		return shipping;
	}
	
	public ProductVO setShipping(int shipping) {
		this.shipping = shipping;
		return this;
	}
	
	public String getProduct_desc() {
		return product_desc;
	}
	public ProductVO setProduct_desc(String product_desc) {
		this.product_desc = product_desc;
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
	
	public String toString() {
		return "ProductVO [pno= "+pno+", category1= "+category1+", category2= "+category2+", pname= "+pname+", brand= "+brand+
				", inventory= "+inventory+", price= "+price+", product_desc= "+product_desc+", product_url= "+product_url+", product_thumurl= "+product_thumurl;
	}
}
