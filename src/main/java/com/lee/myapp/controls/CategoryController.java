package com.lee.myapp.controls;

import java.util.ArrayList;

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
	public void fashionCategoryGET(Model model) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (FASHION) METHOD=GET --------");	
		
		model.addAttribute("list", productService.list("패션"));
	}
	
	@RequestMapping(value="/group/accessories", method=RequestMethod.GET)
	public void accessoriesCategoryGET(Model model) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (ACCESSORIES) METHOD=GET --------");	
		
		model.addAttribute("list", productService.list("잡화"));
	}
	
	@RequestMapping(value="/group/interior", method=RequestMethod.GET)
	public void interiorCategoryGET(Model model) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (INTERIOR) METHOD=GET --------");	
		
		model.addAttribute("list", productService.list("잡화"));
	}

	@RequestMapping(value="/group/digital", method=RequestMethod.GET)
	public void digitalCategoryGET(Model model) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (DIGITAL) METHOD=GET --------");	
		
		model.addAttribute("list", productService.list("잡화"));
	}
}