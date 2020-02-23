package com.lee.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDAO boardDao;
	
	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.write(board);
	}
}
