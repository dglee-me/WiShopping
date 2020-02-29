package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.SearchDAO;

@Service
public class SearchServiceImpl implements SearchService{
	@Inject
	SearchDAO searchDAO;
	
	@Override
	public List<ProductVO> searchProductList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.searchProductList(map);
	}

	@Override
	public int countResult(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.countResult(map);
	}

	@Override
	public String isBrand(String query) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.isBrand(query);
	}

	//Header part
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.categoryList();
	}

	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.mainBannerList(area);
	}

}
