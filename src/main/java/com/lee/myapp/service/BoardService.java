package com.lee.myapp.service;

import com.lee.myapp.domain.BoardVO;

public interface BoardService {
	public int write(BoardVO board) throws Exception;
}