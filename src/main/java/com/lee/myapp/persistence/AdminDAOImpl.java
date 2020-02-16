package com.lee.myapp.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;

@Repository
public class AdminDAOImpl implements AdminDAO{
	private static final String namespace = "adminMapper";
	
	@Inject
	SqlSession sqlSession;

	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".write",board);
	}

	@Override
	public int bannerRegist(BannerVO banner) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".bannerRegist",banner);
	}

	@Override
	public List<BannerVO> bannerList(String parameter) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".bannerList",parameter);
	}

	@Override
	public int bannerStatusUpdate(HashMap<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".updateStatus",map);
	}

	@Override
	public BannerVO bannerView(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".bannerView",bno);
	}

	@Override
	public int bannerUpdate(BannerVO banner) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".bannerUpdate",banner);
	}

	@Override
	public int bannerDelete(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".bannerDelete",bno);
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
