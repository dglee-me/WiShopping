package com.lee.myapp.domain;

public class OrderDetailVO {
	/*
		 CREATE TABLE TBL_ORDER_DETAIL(
		    ORDERDETAILNO INT NOT NULL,
		    ORDERNO VARCHAR2(50) NOT NULL,
		    PNO INT NOT NULL,
		    ONO INT NOT NULL,
		    OPTIONCOLOR VARCHAR2(50) NOT NULL,
		    OPTIONSIZE VARCHAR2(50) NOT NULL,
		    INVENTORY INT NOT NULL,
    		REVIEW_STATUS INT DEFAULT 0,
		    PRIMARY KEY(ORDERDETAILNO),
		    FOREIGN KEY(ONO) REFERENCES TBL_PRODUCT_OPTION(ONO),
		    FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO)
		);
	 */
	private int orderdetailno;
	private String orderno;
	private int pno;
	private String optioncolor;
	private String optionsize;
	private int inventory;
	private int reviewstatus;
	
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
	public int getReviewstatus() {
		return reviewstatus;
	}
	public OrderDetailVO setReviewstatus(int reviewstatus) {
		this.reviewstatus = reviewstatus;
		return this;
	}
	
	public String toString() {
		return "OrderDetailVO = [orderdetailno= "+orderdetailno+", orderno= "+orderno+", pno= "+pno+", optioncolor= "+optioncolor+", optionsize= "+optionsize
				+", inventory= "+inventory+", review_status = "+reviewstatus+"]";
	}
}
