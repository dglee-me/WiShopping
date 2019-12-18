package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.SearchDAO;

@Service
public class SearchServiceImpl implements SearchService{
	@Inject
	SearchDAO searchDAO;
	
	@Override
	public List<ProductVO> searchProductList(String query) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.searchProductList(query);
	}

	@Override
	public int countResult(String query) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.countResult(query);
	}

	@Override
	public String isBrand(String query) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.isBrand(query);
	}

}
