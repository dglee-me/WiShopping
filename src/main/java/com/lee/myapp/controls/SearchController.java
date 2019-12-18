package com.lee.myapp.controls;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

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
	public void searchIndexGET(String query, Model model) throws Exception{
		logger.info("-------- SEARCH : INDEX METHOD=GET --------");
		
		if(!query.equals("")) {
			//If query equal brand name
			String brand = searchService.isBrand(query);
			if(query.equals(brand)) {
				model.addAttribute("brand",brand);
			}
			
			//Add attribute
			model.addAttribute("parameter",query);
			model.addAttribute("count",searchService.countResult(query));
			model.addAttribute("items",searchService.searchProductList(query));
		}
	}	
}