package com.lee.myapp.domain;

public class CartVO {
	/*
		CREATE TABLE TBL_CART(
		    CARTNO VARCHAR2(50) NOT NULL,
		    MNO INT NOT NULL,
		    PNO INT NOT NULL,
		    OPTIONCOLOR VARCHAR2(50) NOT NULL,
		    OPTIONSIZE VARCHAR2(50) NOT NULL,
		    INVENTORY INT NOT NULL,
		    PRIMARY KEY(CARTNO, MNO)
		);
		
		ALTER TABLE TBL_CART ADD CONSTRAINT TBL_CART_MNO FOREIGN KEY(MNO) REFERENCES MEMBER(MNO);
		
		ALTER TABLE TBL_CART ADD CONSTRAINT TBL_CART_PNO FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO);
	 */
	
	private int cartno; //cart number
	private int mno; //users number
	private int pno; //product number
	private String optioncolor; //product quantity in the cart
	private String optionsize; //product size in the cart
	private int inventory;
	
	public int getCartno() {
		return cartno;
	}
	public CartVO setCartno(int cartno) {
		this.cartno = cartno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public CartVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public CartVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public String getOptioncolor() {
		return optioncolor;
	}
	public CartVO setOptioncolor(String optioncolor) {
		this.optioncolor = optioncolor;
		return this;
	}
	public String getOptionsize() {
		return optionsize;
	}
	public CartVO setOptionsize(String optionsize) {
		this.optionsize = optionsize;
		return this;
	}
	public int getInventory() {
		return inventory;
	}
	public CartVO setInventory(int inventory) {
		this.inventory = inventory;
		return this;
	}
	
	public String toString() {
		return "CartVO = [cartno= "+cartno+", mno= "+mno+", pno= "+pno+", optioncolor= "+optioncolor+", optionsize= "+optionsize+", inventory= "+inventory+"]";
	}
}
