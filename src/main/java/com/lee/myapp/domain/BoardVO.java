package com.lee.myapp.domain;

import java.sql.Date;

public class BoardVO {
	private int bno;
	private String category;
	private String subject;
	private String content;
	private String author;
	private int readcount;
	private Date writedate;
	private int replycount;
	private int prevbno;
	private int nextbno;
	
	public int getBno() {
		return bno;
	}
	
	public BoardVO setBno(int bno) {
		this.bno = bno;
		return this;
	}
	
	public String getCategory() {
		return category;
	}
	
	public BoardVO setCategory(String category) {
		this.category = category;
		return this;
	}
	public String getSubject() {
		return subject;
	}
	
	public BoardVO setSubject(String subject) {
		this.subject = subject;
		return this;
	}
	
	public String getContent() {
		return content;
	}
	public BoardVO setContent(String content) {
		this.content = content;
		return this;
	}
	
	public String getAuthor() {
		return author;
	}
	public BoardVO setAuthor(String author) {
		this.author = author;
		return this;
	}
	
	public int getReadcount() {
		return readcount;
	}
	public BoardVO setReadcount(int readcount) {
		this.readcount = readcount;
		return this;
	}
	
	public Date getWritedate() {
		return writedate;
	}
	public BoardVO setWritedate(Date writedate) {
		this.writedate = writedate;
		return this;
	}
	
	public int getReplycount() {
		return replycount;
	}
	public BoardVO setReplycount(int replycount) {
		this.replycount = replycount;
		return this;
	}
	
	public int getPrevbno() {
		return prevbno;
	}
	public BoardVO setPrev_bno(int prevbno) {
		this.prevbno = prevbno;
		return this;
	}
	
	public int getNextbno() {
		return nextbno;
	}
	public BoardVO setNextbno(int nextbno) {
		this.nextbno = nextbno;
		return this;
	}
	
	public String toString() {
		return "BoardVO [bno="+bno+", category="+category+", subject="+subject+", content="+content+", author="+author+", readcount="+readcount
				+", writedate="+writedate+", replycount="+replycount+", prev_bno = "+prevbno+", next_bno = "+nextbno+" ]";
	}
}
