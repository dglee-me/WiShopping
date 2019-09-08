package com.lee.myapp.controls;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public void adminHome() throws Exception{
		logger.info("-------- ADMIN : ADMIN HOME METHOD=GET --------");
		
	}
}
