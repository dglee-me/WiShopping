package com.lee.myapp.domain;

public class ProductOptionVO {
	/*
		CREATE TABLE TBL_PRODUCT_OPTION(
			ONO INT NOT NULL,
		    PNO INT NOT NULL,
		    OPTION_COLOR VARCHAR2(50) NOT NULL,
		    OPTION_SIZE VARCHAR2(50) NOT NULL,
		    INVENTORY INT NOT NULL,
		    PRIMARY KEY(ONO),
		    FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO) 
		);
	*/
	private int ono;
	private int pno;
	private String color;
	private String size;
	private int inventory;
	
	
	public int getOno() {
		return ono;
	}
	public ProductOptionVO setOno(int ono) {
		this.ono = ono;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public ProductOptionVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public String getColor() {
		return color;
	}
	public ProductOptionVO setColor(String color) {
		this.color = color;
		return this;
	}
	public String getSize() {
		return size;
	}
	public ProductOptionVO setSize(String size) {
		this.size = size;
		return this;
	}
	public int getInventory() {
		return inventory;
	}
	public ProductOptionVO setInventory(int inventory) {
		this.inventory = inventory;
		return this;
	}
	
	public String toString() {
		return "ProductOptionVO = [ono= "+ono+", pno= "+pno+", color= "+color+", size= "+size+", inventory= "+inventory+"]";
	}
}
