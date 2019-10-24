package com.lee.myapp.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.Criteria;
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

	@Override
	public BoardVO view(int bno) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.view(bno);
	}

	@Override
	public void viewCount(int bno) throws Exception {
		// TODO Auto-generated method stub
		boardDao.viewCount(bno);
	}

	@Override
	public int listCount(String category) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.listCount(category);
	}

	@Override
	public List<BoardVO> listPaging(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.listPaging(cri);
	}

	@Override
	public int modify(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.modify(board);
	}

	@Override
	public int delete(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.delete(map);
	}

}
