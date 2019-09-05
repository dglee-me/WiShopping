package com.lee.myapp.service;

import java.util.List;

import com.lee.myapp.domain.BoardVO;

public interface BoardService {
	public int write(BoardVO board) throws Exception;
	public List<BoardVO> list() throws Exception;
	public BoardVO read(int bno) throws Exception;
}