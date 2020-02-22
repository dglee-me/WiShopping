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

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.service.BoardService;

@Controller
@RequestMapping("/notice/*")
public class ServiceController {
	private static final Logger logger = LoggerFactory.getLogger(ServiceController.class);
	
	@Inject
	BoardService boardService;
	
	@RequestMapping(value="/notice/modify", method=RequestMethod.GET)
	public void noticeModifyGET(Model model,int bno) throws Exception{
		logger.info("-------- Service : NOTICE MODIFY METHOD=GET --------");
		BoardVO board = boardService.view(bno);

		//Setting
		model.addAttribute("categories", boardService.categoryList());
		model.addAttribute("headerBanners", boardService.mainBannerList("헤더")); // Main banner list in this view
		
		model.addAttribute("board",board);
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