package com.lee.myapp.controls;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.service.SearchService;

@Controller
@RequestMapping("/search/")
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Inject
	SearchService searchService;
	
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public void searchIndexGET(String query, String delivery_free, String min, String max, String order, Model model) throws Exception{
		logger.info("-------- SEARCH : INDEX METHOD=GET --------");
		
		if(!query.equals("")) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("query", query);			
			map.put("delivery_free", delivery_free);
			map.put("min", min);
			map.put("max", max);
			map.put("order", order);
			
			if(delivery_free != null) {
				model.addAttribute("delivery_free", "not null");
			}
			
			if(min != null || max != null) {
				String price = "";
				if(max != null && min != null){
					price = min+"원 ~ "+max+"원";
				}else if(min != null) {
					price = min+"원";
				}else if(max != null) {
					price = max+"원";
				}
				
				model.addAttribute("price", price);
			}
			
			//Add attribute
			model.addAttribute("categories", searchService.categoryList());
			model.addAttribute("headerBanners", searchService.mainBannerList("헤더")); // Main banner list in this view
			
			model.addAttribute("parameter",query);
			model.addAttribute("count",searchService.countResult(map));
			model.addAttribute("items",searchService.searchProductList(map));
		}
	}	
}