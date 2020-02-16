package com.lee.myapp.controls;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.service.HomeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	HomeService homeService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception{
		logger.info("Welcome home! The client locale is {}.", locale);
		
		//Setting
		model.addAttribute("categories", homeService.categoryList());
		
		model.addAttribute("allBest", homeService.selectAllBest()); // Best product list in home view
		model.addAttribute("mainBanners", homeService.mainBannerList("메인상단")); // Main banner list in home view
		
		model.addAttribute("headerBanners", homeService.mainBannerList("헤더")); // Main banner list in this view
		
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public List<ProductVO> homePOST(String data, Model model) throws Exception{
		logger.info("-------- HOME : HOME METHOD=POST --------");

		List<ProductVO> best = new ArrayList<ProductVO>();
		
		if(data.equals("전체")) {
			best = homeService.selectAllBest();
		}else {
			best = homeService.selectBest(data);
		}
		
		return best;
	}

	@RequestMapping(value="/error", method=RequestMethod.GET)
	public void error() throws Exception{
		
	}
}
