package com.lee.myapp.domain;

import java.sql.Date;

public class BoardVO {
	private int bno;
	private String subject;
	private String nickname;
	private String content;
	private String category;
	private Date writedate;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	public String toString() {
		return "BoardVO [bno="+bno+", nickname="+nickname+", subject="+subject+", category="+category+", content="+content+", writedate="+writedate+"]";
	}
}
