package com.lee.myapp.domain;

public class SellerVO {
	/*
	    CREATE TABLE SELLER(
		    SNO INT NOT NULL,
		    COMPANY VARCHAR2(50) NOT NULL,
		    LICENSE1 VARCHAR2(10) NOT NULL,
		    LICENSE2 VARCHAR2(10) NOT NULL,
		    LICENSE3 VARCHAR2(10) NOT NULL,
		    SALES_NAME VARCHAR2(50) NOT NULL,
		    SALES_PHONE1 VARCHAR2(5) NOT NULL,
		    SALES_PHONE2 VARCHAR2(5) NOT NULL,
		    SALES_PHONE3 VARCHAR2(5) NOT NULL,
		    SALES_EMAIL VARCHAR2(50) NOT NULL,
		    BRAND VARCHAR2(50) NOT NULL,
		    CATEGORY VARCHAR2(30) NOT NULL,
		    ABOUT_PRODUCT CLOB NOT NULL,
		    PRIMARY KEY(SNO)
		);
	*/
	private int sno;
	private String company;
	private String license1;
	private String license2;
	private String license3;
	private String salesname;
	private String salesphone1;
	private String salesphone2;
	private String salesphone3;
	private String salesemail;
	private String brand;
	private String category;
	private String aboutproduct;
	
	public int getSno() {
		return sno;
	}
	public SellerVO setSno(int sno) {
		this.sno = sno;
		return this;
	}
	public String getCompany() {
		return company;
	}
	public SellerVO setCompany(String company) {
		this.company = company;
		return this;
	}
	public String getLicense1() {
		return license1;
	}
	public SellerVO setLicense1(String license1) {
		this.license1 = license1;
		return this;
	}
	public String getLicense2() {
		return license2;
	}
	public SellerVO setLicense2(String license2) {
		this.license2 = license2;
		return this;
	}
	public String getLicense3() {
		return license3;
	}
	public SellerVO setLicense3(String license3) {
		this.license3 = license3;
		return this;
	}
	public String getSalesname() {
		return salesname;
	}
	public SellerVO setSalesname(String salesname) {
		this.salesname = salesname;
		return this;
	}
	public String getSalesphone1() {
		return salesphone1;
	}
	public SellerVO setSalesphone1(String salesphone1) {
		this.salesphone1 = salesphone1;
		return this;
	}
	public String getSalesphone2() {
		return salesphone2;
	}
	public SellerVO setSalesphone2(String salesphone2) {
		this.salesphone2 = salesphone2;
		return this;
	}
	public String getSalesphone3() {
		return salesphone3;
	}
	public SellerVO setSalesphone3(String salesphone3) {
		this.salesphone3 = salesphone3;
		return this;
	}
	public String getSalesemail() {
		return salesemail;
	}
	public SellerVO setSalesemail(String salesemail) {
		this.salesemail = salesemail;
		return this;
	}
	public String getBrand() {
		return brand;
	}
	public SellerVO setBrand(String brand) {
		this.brand = brand;
		return this;
	}
	public String getCategory() {
		return category;
	}
	public SellerVO setCategory(String category) {
		this.category = category;
		return this;
	}
	public String getAboutproduct() {
		return aboutproduct;
	}
	public SellerVO setAboutproduct(String aboutproduct) {
		this.aboutproduct = aboutproduct;
		return this;
	}
	
	public String toString() {
		return "SellerVO = [sno="+sno+", company="+company+", license1= "+license1+", license2="+license2+", license3="+license3+", salesname="+salesname
				+", salesphone1="+salesphone1+", salesphone2="+salesphone2+", salesphone3="+salesphone3+", salesemail="+salesemail+", brand="+brand+", category="
				+category+", aboutproduct="+aboutproduct+"]";
	}
	
}
