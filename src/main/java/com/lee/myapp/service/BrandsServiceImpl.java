package com.lee.myapp.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.persistence.BrandsDAO;

@Service
public class BrandsServiceImpl implements BrandsService {
		@Inject
		BrandsDAO brandsDAO;

		@Override
		public List<CategoryVO> mainCategoryList(String brand) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.mainCategoryList(brand);
		}

		@Override
		public List<CategoryVO> subCategoryList(HashMap<String, Object> map) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.subCategoryList(map);
		}

		@Override
		public CategoryVO selected_sub_category(HashMap<String, Object> map) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.selected_sub_category(map);
		}

		@Override
		public List<ProductVO> brandProductList(HashMap<String, Object> map) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.brandProductList(map);
		}

		@Override
		public int brandProductListCount(HashMap<String, Object> map) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.brandProductListCount(map);
		}

		@Override
		public String brandInfo(String brand) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.brandInfo(brand);
		}

		//Header category list
		@Override
		public List<CategoryVO> categoryList() throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.categoryList();
		}
		
		//Header banner
		@Override
		public List<BannerVO> mainBannerList(String area) throws Exception {
			// TODO Auto-generated method stub
			return brandsDAO.mainBannerList(area);
		}
}
