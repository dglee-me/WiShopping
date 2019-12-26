package com.lee.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.persistence.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Inject
	AdminDAO adminDAO;
	
	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.write(board);
	}

	@Override
	public int bannerRegist(BannerVO banner) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerRegist(banner);
	}
}