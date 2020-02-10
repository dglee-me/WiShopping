package com.lee.myapp.domain;

public class PromotionsReportVO {

	/*
	 * CREATE TABLE TBL_PROMOTIONS_REPORT(
		   RNO INT NOT NULL,
		   CNO INT NOT NULL,
		   RMNO INT NOT NULL,
		   CONTENT CLOB NOT NULL,
		   CAUSE INT NOT NULL,
		   PRIMARY KEY(RNO)
	   );
	
		CREATE SEQUENCE TBL_PROMOTIONS_REPORT_RNO START WITH 1;
	*/
	private int rno;
	private int cno;
	private int rmno;
	private String content;
	private int cause;
	
	public int getRno() {
		return rno;
	}
	public PromotionsReportVO setRno(int rno) {
		this.rno = rno;
		return this;
	}
	public int getCno() {
		return cno;
	}
	public PromotionsReportVO setCno(int cno) {
		this.cno = cno;
		return this;
	}
	public int getRmno() {
		return rmno;
	}
	public PromotionsReportVO setRmno(int rmno) {
		this.rmno = rmno;
		return this;
	}
	public String getContent() {
		return content;
	}
	public PromotionsReportVO setContent(String content) {
		this.content = content;
		return this;
	}
	public int getCause() {
		return cause;
	}
	public PromotionsReportVO setCause(int cause) {
		this.cause = cause;
		return this;
	}
	
	public String toString() {
		return "PromotionsReportVO = [ rno = " + rno + ", cno = " + cno + ", rmno = " + rmno + ", content = " + content + ", cause = " + cause + " ]";
	}
}
