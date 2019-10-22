package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.BoardVO;

public interface BoardDAO {
	public int write(BoardVO board) throws Exception;
	public List<BoardVO> list(String cons) throws Exception;
	public BoardVO view(int bno) throws Exception;
}
