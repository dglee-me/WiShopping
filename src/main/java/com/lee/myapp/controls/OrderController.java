package com.lee.myapp.controls;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/order/")
public class OrderController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/pre_order", method=RequestMethod.GET)
	public String pre_orderGET() throws Exception{
		logger.info("-------- Order : PRE_ORDER METHOD=GET --------");
		
		return "/order/preorder";
	}
}
