package com.lee.myapp.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.Criteria;

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
	public BoardVO view(int bno) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".view",bno);
	}

	@Override
	public void viewCount(int bno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".viewCount",bno);
	}

	@Override
	public int listCount(String category) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".listCount",category);
	}

	@Override
	public List<BoardVO> listPaging(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".listPaging",cri);
	}

	@Override
	public int modify(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".modify",board);
	}

	@Override
	public int delete(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".delete",map);
	}
	
}