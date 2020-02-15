package com.lee.myapp.domain;

public class CategoryVO {
	/*
		CREATE TABLE TBL_CATEGORY(
		    CNO INT NOT NULL,
		    DEPTH INT NOT NULL,
		    CNAME VARCHAR2(50) NOT NULL,
		    CLASSIFY INT NOT NULL,
		    CREF INT,
		    PRIMARY KEY(CNO)
		);
	 
	  	CREATE SEQUENCE TBL_CATEGORY_CNO_SEQ START WITH 1;
	 */
	
	private int cno;
	private int depth;
	private String cname;
	private int classify;
	private int cref;
	
	//Read only
	private String category;
	private int category1;
	private int category2;
	
	public int getCno() {
		return cno;
	}
	public CategoryVO setCno(int cno) {
		this.cno = cno;
		return this;
	}
	public int getDepth() {
		return depth;
	}
	public CategoryVO setDepth(int depth) {
		this.depth = depth;
		return this;
	}
	public String getCname() {
		return cname;
	}
	public CategoryVO setCname(String cname) {
		this.cname = cname;
		return this;
	}
	public int getClassify() {
		return classify;
	}
	public CategoryVO setClassify(int classify) {
		this.classify = classify;
		return this;
	}
	public int getCref() {
		return cref;
	}
	public CategoryVO setCref(int cref) {
		this.cref = cref;
		return this;
	}
	public String getCategory() {
		return category;
	}
	public CategoryVO setCategory(String category) {
		this.category = category;
		return this;
	}
	public int getCategory1() {
		return category1;
	}
	public CategoryVO setCategory1(int category1) {
		this.category1 = category1;
		return this;
	}
	public int getCategory2() {
		return category2;
	}
	public CategoryVO setCategory2(int category2) {
		this.category2 = category2;
		return this;
	}
	
	public String toString() {
		return "CategoryVO = [ cno = "+cno+", depth = "+depth+", cname = "+cname+", classify = "+classify+", cref = "
				+cref+", category = "+category+", category1 = "+category1+", category2 = "+category2+" ]";
	}
}
