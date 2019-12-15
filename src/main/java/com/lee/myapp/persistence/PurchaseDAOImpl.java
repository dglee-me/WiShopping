package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.domain.PurchaseVO;

@Repository
public class PurchaseDAOImpl implements PurchaseDAO {
	private static final String namespace = "purchaseMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<PurchaseVO> purchaseList(int mno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".purchaseList",mno);
	}

	@Override
	public List<OrderVO> ordernoList(int mno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".ordernoList",mno);
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
}
