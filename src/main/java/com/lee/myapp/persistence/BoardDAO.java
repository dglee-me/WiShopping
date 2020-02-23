package com.lee.myapp.persistence;

import com.lee.myapp.domain.BoardVO;

public interface BoardDAO {
	public int write(BoardVO board) throws Exception;
}
