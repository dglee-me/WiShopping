package com.lee.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.BrandsDAO;

@Service
public class BrandsServiceImpl implements BrandsService {
		@Inject
		BrandsDAO brandsDAO;

		@Override
		public List<String> categoryList(String brand) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.categoryList(brand);
		}

		@Override
		public List<ProductVO> brandProductList(String brand) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.brandProductList(brand);
		}
		
		//Header banner
		@Override
		public List<BannerVO> mainBannerList(String area) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.mainBannerList(area);
		}
}
