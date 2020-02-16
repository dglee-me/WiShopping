package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.Criteria;

public interface BoardService {
	public int write(BoardVO board) throws Exception;
	public BoardVO view(int bno) throws Exception;
	public void viewCount(int bno) throws Exception;
	public int modify(BoardVO board) throws Exception;
	public int delete(Map<String,Object> map) throws Exception;

	public int listCount(String category) throws Exception;
	public List<BoardVO> listPaging(Criteria cri) throws Exception;

	//Header category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}