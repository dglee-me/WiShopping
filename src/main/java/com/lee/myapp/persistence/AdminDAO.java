package com.lee.myapp.persistence;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;

public interface AdminDAO {
	public int write(BoardVO board) throws Exception;
	public int bannerRegist(BannerVO banner) throws Exception;
}