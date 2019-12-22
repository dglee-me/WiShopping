package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.HomeDAO;

@Service
public class HomeServiceImpl implements HomeService{

	@Inject
	HomeDAO homeDAO;
	
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

}
