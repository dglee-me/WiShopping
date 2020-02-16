package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.HomeDAO;

@Service
public class HomeServiceImpl implements HomeService{

	@Inject
	HomeDAO homeDAO;

	//Category list select query
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return homeDAO.categoryList();
	}

	//Best productions select query
	@Override
	public List<ProductVO> selectAllBest() throws Exception {
		// TODO Auto-generated method stub
		return homeDAO.selectAllBest();
	}

	@Override
	public List<ProductVO> selectBest(String data) throws Exception {
		// TODO Auto-generated method stub
		return homeDAO.selectBest(data);
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return homeDAO.mainBannerList(area);
	}
}
