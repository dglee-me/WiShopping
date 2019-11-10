package com.lee.myapp.controls;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.service.ProductService;

@Controller
@RequestMapping("/category/")
public class CategoryController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	ProductService productService;

	@RequestMapping(value="/group/fashion", method=RequestMethod.GET)
	public void fashionCategoryGET(HttpServletRequest request) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (FASHION) METHOD=GET --------");	
		
		request.setAttribute("list", productService.list("패션"));
	}
	
	@RequestMapping(value="/group/accessories", method=RequestMethod.GET)
	public void accessoriesCategoryGET(HttpServletRequest request) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (ACCESSORIES) METHOD=GET --------");	
		
		request.setAttribute("list", productService.list("잡화"));
	}
}