package com.lee.myapp.domain;

import java.sql.Date;

public class ReviewVO {
	/*
	   CREATE TABLE TBL_PRODUCT_REVIEW(
	   		RNO INT NOT NULL,
	   		PNO INT NOT NULL,
			MNO INT NOT NULL,
			ONO INT NOT NULL,
		    OPTION_COLOR VARCHAR2(50) NOT NULL,
		    OPTION_SIZE VARCHAR2(50) NOT NULL,
		    CONTENT CLOB NOT NULL,
		    WRITEDATE DATE NOT NULL,
		    CONTENT_IMG VARCHAR2(500) NOT NULL,
		    PRIMARY KEY(RNO),
		    FOREIGN KEY(MNO) REFERENCES MEMBER(MNO),
		    FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO)
		    ON DELETE CASCADE
		); 
		
		CREATE SEQUENCE TBL_PRODUCT_REVIEW_RNO_SEQ START WITH 1;
	*/
	private int rno;
	private int pno;
	private int mno;
	private String name; // insert not , only select
	private String orderno;
	private int ono;
	private String optioncolor;
	private String optionsize;
	private String content;
	private Date writedate;
	private String contentimg;
	private int likecount;
	private int likecheck;
	
	public int getRno() {
		return rno;
	}
	public ReviewVO setRno(int rno) {
		this.rno = rno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public ReviewVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public ReviewVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getName() {
		return name;
	}
	public ReviewVO setName(String name) {
		this.name = name;
		return this;
	}
	public String getOrderno() {
		return orderno;
	}
	public ReviewVO setOrderno(String orderno) {
		this.orderno = orderno;
		return this;
	}
	public int getOno() {
		return ono;
	}
	public ReviewVO setOno(int ono) {
		this.ono = ono;
		return this;
	}
	public String getOptioncolor() {
		return optioncolor;
	}
	public ReviewVO setOptioncolor(String optioncolor) {
		this.optioncolor = optioncolor;
		return this;
	}
	public String getOptionsize() {
		return optionsize;
	}
	public ReviewVO setOptionsize(String optionsize) {
		this.optionsize = optionsize;
		return this;
	}
	public String getContent() {
		return content;
	}
	public ReviewVO setContent(String content) {
		this.content = content;
		return this;
	}
	public Date getWritedate() {
		return writedate;
	}
	public ReviewVO setWritedate(Date writedate) {
		this.writedate = writedate;
		return this;
	}
	public String getContentimg() {
		return contentimg;
	}
	public ReviewVO setContentimg(String contentimg) {
		this.contentimg = contentimg;
		return this;
	}
	public int getLikecount() {
		return likecount;
	}
	public ReviewVO setLikecount(int likecount) {
		this.likecount = likecount;
		return this;
	}
	public int getLikecheck() {
		return likecheck;
	}
	public ReviewVO setLikecheck(int likecheck) {
		this.likecheck = likecheck;
		return this;
	}
	
	public String toString() {
		return "ReviewVO = [rno = "+rno+", pno = "+pno+", mno = "+mno+", name = "+name+", ono = "+ono+", orderno = "+orderno
				+", optioncolor = "+optioncolor+", optionsize = "+optionsize+", content = "
				+content+", writedate = "+writedate+", contentimg = "+contentimg+", likecount = "+likecount+", likeCheck = "+likecheck+" ]";
	}
}
