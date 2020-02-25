package com.lee.myapp.domain;

public class FaqVO {
	/*
	CREATE TABLE TBL_FAQ(
	    QNO INT NOT NULL,
	    MNO INT NOT NULL,
	    CATEGORY VARCHAR2(20) NOT NULL,
	    QUESTION VARCHAR2(100) NOT NULL,
	    ANSWER VARCHAR2(500) NOT NULL,
	    PRIMARY KEY(QNO),
	    FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
	); 
	
	CREATE SEQUENCE TBL_FAQ_QNO_SEQ START WITH 1;
	*/
	private int qno;
	private int mno;
	private String category;
	private String name;
	private String question;
	private String answer;
	
	public int getQno() {
		return qno;
	}
	public FaqVO setQno(int qno) {
		this.qno = qno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public FaqVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getCategory() {
		return category;
	}
	public FaqVO setCategory(String category) {
		this.category = category;
		return this;
	}
	public String getName() {
		return name;
	}
	public FaqVO setName(String name) {
		this.name = name;
		return this;
	}
	public String getQuestion() {
		return question;
	}
	public FaqVO setQuestion(String question) {
		this.question = question;
		return this;
	}
	public String getAnswer() {
		return answer;
	}
	public FaqVO setAnswer(String answer) {
		this.answer = answer;
		return this;
	}
	
	public String toString() {
		return "FaqVO = [qno = "+qno+", mno = "+mno+", category = "+category+", name="+name+", question = "+question+", answer = "+answer+" ]";
	}
}
