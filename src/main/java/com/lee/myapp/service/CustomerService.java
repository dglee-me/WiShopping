package com.lee.myapp.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.FaqVO;
import com.lee.myapp.domain.QuestionsVO;

public interface CustomerService {
	public String imageUpload(MultipartFile[] images) throws Exception;
	
	public void questionRegist(QuestionsVO question, MultipartFile[] images) throws Exception;

	//Notice list query
	public int listCount(String category) throws Exception;
	public List<BoardVO> listPaging(CommentCriteria cri) throws Exception;

	//Notice write query
	public int write(BoardVO board) throws Exception;
	
	//Notice view query
	public BoardVO view(int bno) throws Exception;
	public void viewCount(int bno) throws Exception;

	//Notice delete query
	public void delete(int bno) throws Exception;

	//Notice modify query
	public void modify(BoardVO board) throws Exception;

	//FAQ query
	public List<FaqVO> listFAQ(String order) throws Exception;
	
	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}