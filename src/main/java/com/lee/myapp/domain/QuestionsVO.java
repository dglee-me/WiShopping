package com.lee.myapp.domain;

import java.sql.Date;

public class QuestionsVO {
	/*
	CREATE TABLE TBL_QUESTIONS(
	    QNO INT NOT NULL,
	    MNO INT NOT NULL,
	    SUBJECT VARCHAR2(50) NOT NULL,
	    CONTENT CLOB NOT NULL,
	    IMAGES_URL VARCHAR2(500) NOT NULL,
	    WRITEDATE DATE NOT NULL,
	    STATUS INT DEFAULT 0,
	    PRIMARY KEY(QNO),
	    FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
	);
	
	CREATE SEQUENCE TBL_QUESTIONS_QNO_SEQ START WITH 1;
	*/
	private int qno;
	private int mno;
	private String subject;
	private String content;
	private String imagesurl;
	private Date writedate;
	private int status;
	
	public int getQno() {
		return qno;
	}
	public QuestionsVO setQno(int qno) {
		this.qno = qno;
		return this;
	}
	public int getMno() {
		return mno;
	}
	public QuestionsVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getSubject() {
		return subject;
	}
	public QuestionsVO setSubject(String subject) {
		this.subject = subject;
		return this;
	}
	public String getContent() {
		return content;
	}
	public QuestionsVO setContent(String content) {
		this.content = content;
		return this;
	}
	public String getImagesurl() {
		return imagesurl;
	}
	public QuestionsVO setImagesurl(String imagesurl) {
		this.imagesurl = imagesurl;
		return this;
	}
	public Date getWritedate() {
		return writedate;
	}
	public QuestionsVO setWritedate(Date writedate) {
		this.writedate = writedate;
		return this;
	}
	public int getStatus() {
		return status;
	}
	public QuestionsVO setStatus(int status) {
		this.status = status;
		return this;
	}
	
	public String toString() {
		return "QuestionsVO = [qno = "+qno+", mno = "+mno+", subject = "+subject
				+", content = "+content+", images_url = "+imagesurl+", writedate = "+writedate
				+", status = "+status+" ]";
	}
}
