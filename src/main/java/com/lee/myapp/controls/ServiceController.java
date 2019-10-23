package com.lee.myapp.controls;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.service.BoardService;

@Controller
@RequestMapping("/notice/*")
public class ServiceController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	BoardService boardService;
	
	@RequestMapping(value="/notice/list", method=RequestMethod.GET)
	public void noticeMainGET(HttpServletRequest request) throws Exception{
		logger.info("-------- Service : NOTICE MAIN METHOD=GET --------");
		
		List<BoardVO> noticeList = new ArrayList<BoardVO>();
		noticeList = boardService.list("공지사항");
		
		request.setAttribute("noticeList", noticeList);
	}
	
	@RequestMapping(value="/notice/view", method=RequestMethod.GET)
	public void noticeViewGET(HttpServletRequest request, int bno) throws Exception{
		logger.info("-------- Service : NOTICE VIEW METHOD=GET --------");

		//Increase Views by 1 
		boardService.viewCount(bno);
		
		BoardVO board = boardService.view(bno);

		//Line change processing
		board.setContent("<p>"+board.getContent().replace("\r\n","</p><p>"));
		
		request.setAttribute("view",board);
	}
}