package com.lee.myapp.domain;

import java.sql.Date;

public class OrderVO {
	/* 
		CREATE TABLE TBL_ORDER(
		    ORDERNO VARCHAR2(50) PRIMARY KEY,
		    MNO INT NOT NULL,
		    ORDER_REC VARCHAR2(50) NOT NULL,
		    ZIPCODE VARCHAR2(20) NOT NULL,
		    received_at varchar2(50) not null,
		    received_at_detail varchar2(50),
		    received_phone varchar2(11),
		    delivery_message varchar2(100),
		    payer_name VARCHAR2(50) NOT NULL,
		    payer_email varchar2(50) not null,
		    payer_phone varchar2(11) not null,
		    amount int not null,
		    orderdate date default sysdate
		); 
		
		ALTER TABLE TBL_ORDER ADD CONSTRAINT TBL_ORDER_MNO FOREIGN KEY(MNO) REFERENCES MEMBER(MNO);
	 */
	private String orderno;
	private int mno;
	private String order_rec;
	private String zipcode;
	private String received_at;
	private String received_at_detail;
	private String received_phone;
	private String delivery_message;
	private String payer_name;
	private String payer_email;
	private String payer_phone;
	private int amount;
	private Date orderdate;
	
	public String getOrderno() {
		return orderno;
	}
	public OrderVO setOrderno(String orderno) {
		this.orderno = orderno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public OrderVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getOrder_rec() {
		return order_rec;
	}
	public OrderVO setOrder_rec(String order_rec) {
		this.order_rec = order_rec;
		return this;
	}
	public String getZipcode() {
		return zipcode;
	}
	public OrderVO setZipcode(String zipcode) {
		this.zipcode = zipcode;
		return this;
	}
	public String getReceived_at() {
		return received_at;
	}
	public OrderVO setReceived_at(String received_at) {
		this.received_at = received_at;
		return this;
	}
	public String getReceived_at_detail() {
		return received_at_detail;
	}
	public OrderVO setReceived_at_detail(String received_at_detail) {
		this.received_at_detail = received_at_detail;
		return this;
	}
	public String getReceived_phone() {
		return received_phone;
	}
	public OrderVO setReceived_phone(String received_phone) {
		this.received_phone = received_phone;
		return this;
	}
	public String getDelivery_message() {
		return delivery_message;
	}
	public OrderVO setDelivery_message(String delivery_message) {
		this.delivery_message = delivery_message;
		return this;
	}
	public String getPayer_name() {
		return payer_name;
	}
	public OrderVO setPayer_name(String payer_name) {
		this.payer_name = payer_name;
		return this;
	}
	public String getPayer_email() {
		return payer_email;
	}
	public OrderVO setPayer_email(String payer_email) {
		this.payer_email = payer_email;
		return this;
	}
	public String getPayer_phone() {
		return payer_phone;
	}
	public OrderVO setPayer_phone(String payer_phone) {
		this.payer_phone = payer_phone;
		return this;
	}
	public int getAmount() {
		return amount;
	}
	public OrderVO setAmount(int amount) {
		this.amount = amount;
		return this;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public OrderVO setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
		return this;
	}
	
	public String toString() {
		return "OrderVO = [orderno= "+orderno+", mno= "+mno+", order_rec= "+order_rec+", zipcode= "+zipcode+", received_at= "+received_at+", received_at_detail= "
				+received_at_detail+", received_phone= "+received_phone+", delivery_message= "+delivery_message+", payer_name= "+payer_name+", payer_email= "+payer_email
				+", payer_phone= "+payer_phone+", amount= "+amount+orderdate+", orderdate= "+orderdate+"]";
	}
}
