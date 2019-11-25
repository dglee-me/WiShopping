package com.lee.myapp.controls;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.Criteria;
import com.lee.myapp.domain.PageMaker;
import com.lee.myapp.service.BoardService;

@Controller
@RequestMapping("/notice/*")
public class ServiceController {
	private static final Logger logger = LoggerFactory.getLogger(ServiceController.class);
	
	@Inject
	BoardService boardService;
	
	@RequestMapping(value="/notice/list", method=RequestMethod.GET)
	public void noticeMainGET(HttpServletRequest request, Criteria cri) throws Exception{
		logger.info("-------- Service : NOTICE MAIN METHOD=GET --------");
		
		List<BoardVO> noticeList = new ArrayList<BoardVO>();
		cri.setCategory("공지사항");
		noticeList = boardService.listPaging(cri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.listCount("공지사항"));
		
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("noticeList", noticeList);
	}
	
	@RequestMapping(value="/notice/view", method=RequestMethod.GET)
	public void noticeViewGET(HttpServletRequest request, int bno) throws Exception{
		logger.info("-------- Service : NOTICE VIEW METHOD=GET --------");

		//Increase Views by 1 
		boardService.viewCount(bno);
		
		BoardVO board = boardService.view(bno);

		//Line change processing
		if(board.getContent().contains("\r\n")) {
			board.setContent("<p>"+board.getContent().replace("\r\n","</p><p>"));
		}else {
			board.setContent("<p>"+board.getContent()+"</P>");
		}
		
		request.setAttribute("view",board);
	}
	
	@RequestMapping(value="/notice/modify", method=RequestMethod.GET)
	public void noticeModifyGET(HttpServletRequest request,int bno) throws Exception{
		logger.info("-------- Service : NOTICE MODIFY METHOD=GET --------");
		BoardVO board = boardService.view(bno);
		
		request.setAttribute("board",board);
	}
	
	@RequestMapping(value="/notice/modify", method=RequestMethod.POST)
	public String noticeModifyPOST(BoardVO board) throws Exception{
		logger.info("-------- Service : NOTICE MODIFY METHOD=POST --------");
		
		boardService.modify(board);
		
		return "redirect:/notice/view?bno="+board.getBno();
	}
	
	@RequestMapping(value="/notice/delete", method=RequestMethod.GET)
	public String noticeDeleteGET(String category, int bno) throws Exception{
		logger.info("-------- Service : NOTICE DELETE METHOD=GET --------");
		
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("category", category);
		map.put("bno", bno);
		
		boardService.delete(map);
		
		return "redirect:/notice/list";
	}
}