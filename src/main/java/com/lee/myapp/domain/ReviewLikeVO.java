package com.lee.myapp.domain;

public class ReviewLikeVO {
	/*
		 CREATE TABLE TBL_PRODUCT_REVIEW_LIKE(
		    LNO INT NOT NULL,
		    RNO INT NOT NULL,
		    MNO INT NOT NULL,
		    LIKE_CHECK INT DEFAULT 0,
		    PRIMARY KEY(LNO),
		    FOREIGN KEY(RNO) REFERENCES TBL_PRODUCT_REVIEW(RNO) ON DELETE CASCADE,
		    FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
		    ON DELETE CASCADE
		);
		
		CREATE SEQUENCE TBL_PRODUCT_REVIEW_LIKE_SEQ START WITH 1;
	*/
	private int lno;
	private int rno;
	private int mno;
	private int likecheck;
	private int count; // When only review select
	
	public int getLno() {
		return lno;
	}
	public ReviewLikeVO setLno(int lno) {
		this.lno = lno;
		return this;
	}
	public int getRno() {
		return rno;
	}
	public ReviewLikeVO setRno(int rno) {
		this.rno = rno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public ReviewLikeVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public int getLikecheck() {
		return likecheck;
	}
	public ReviewLikeVO setLikecheck(int likecheck) {
		this.likecheck = likecheck;
		return this;
	}
	public int getCount() {
		return count;
	}
	public ReviewLikeVO setCount(int count) {
		this.count = count;
		return this;
	}
	
	public String toString() {
		return "ReviewLikeVO = [ lno = "+lno+", rno = "+rno+", mno = "+mno+", likecheck = "+likecheck+", count = "+count+" ]";
	}
}
