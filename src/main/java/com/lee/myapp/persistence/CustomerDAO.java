package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.QuestionsVO;

public interface CustomerDAO {
	//Questions query
	public void questionRegist(QuestionsVO question) throws Exception;

	//Notice list query
	public int listCount(String category) throws Exception;
	public List<BoardVO> listPaging(CommentCriteria cri) throws Exception;
	
	//Notice view query
	public BoardVO view(int bno) throws Exception;
	public void viewCount(int bno) throws Exception;

	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}