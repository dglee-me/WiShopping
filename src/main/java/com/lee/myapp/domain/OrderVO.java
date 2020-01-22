package com.lee.myapp.domain;

import java.sql.Date;

public class OrderVO {
	/* 
		CREATE TABLE TBL_ORDER(
		    ONO INT NOT NULL,
		    ORDERNO VARCHAR2(50),
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
		    orderdate date default sysdate,
		    delivery_status int default 0,
		    REVIEW_STATUS INT DEFAULT 0,
		    PRIMARY KEY(ONO),
		    FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
		);
	 */
	private int ono;
	private String orderno;
	private int mno;
	private String orderrec;
	private String zipcode;
	private String receivedat;
	private String receivedatdetail;
	private String receivedphone;
	private String deliverymessage;
	private String payername;
	private String payeremail;
	private String payerphone;
	private int amount;
	private Date orderdate;
	private int deliverystatus;
	private int reviewstatus;
	
	public int getOno() {
		return ono;
	}
	public OrderVO setOno(int ono) {
		this.ono = ono;
		return this;
	}
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
	public String getOrderrec() {
		return orderrec;
	}
	public OrderVO setOrderrec(String orderrec) {
		this.orderrec = orderrec;
		return this;
	}
	public String getZipcode() {
		return zipcode;
	}
	public OrderVO setZipcode(String zipcode) {
		this.zipcode = zipcode;
		return this;
	}
	public String getReceivedat() {
		return receivedat;
	}
	public OrderVO setReceivedat(String receivedat) {
		this.receivedat = receivedat;
		return this;
	}
	public String getReceivedatdetail() {
		return receivedatdetail;
	}
	public OrderVO setReceivedatdetail(String receivedatdetail) {
		this.receivedatdetail = receivedatdetail;
		return this;
	}
	public String getReceivedphone() {
		return receivedphone;
	}
	public OrderVO setReceivedphone(String receivedphone) {
		this.receivedphone = receivedphone;
		return this;
	}
	public String getDeliverymessage() {
		return deliverymessage;
	}
	public OrderVO setDeliverymessage(String deliverymessage) {
		this.deliverymessage = deliverymessage;
		return this;
	}
	public String getPayername() {
		return payername;
	}
	public OrderVO setPayername(String payername) {
		this.payername = payername;
		return this;
	}
	public String getPayeremail() {
		return payeremail;
	}
	public OrderVO setPayeremail(String payeremail) {
		this.payeremail = payeremail;
		return this;
	}
	public String getPayerphone() {
		return payerphone;
	}
	public OrderVO setPayerphone(String payerphone) {
		this.payerphone = payerphone;
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
	public int getDeliverystatus() {
		return deliverystatus;
	}
	public OrderVO setDeliverystatus(int deliverystatus) {
		this.deliverystatus = deliverystatus;
		return this;
	}
	public int getReviewstatus() {
		return reviewstatus;
	}
	public OrderVO setReviewstatus(int reviewstatus) {
		this.reviewstatus = reviewstatus;
		return this;
	}
	
	public String toString() {
		return "OrderVO = [ono = "+ono+", orderno= "+orderno+", mno= "+mno+", orderrec= "+orderrec+", zipcode= "+zipcode+", receivedat= "+receivedat+", receivedatdetail= "
				+receivedatdetail+", receivedphone= "+receivedphone+", deliverymessage= "+deliverymessage+", payername= "+payername+", payeremail= "+payeremail
				+", payerphone= "+payerphone+", amount= "+amount+", orderdate= "+orderdate+", deliverystatus= "+deliverystatus+", reviewstatus = "+reviewstatus+"]";
	}
}
