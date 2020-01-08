package com.lee.myapp.domain;

public class PromotionsCommentVO {
	/*
		CREATE TABLE TBL_PROMOTIONS_COMMENT(
		    RNO INT NOT NULL,
		    PNO INT NOT NULL,
		    MNO INT NOT NULL,
		    CONTENT CLOB NOT NULL,
		    REPLY_TIME DATE NOT NULL,
		    PRIMARY KEY(RNO),
		    FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
		);
		
		ALTER TABLE TBL_PROMOTIONS_COMMENT ADD CONSTRAINT TBL_PROMOTIONS_COMMENT_FK FOREIGN KEY(PNO) REFERENCES TBL_PROMOTIONS(PNO) ON DELETE CASCADE;
		
		CREATE SEQUENCE TBL_PROMOTIONS_REPLY_SEQ START WITH 1;
	*/
	private int rno;
	private int pno;
	private int mno;
	private String name; // Parameters Received as Result of Member and Inner Join in comment view
	private String content;
	private String replytime;
	
	public int getRno() {
		return rno;
	}
	public PromotionsCommentVO setRno(int rno) {
		this.rno = rno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public PromotionsCommentVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public PromotionsCommentVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getName() {
		return name;
	}
	public PromotionsCommentVO setName(String name) {
		this.name = name;
		return this;
	}
	public String getContent() {
		return content;
	}
	public PromotionsCommentVO setContent(String content) {
		this.content = content;
		return this;
	}
	public String getReplytime() {
		return replytime;
	}
	public PromotionsCommentVO setReplytime(String replytime) {
		this.replytime = replytime;
		return this;
	}
	
	public String toString() {
		return "PromotionsReplyVO = [ rno = "+rno+", pno = "+pno+", mno = "+mno+", name = "+name+", content = "+content+", replytime = "+replytime;
	}
}