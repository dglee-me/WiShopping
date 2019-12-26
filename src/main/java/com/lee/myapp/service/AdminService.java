package com.lee.myapp.service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;

public interface AdminService {
	public int write(BoardVO board) throws Exception;
	public int bannerRegist(BannerVO banner) throws Exception;
}
