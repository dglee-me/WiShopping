package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.BoardVO;

public interface BoardService {
	public int write(BoardVO board) throws Exception;
	public List<BoardVO> list(String cons) throws Exception;
	public BoardVO view(int bno) throws Exception;
	public void viewCount(int bno) throws Exception;
}