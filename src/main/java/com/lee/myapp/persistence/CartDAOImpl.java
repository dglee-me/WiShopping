package com.lee.myapp.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;

@Repository
public class CartDAOImpl  implements CartDAO {
	private static final String namespace = "cartMapper";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public void addCart(CartVO cart) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".addCart",cart);
	}

	@Override
	public List<CartListVO> cartList(int mno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".cartList",mno);
	}

	@Override
	public int cartRemove(int pno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".cartRemove",pno);
	}

}
