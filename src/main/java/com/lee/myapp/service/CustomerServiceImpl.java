package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.FaqVO;
import com.lee.myapp.domain.QuestionsVO;
import com.lee.myapp.persistence.CustomerDAO;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Inject
	CustomerDAO customerDAO;
	
	//Questions query
	@Override
	public void questionRegist(QuestionsVO question) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.questionRegist(question);
	}

	//Notice list query
	@Override
	public int listCount(String category) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.listCount(category);
	}

	@Override
	public List<BoardVO> listPaging(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.listPaging(cri);
	}

	//Notice write query
	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.write(board);
	}

	//Notice view query
	@Override
	public BoardVO view(int bno) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.view(bno);
	}

	@Override
	public void viewCount(int bno) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.viewCount(bno);
	}

	//Notice delete query
	@Override
	public void delete(int bno) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.delete(bno);
	}

	//Notice modify query
	@Override
	public void modify(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.modify(board);
	}

	@Override
	public List<FaqVO> listFAQ(String order) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.listFAQ(order);
	}

	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.categoryList();
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.mainBannerList(area);
	}
}