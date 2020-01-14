package com.lee.myapp.controls;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.service.ProductService;

@Controller
@RequestMapping("/category/")
public class CategoryController {
	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	@Inject
	ProductService productService;

	@RequestMapping(value="/group/fashion", method=RequestMethod.GET)
	public void fashionCategoryGET(Model model, ProductVO product) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (FASHION) METHOD=GET --------");	

		product.setCategory1("패션");
		
		//Setting
		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
		model.addAttribute("list", productService.list(product));
	}
	
	@RequestMapping(value="/group/accessories", method=RequestMethod.GET)
	public void accessoriesCategoryGET(Model model, ProductVO product) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (ACCESSORIES) METHOD=GET --------");	

		product.setCategory1("잡화");
		
		//Setting
		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
		model.addAttribute("list", productService.list(product));
	}
	
	@RequestMapping(value="/group/interior", method=RequestMethod.GET)
	public void interiorCategoryGET(Model model, ProductVO product) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (INTERIOR) METHOD=GET --------");	

		product.setCategory1("인테리어");
		
		//Setting
		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
		model.addAttribute("list", productService.list(product));
	}

	@RequestMapping(value="/group/digital", method=RequestMethod.GET)
	public void digitalCategoryGET(Model model, ProductVO product) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (DIGITAL) METHOD=GET --------");	

		product.setCategory1("가전·디지털");
		
		//Setting
		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
		model.addAttribute("list", productService.list(product));
	}
}