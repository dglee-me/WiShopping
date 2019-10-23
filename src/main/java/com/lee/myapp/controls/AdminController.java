package com.lee.myapp.controls;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.service.BoardService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	BoardService boardService;
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public void adminHome() throws Exception{
		logger.info("-------- ADMIN : ADMIN HOME METHOD=GET --------");
		
	}
	
	@RequestMapping(value="/admin/write", method=RequestMethod.GET)
	public void serviceWriteGet() throws Exception{
		logger.info("-------- Service : ADMIN WRITE METHOD=GET --------");
	}
	
	@RequestMapping(value="/admin/write", method=RequestMethod.POST)
	public String serviceWritePost(BoardVO board) throws Exception{
		logger.info("-------- Service : ADMIN WRITE METHOD=POST --------");

		boardService.write(board);		
		if(board.getCategory().equals("공지사항")) {
			return "redirect:/notice/list";
		}
		return "redirect:/";
	}
 }