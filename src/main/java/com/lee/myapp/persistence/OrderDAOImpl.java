package com.lee.myapp.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO{
	private static final String namespace = "orderMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<OrderListVO> cartToOrderList(Map<String,Object> map) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".cartToOrderList",map);
	}

	@Override
	public OrderListVO productToOrderList(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".productToOrderList",map);
	}
	
	@Override
	public void orderInfo(OrderVO order) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".orderInfo",order);
	}

	@Override
	public int cart_orderInfo_detail(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".cart_orderInfo_detail",map);
	}

	@Override
	public int product_orderInfo_detail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".product_orderInfo_detail",map);
	}

	@Override
	public void cartDelete(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+".cartDelete",map);
	}

	@Override
	public void updateInventory(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".updateInventory",map);
	}

	@Override
	public int checkInventory(String ono) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".checkInventory",ono);
	}

	@Override
	public int cartCheckInventory(String cartno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".cartCheckInventory",cartno);
	}

	@Override
	public int cartUpdateSalesVolume(String cartno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".cartUpdateSalesVolume", cartno);
	}

	@Override
	public int productToUpdateSalesVolume(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".productToUpdateSalesVolume", map);
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".mainBannerList",area);
	}
}