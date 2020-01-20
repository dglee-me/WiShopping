package com.lee.myapp.domain;

public class OrderDetailVO {
	/*
		 CREATE TABLE TBL_ORDER_DETAIL(
		    orderDetailno int primary key,
		    orderno varchar2(50) not null,
		    pno int not null,
		    ONO INT NOT NULL,
		    optioncolor varchar2(50) not null,
            optionsize varchar2(50) not null,
            inventory int not null
		);
		
		ALTER TABLE TBL_ORDER_DETAIL ADD CONSTRAINT TBL_ORDER_DETAIL_ONO FOREIGN KEY(ONO) REFERENCES TBL_PRODUCT_OPTION(ONO);
		ALTER TABLE TBL_ORDER_DETAIL ADD CONSTRAINT TBL_ORDER_DETAIL_ORDERNO FOREIGN KEY(ORDERNO) REFERENCES TBL_ORDER(ORDERNO);
	 */
	private int orderdetailno;
	private String orderno;
	private int pno;
	private String optioncolor;
	private String optionsize;
	private int inventory;
	
	public int getOrderdetailno() {
		return orderdetailno;
	}
	public OrderDetailVO setOrderdetailno(int orderdetailno) {
		this.orderdetailno = orderdetailno;
		return this;
	}
	public String getOrderno() {
		return orderno;
	}
	public OrderDetailVO setOrderno(String orderno) {
		this.orderno = orderno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public OrderDetailVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public String getOptioncolor() {
		return optioncolor;
	}
	public OrderDetailVO setOptioncolor(String optioncolor) {
		this.optioncolor = optioncolor;
		return this;
	}
	public String getOptionsize() {
		return optionsize;
	}
	public OrderDetailVO setOptionsize(String optionsize) {
		this.optionsize = optionsize;
		return this;
	}
	public int getInventory() {
		return inventory;
	}
	public OrderDetailVO setInventory(int inventory) {
		this.inventory = inventory;
		return this;
	}
	
	public String toString() {
		return "OrderDetailVO = [orderdetailno= "+orderdetailno+", orderno= "+orderno+", pno= "+pno+", optioncolor= "+optioncolor+", optionsize= "+optionsize
				+", inventory= "+inventory+"]";
	}
}
