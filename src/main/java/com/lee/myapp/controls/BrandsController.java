package com.lee.myapp.controls;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.service.BrandsService;

@Controller
@RequestMapping("/brands/")
public class BrandsController {
	private static final Logger logger = LoggerFactory.getLogger(BrandsController.class);
	
	@Inject
	BrandsService brandsService;
	
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public void brandsHomeViewGET(HttpSession session, Model model, String query) throws Exception{
		logger.info("-------- BRANDS : HOME VIEW METHOD = GET --------");

		//Setting
		model.addAttribute("category", brandsService.categoryList(query));
		model.addAttribute("products", brandsService.brandProductList(query));
		
		model.addAttribute("headerBanners", brandsService.mainBannerList("헤더")); // Main banner list in this view
	}
}