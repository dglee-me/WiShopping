package com.lee.myapp.domain;

public class CommentCriteria {
	private int page;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;
	private int pno;
	private int mno;
	private String order;
	
	private String category; //Customer center category only
	
	public CommentCriteria() {
		this.page=1;
		this.perPageNum = 5;
	}
	
	public void setPage(int page) {
		if(page<=0) {
			this.page=1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 5;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPageStart() {
		return (this.page -1)*perPageNum;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getRowStart() {
		rowStart = ((page-1)*perPageNum)+1;
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd = rowStart +perPageNum -1;
		return rowEnd;
	}
	public CommentCriteria setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public int getMno() {
		return mno;
	}
	public CommentCriteria setMno(int mno) {
		this.mno = mno;
		return this;
	}
	public String getOrder() {
		return order;
	}
	public CommentCriteria setOrder(String order) {
		this.order = order;
		return this;
	}

	public CommentCriteria setCategory(String category) {
		this.category = category;
		return this;
	}
	
	public String getcategory() {
		return category;
	}

	@Override
	public String toString() {
		return "CommentCriteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ ", pno = " + pno +", mno = "+mno+", order = "+order+", category = "+category+"]";
	}
}