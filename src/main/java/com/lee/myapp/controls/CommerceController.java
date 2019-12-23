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
		
		if(category.equals("1")) {
			category = "�м�";
		}else if(category.equals("2")) {
			category = "��ȭ";
		}else if(category.equals("3")) {
			category = "���׸���";
		}else if(category.equals("4")) {
			category = "������������";
		}
		
		model.addAttribute("best",commerceService.bestList(category));
	}
}