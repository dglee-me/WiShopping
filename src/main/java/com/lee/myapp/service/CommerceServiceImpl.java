package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.CommerceDAO;

@Service
public class CommerceServiceImpl implements CommerceService{

	@Inject
	CommerceDAO commerceDAO;

	@Override
	public List<ProductVO> bestList(String category) throws Exception {
		// TODO Auto-generated method stub
		return commerceDAO.bestList(category);
	}
}