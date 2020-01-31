package com.lee.myapp.domain;

import java.sql.Date;

public class ProductQuestionVO {
	/*
	    CREATE TABLE TBL_PRODUCT_QUESTION(
		     QNO INT NOT NULL,
		     PNO INT NOT NULL,
		     MNO INT NOT NULL,
		     CATEGORY VARCHAR2(20) NOT NULL,
		     CONTENT VARCHAR2(1000),
		     WRITEDATE DATE,
		     STATUS INT DEFAULT 0,
		     ISSECRET INT DEFAULT 0,
		     PRIMARY KEY(QNO),
		     FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO) ON DELETE SET NULL,
		     FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
		     ON DELETE CASCADE
		); 
		
		CREATE TABLE TBL_PRODUCT_ANSWER(
		  ANO INT NOT NULL,
		  QNO INT NOT NULL,
		  SNO INT NOT NULL,
		  BRAND VARCHAR2(50) NOT NULL,
		  ANSWER VARCHAR2(1000) NOT NULL,
		  ANSWERDATE DATE NOT NULL,
		  PRIMARY KEY(ANO),
		  FOREIGN KEY(QNO) REFERENCES TBL_PRODUCT_QUESTION(QNO) ON DELETE CASCADE,
		  FOREIGN KEY(SNO) REFERENCES TBL_SELLER(SNO) ON DELETE CASCADE
		);
		
		CREATE SEQUENCE TBL_PRODUCT_QUESTION_QNO_SEQ START WITH 1;
		CREATE SEQUENCE TBL_PRODUCT_ANSWER_ANO_SEQ START WITH 1;
	*/
	//Question
	private int qno;
	private int pno;
	private int mno;
	private String name;
	private String category;
	private String content;
	private Date writedate;
	private int status;
	private int issecret;
	
	//Answer
	private int ano;
	private String brand;
	private String answer;
	private Date answerdate;
	
	public int getQno() {
		return qno;
	}
	public ProductQuestionVO setQno(int qno) {
		this.qno = qno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public ProductQuestionVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public ProductQuestionVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getName() {
		return name;
	}
	public ProductQuestionVO setName(String name) {
		this.name = name;
		return this;
	}
	public String getCategory() {
		return category;
	}
	public ProductQuestionVO setCategory(String category) {
		this.category = category;
		return this;
	}
	public String getContent() {
		return content;
	}
	public ProductQuestionVO setContent(String content) {
		this.content = content;
		return this;
	}
	public Date getWritedate() {
		return writedate;
	}
	public ProductQuestionVO setWritedate(Date writedate) {
		this.writedate = writedate;
		return this;
	}
	public int getStatus() {
		return status;
	}
	public ProductQuestionVO setStatus(int status) {
		this.status = status;
		return this;
	}
	public int getIssecret() {
		return issecret;
	}
	public ProductQuestionVO setIssecret(int issecret) {
		this.issecret = issecret;
		return this;
	}
	
	//Answer
	public int getAno() {
		return ano;
	}
	public ProductQuestionVO setAno(int ano) {
		this.ano = ano;
		return this;
	}
	public String getBrand() {
		return brand;
	}
	public ProductQuestionVO setBrand(String brand) {
		this.brand = brand;
		return this;
	}
	public String getAnswer() {
		return answer;
	}
	public ProductQuestionVO setAnswer(String answer) {
		this.answer = answer;
		return this;
	}
	public Date getAnswerdate() {
		return answerdate;
	}
	public ProductQuestionVO setAnswerdate(Date answerdate) {
		this.answerdate = answerdate;
		return this;
	}
	
	public String toString() {
		return "ProductQuestionVO = [ qno = "+qno+", pno = "+pno+", mno = "+mno+", name = "+name+", category = "+category+", content = "+content
				+", writedate = "+writedate+", status = "+status+", issecret = "+issecret+", ano = "+ano+", brand = "+brand+", answer = "+answer
				+", answerdate = "+answerdate+" ]";
	}
}
