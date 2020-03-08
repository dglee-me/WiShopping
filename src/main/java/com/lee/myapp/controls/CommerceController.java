package com.lee.myapp.controls;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.service.CommerceService;

@Controller
@RequestMapping("/commerce/")
public class CommerceController {
	private static final Logger logger = LoggerFactory.getLogger(CommerceController.class);
	
	@Inject
	CommerceService commerceService;
	
	@RequestMapping(value="/best/main", method=RequestMethod.GET)
	public void commerceBestGET(Model model,String category) throws Exception{
		logger.info("-------- COMMERCE : BEST MAIN METHOD=GET --------");
		
		if(category == null) category = "all";
		
		//Setting
		model.addAttribute("categories", commerceService.categoryList());
		model.addAttribute("headerBanners", commerceService.mainBannerList("헤더")); // Main banner list in this view
		
		model.addAttribute("best",commerceService.bestList(category));
	}
}