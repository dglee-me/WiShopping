package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.QuestionsVO;
import com.lee.myapp.persistence.CustomerDAO;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Inject
	CustomerDAO customerDAO;
	
	@Override
	public void questionRegist(QuestionsVO question) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.questionRegist(question);
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.mainBannerList(area);
	}
}