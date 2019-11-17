package com.lee.myapp.domain;

public class OrderDetailVO {
	/*
		 CREATE TABLE TBL_ORDER_DETAIL(
		    orderDetailno int primary key,
		    orderno varchar2(50) not null,
		    pno int not null,
		    cartstock int not null
		);
		
		ALTER TABLE TBL_ORDER_DETAIL ADD CONSTRAINT TBL_ORDER_DETAIL_ORDERNO FOREIGN KEY(ORDERNO) REFERENCES TBL_ORDER(ORDERNO);
	 */
	
	private int orderdetailno;
	private String orderno;
	private int pno;
	private String cartsize;
	private int cartstock;
	
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
	public String getCartsize() {
		return cartsize;
	}
	public OrderDetailVO setCartsize(String cartsize) {
		this.cartsize = cartsize;
		return this;
	}
	public int getCartstock() {
		return cartstock;
	}
	public OrderDetailVO setCartstock(int cartstock) {
		this.cartstock = cartstock;
		return this;
	}
	
	public String toString() {
		return "OrderDetailVO = [orderdetailno= "+orderdetailno+", orderno= "+orderno+", pno= "+pno+", cartsize= "+cartsize+", cartstock= "+cartstock;
	}
}
