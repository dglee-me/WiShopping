package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;

public interface ProductDAO {
	public int register(ProductVO product) throws Exception;
	public int register_option(ProductOptionVO option) throws Exception;
	public List<ProductVO> list(String category) throws Exception;
	public ProductVO view(int pno) throws Exception;
	public List<ProductOptionVO> view_option(int pno) throws Exception;
}