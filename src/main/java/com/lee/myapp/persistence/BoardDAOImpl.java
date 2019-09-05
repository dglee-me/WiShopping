package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	private static final String namespace = "boardMapper";
	
	@Inject
	SqlSession sqlSession;

	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".write",board);
	}

	@Override
	public List<BoardVO> list() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".list");
	}
	
	@Override
	public BoardVO read(int bno) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".read",bno);
	}
	
}