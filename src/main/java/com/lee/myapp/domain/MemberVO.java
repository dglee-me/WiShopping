package com.lee.myapp.domain;

import java.sql.Date;

public class MemberVO {
	private int mno;
	private String email;
	private String auth;
	private String pw;
	private String name;
	private String tel;
	private Date createddate;
	private int mlevel;
	
	public int getMno() {
		return mno;
	}
	public MemberVO setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getEmail() {
		return email;
	}
	public MemberVO setEmail(String email) {
		this.email = email;
		return this;
	}
	
	public String getAuth() {
		return auth;
	}

	public MemberVO setAuth(String auth) {
		this.auth = auth;
		return this;
	}
	
	public String getPw() {
		return pw;
	}
	public MemberVO setPw(String pw) {
		this.pw = pw;
		return this;
	}
	public String getName() {
		return name;
	}
	public MemberVO setName(String name) {
		this.name = name;
		return this;
	}
	public String getTel() {
		return tel;
	}
	public MemberVO setTel(String tel) {
		this.tel = tel;
		return this;
	}
	public Date getCreateddate() {
		return createddate;
	}
	public MemberVO setCreateddate(Date createddate) {
		this.createddate = createddate;
		return this;
	}
	public int getMlevel() {
		return mlevel;
	}
	public MemberVO setMlevel(int mlevel) {
		this.mlevel = mlevel;
		return this;
	}
	public String toString() {
		return "MemberVO [mno="+mno+", email="+email+", auth="+auth+", pw="+pw+", name="+name+", tel="+tel+", createddate="+createddate+", Mlevel="+mlevel+"]";
	}
}
