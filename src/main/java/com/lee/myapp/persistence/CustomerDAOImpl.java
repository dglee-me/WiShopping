package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.FaqVO;
import com.lee.myapp.domain.QuestionsVO;

@Repository
public class CustomerDAOImpl implements CustomerDAO{
	private static final String namespace = "customerMapper";

	@Inject
	SqlSession sqlSession;

	//Questions query
	@Override
	public void questionRegist(QuestionsVO question) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".questionRegist", question);
	}

	//Notice list query
	@Override
	public int listCount(String category) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".listCount", category);
	}

	@Override
	public List<BoardVO> listPaging(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".listPaging", cri);
	}

	//Notice write query
	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".write", board);
	}
	
	//Notice view query
	@Override
	public BoardVO view(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".view", bno);
	}

	@Override
	public void viewCount(int bno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".viewCount", bno);
	}

	//Notice delete query
	@Override
	public void delete(int bno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+".delete", bno);
	}

	//Notice modify query
	@Override
	public void modify(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".modify", board);
	}

	@Override
	public List<FaqVO> listFAQ(String order) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".listFAQ", order);
	}

	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".categoryList");
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList",area);
	}
}