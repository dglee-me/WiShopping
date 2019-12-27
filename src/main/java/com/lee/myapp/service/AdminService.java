package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;

public interface AdminService {
	/* Notice */
	public int write(BoardVO board) throws Exception;
	
	/* Banner */
	public int bannerRegist(BannerVO banner) throws Exception;
	public List<BannerVO> bannerList() throws Exception;
}
