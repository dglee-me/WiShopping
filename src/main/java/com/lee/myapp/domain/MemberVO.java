package com.lee.myapp.domain;

import java.sql.Date;

public class MemberVO {
	private int mno;
	private String email;
	private String auth;
	private String pw;
	private String name;
	private String tel;
	private Date createdate;
	private int mlevel;
	private String sessionkey;
	private Date sessionlimit;
	
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
	public Date getCreatedate() {
		return createdate;
	}
	public MemberVO setCreatedate(Date createdate) {
		this.createdate = createdate;
		return this;
	}
	public int getMlevel() {
		return mlevel;
	}
	public MemberVO setMlevel(int mlevel) {
		this.mlevel = mlevel;
		return this;
	}
	public String getSessionkey() {
		return sessionkey;
	}
	public MemberVO setSessionkey(String sessionkey) {
		this.sessionkey = sessionkey;
		return this;
	}
	public Date getSessionlimit() {
		return sessionlimit;
	}
	public MemberVO setSessionlimit(Date sessionlimit) {
		this.sessionlimit = sessionlimit;
		return this;
	}
	
	public String toString() {
		return "MemberVO = [mno= "+mno+", email= "+email+", auth= "+auth+", pw= "+pw+", name= "+name+", tel= "+tel+", createdate= "+createdate+", mlevel= "+mlevel+
				", sessionkey= "+sessionkey+", sessionlimit= "+sessionlimit+" ]";
	}

}
