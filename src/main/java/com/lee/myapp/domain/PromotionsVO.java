package com.lee.myapp.domain;

import java.sql.Date;

public class PromotionsVO {
	/*
	 CREATE TABLE TBL_PROMOTIONS(
	    PNO INT NOT NULL,
	    SUBJECT VARCHAR2(50) NOT NULL,
	    THUMBNAIL_URL VARCHAR2(500) NOT NULL,
	    IMAGES_URL VARCHAR2(500) NOT NULL,
	    STARTDATE DATE NOT NULL,
	    ENDDATE DATE NOT NULL,
	    STATUS INT DEFAULT 1,
	    PRIMARY KEY(PNO)
		);
	*/
	private int pno;
	private String subject;
	private String thumbnailurl;
	private String imagesurl;
	private Date startdate;
	private Date enddate;
	private int status;
	
	public int getPno() {
		return pno;
	}
	public PromotionsVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public String getSubject() {
		return subject;
	}
	public PromotionsVO setSubject(String subject) {
		this.subject = subject;
		return this;
	}
	public String getThumbnailurl() {
		return thumbnailurl;
	}
	public PromotionsVO setThumbnailurl(String thumbnailurl) {
		this.thumbnailurl = thumbnailurl;
		return this;
	}
	public String getImagesurl() {
		return imagesurl;
	}
	public PromotionsVO setImagesurl(String imagesurl) {
		this.imagesurl = imagesurl;
		return this;
	}
	public Date getStartdate() {
		return startdate;
	}
	public PromotionsVO setStartdate(Date startdate) {
		this.startdate = startdate;
		return this;
	}
	public Date getEnddate() {
		return enddate;
	}
	public PromotionsVO setEnddate(Date enddate) {
		this.enddate = enddate;
		return this;
	}
	public int getStatus() {
		return status;
	}
	public PromotionsVO setStatus(int status) {
		this.status = status;
		return this;
	}
	
	public String toString() {
		return "PromotionsVO = [pno = "+pno+", subject = "+subject+", thumbnailurl = "+thumbnailurl+", imagesurl = "+imagesurl
				+", startdate = "+startdate+", enddate = "+enddate+", status = "+status+" ]";
	}
}