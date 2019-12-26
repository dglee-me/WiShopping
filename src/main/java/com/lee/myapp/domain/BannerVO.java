package com.lee.myapp.domain;

public class BannerVO {
	/*
		CREATE TABLE TBL_BANNER(
	    BNO INT NOT NULL,
	    AREA VARCHAR2(50) NOT NULL,
	    BANNER_URL VARCHAR2(500) NOT NULL,
	    BANNER_LINK VARCHAR2(500) NOT NULL,
	    PRIMARY KEY(BNO)
		);
		
		CREATE SEQUENCE TBL_BANNER_SEQ START WITH 1;
	*/
	private int bno;
	private String area;
	private String bannerurl;
	private String bannerlink;
	
	public int getBno() {
		return bno;
	}
	public BannerVO setBno(int bno) {
		this.bno = bno;
		return this;
	}
	public String getArea() {
		return area;
	}
	public BannerVO setArea(String area) {
		this.area = area;
		return this;
	}
	public String getBannerurl() {
		return bannerurl;
	}
	public BannerVO setBannerurl(String bannerurl) {
		this.bannerurl = bannerurl;
		return this;
	}
	public String getBannerlink() {
		return bannerlink;
	}
	public BannerVO setBannerlink(String bannerlink) {
		this.bannerlink = bannerlink;
		return this;
	}
	
	public String toString() {
		return "BannerVO = [bno="+bno+", area="+area+", bannerurl="+bannerurl+", bannerlink="+bannerlink+"]";
	}
}
