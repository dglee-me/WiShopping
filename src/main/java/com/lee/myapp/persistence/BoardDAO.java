package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.Criteria;

public interface BoardDAO {
	public int write(BoardVO board) throws Exception;
	public BoardVO view(int bno) throws Exception;
	public void viewCount(int bno) throws Exception;
	public int modify(BoardVO board) throws Exception;
	
	public int listCount(String category) throws Exception;
	public List<BoardVO> listPaging(Criteria cri) throws Exception;
}
