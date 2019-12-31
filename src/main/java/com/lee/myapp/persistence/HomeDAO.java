package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.ProductVO;

public interface HomeDAO {
	public List<ProductVO> selectAllBest() throws Exception;
	public List<ProductVO> selectBest(String data) throws Exception;
	public List<BannerVO> mainBannerList(String area) throws Exception;
}