package com.lee.myapp.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.domain.PurchaseVO;

@Repository
public class PurchaseDAOImpl implements PurchaseDAO {
	private static final String namespace = "purchaseMapper";
	
	@Inject
	SqlSession sqlSession;

	@Override
	public List<PurchaseVO> purchaseStatusList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".purchaseStatusList", map);
	}
	
	@Override
	public List<PurchaseVO> purchaseList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".purchaseList", map);
	}

	@Override
	public List<OrderVO> ordernoList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".ordernoList", map);
	}

	@Override
	public OrderVO viewOrderNo(String orderno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".viewOrderNo",orderno);
	}
	
	@Override
	public List<PurchaseVO> viewOrder(String orderno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".viewOrder",orderno);
	}

	//Header category list
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
