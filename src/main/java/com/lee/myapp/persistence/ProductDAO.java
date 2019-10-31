package com.lee.myapp.persistence;

import com.lee.myapp.domain.ProductVO;

public interface ProductDAO {
	public int register(ProductVO pd) throws Exception;
}
