package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;

public interface AdminDAO {
	/* Notice */
	public int write(BoardVO board) throws Exception;
	
	/* Banner */
	public int bannerRegist(BannerVO banner) throws Exception;
	public List<BannerVO> bannerList(String parameter) throws Exception;
	public int bannerStatusUpdate(BannerVO banner) throws Exception;
	public BannerVO bannerView(int bno) throws Exception;
	public int bannerUpdate(BannerVO banner) throws Exception;
	public int bannerDelete(int bno) throws Exception;

	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}