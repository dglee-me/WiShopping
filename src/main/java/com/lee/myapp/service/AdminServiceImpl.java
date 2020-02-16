package com.lee.myapp.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
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

	@Override
	public List<BannerVO> bannerList(String parameter) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerList(parameter);
	}

	@Override
	public int bannerStatusUpdate(HashMap<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerStatusUpdate(map);
	}

	@Override
	public BannerVO bannerView(int bno) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerView(bno);
	}

	@Override
	public int bannerUpdate(BannerVO banner) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerUpdate(banner);
	}

	@Override
	public int bannerDelete(int bno) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerDelete(bno);
	}

	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.categoryList();
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.mainBannerList(area);
	}
}