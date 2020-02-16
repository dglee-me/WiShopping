package com.lee.myapp.controls;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.service.BrandsService;

@Controller
@RequestMapping("/brands/")
public class BrandsController {
	private static final Logger logger = LoggerFactory.getLogger(BrandsController.class);
	
	@Inject
	BrandsService brandsService;
	
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public void brandsHomeViewGET(HttpSession session, Model model, String query, String category1, String category2) throws Exception{
		logger.info("-------- BRANDS : HOME VIEW METHOD = GET --------");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("brand", query);
		map.put("category1", category1);
		map.put("category2", category2);
		
		List<CategoryVO> sub_category = new ArrayList<CategoryVO>();
		CategoryVO selected_sub_category = new CategoryVO();
		
		if(category1 != null) {
			sub_category = brandsService.subCategoryList(map);
		}
		if(category2 != null) {
			selected_sub_category = brandsService.selected_sub_category(map);
		}
				
		//Setting
		model.addAttribute("categories", brandsService.categoryList());
		
		model.addAttribute("category", brandsService.mainCategoryList(query));
		model.addAttribute("count", brandsService.brandProductListCount(map));
		model.addAttribute("products", brandsService.brandProductList(map));
		model.addAttribute("brandInfo", brandsService.brandInfo(query));
		
		//If category1 or category2 Used only if Category1 or Category2 is not empty
		model.addAttribute("sub_category", sub_category);
		model.addAttribute("selected_sub_category", selected_sub_category);
		
		model.addAttribute("headerBanners", brandsService.mainBannerList("헤더")); // Main banner list in this view
	}
}