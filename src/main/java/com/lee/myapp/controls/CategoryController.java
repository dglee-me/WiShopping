package com.lee.myapp.controls;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.service.ProductService;

@Controller
@RequestMapping("/category/")
public class CategoryController {
	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	@Inject
	ProductService productService;

	@RequestMapping(value="/group/list", method=RequestMethod.GET)
	public void fashionCategoryGET(Model model,ProductVO product) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (FASHION) METHOD=GET --------");	

		CategoryVO sub_category2 = new CategoryVO();
		
		if(product.getCategory2() != null) {
			sub_category2 = productService.selectSubCategory(product);
		}
		
		//Setting
		model.addAttribute("categories", productService.selectCategoryList(product.getCategory1())); // Header area categories settings
		model.addAttribute("sub_categories", productService.subCategoryList(product.getCategory1())); // Main side-bar area sub categories settings
		model.addAttribute("list", productService.list(product));
		model.addAttribute("sub_category2", sub_category2);

		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
	}
}