package com.lee.myapp.domain;

public class ProductOptionVO {
	/*
		CREATE TABLE TBL_PRODUCT_OPTION(
			ONO INT NOT NULL,
		    PNO INT NOT NULL,
		    OPTION_COLOR VARCHAR2(50) NOT NULL,
		    OPTION_SIZE VARCHAR2(50) NOT NULL,
		    INVENTORY INT NOT NULL,
		    PRIMARY KEY(ONO),
		    FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO) 
		);
	*/
	private int ono;
	private int sequence;
	private int pno;
	private String optioncolor;
	private String optionsize;
	private int inventory;
	
	public int getOno() {
		return ono;
	}
	public ProductOptionVO setOno(int ono) {
		this.ono = ono;
		return this;
	}
	public int getSequence() {
		return sequence;
	}
	public ProductOptionVO setSequence(int sequence) {
		this.sequence = sequence;
		return this;
	}
	public int getPno() {
		return pno;
	}
	public ProductOptionVO setPno(int pno) {
		this.pno = pno;
		return this;
	}
	public String getOptioncolor() {
		return optioncolor;
	}
	public ProductOptionVO setOptioncolor(String optioncolor) {
		this.optioncolor = optioncolor;
		return this;
	}
	public String getOptionsize() {
		return optionsize;
	}
	public ProductOptionVO setOptionsize(String optionsize) {
		this.optionsize = optionsize;
		return this;
	}
	public int getInventory() {
		return inventory;
	}
	public ProductOptionVO setInventory(int inventory) {
		this.inventory = inventory;
		return this;
	}
	
	public String toString() {
		return "ProductOptionVO = [ono= "+ono+", sequence= "+sequence+", pno= "+pno+", option_color= "+optioncolor+", option_size= "+optionsize+", inventory= "+inventory+"]";
	}
}
