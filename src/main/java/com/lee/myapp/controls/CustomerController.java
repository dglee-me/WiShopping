package com.lee.myapp.controls;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.CommentPageMaker;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.QuestionsVO;
import com.lee.myapp.service.CustomerService;
import com.lee.myapp.utils.UploadFileUtils;

@Controller
@RequestMapping("/customer/")
public class CustomerController {
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	CustomerService customerService;
	
	@RequestMapping(value="/notice", method=RequestMethod.GET)
	public String customerCenterMainGET(HttpSession session, Model model, CommentCriteria cri) throws Exception{
		logger.info("-------- CUSTOMER : NOTICE METHOD = GET --------");

		//Setting criteria vo
		cri.setPerPageNum(10);
		cri.setCategory("1");
		
		CommentPageMaker pageMaker = new CommentPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(customerService.listCount("1"));
		
		//Setting
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("noticeList", customerService.listPaging(cri));

		model.addAttribute("categories", customerService.categoryList());
		model.addAttribute("headerBanners", customerService.mainBannerList("헤더")); // Main banner list in this view
		
		return "/customer/notice/main";
	}

	@ResponseBody
	@RequestMapping(value="noticeListUpdate", method=RequestMethod.POST)
	public List<BoardVO> customerCenterNoticeListUpdatePOST(CommentCriteria cri) throws Exception{
		logger.info("-------- CUSTOMER : NOTICE UPDATE METHOD = POST --------");
		logger.info("-------- CRITERIA INFO = " + cri.toString() + " --------");

		//Setting criteria vo
		cri.setCategory("1");		
		cri.setPerPageNum(10);
		
		return customerService.listPaging(cri);
	}

	@ResponseBody
	@RequestMapping(value="noticeListCount", method=RequestMethod.POST)
	public int customerCenterNoticeListCountPOST() throws Exception{
		logger.info("-------- CUSTOMER : NOTICE UPDATE METHOD = POST --------");
		
		return customerService.listCount("1");
	}
	
	@RequestMapping(value="/notice/{bno:.+}", method=RequestMethod.GET)
	public String noticeViewGET(Model model, @PathVariable("bno") int bno) throws Exception{
		logger.info("-------- CUSTOMER : NOTICE VIEW METHOD = GET --------");

		//Increase Views by 1 
		customerService.viewCount(bno);
		
		BoardVO board = customerService.view(bno);

		//Line change processing
		if(board.getContent().contains("\r\n")) {
			board.setContent("<p>"+board.getContent().replace("\r\n","</p><p>"));
		}else {
			board.setContent("<p>"+board.getContent()+"</p>");
		}
		
		//Setting
		model.addAttribute("board",board);
		
		model.addAttribute("categories", customerService.categoryList());
		model.addAttribute("headerBanners", customerService.mainBannerList("헤더")); // Main banner list in this view
		
		return "/customer/notice/view";
	}

	@RequestMapping(value="/notice/write", method=RequestMethod.GET)
	public String noticeWriteGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- CUSTOMER : NOTICE WRITE METHOD = GET --------");

		String path = "";
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			//Setting
			model.addAttribute("categories", customerService.categoryList());
			model.addAttribute("headerBanners", customerService.mainBannerList("헤더")); // Main banner list in this view
			
			path = "/customer/notice/write";
		}else {
			path = "/";
		}
		
		return path;
	}
		
	@RequestMapping(value="/notice/write", method=RequestMethod.POST)
	public String noticeWritePOST(HttpSession session, Model model, BoardVO board) throws Exception{
		logger.info("-------- CUSTOMER : NOTICE WRITE METHOD = POST --------");

		String path = "";
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member.getMlevel() == 2) {
			customerService.write(board.setCategory("공지사항").setAuthor(member.getName()));
			
			path = "redirect:/customer/notice/";
		}else {
			path = "/";
		}
		
		return path;
	}
	
	@RequestMapping(value="/notice/delete/{bno:.+}", method=RequestMethod.GET)
	public String noticeDeleteGET(HttpSession session, @PathVariable("bno") int bno) throws Exception{
		logger.info("-------- CUSTOMER : NOTICE DELETE METHOD = GET --------");
		
		String path = "";
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			customerService.delete(bno);
			
			path = "redirect:/customer/notice";
		}else {
			path = "/auth/login";
		}
		
		return path;
	}

	@RequestMapping(value="/notice/modify/{bno:.+}", method=RequestMethod.GET)
	public String noticeModifyGET(HttpSession session, Model model, @PathVariable("bno") int bno) throws Exception{
		logger.info("-------- CUSTOMER : NOTICE MODIFY METHOD = GET --------");

		BoardVO board = customerService.view(bno);

		//Setting
		model.addAttribute("board",board);
		
		model.addAttribute("categories", customerService.categoryList());
		model.addAttribute("headerBanners", customerService.mainBannerList("헤더")); // Main banner list in this view
		
		return "/customer/notice/modify";
	}

	@RequestMapping(value="/notice/modify/{bno:.+}", method=RequestMethod.POST)
	public String noticeModifyPOST(HttpSession session, Model model, @PathVariable("bno") int bno, BoardVO board) throws Exception{
		SimpleDateFormat dateFormat = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss", Locale.KOREA);

		logger.info("-------- CUSTOMER : NOTICE MODIFY METHOD = POST --------");
		logger.info("-------- MODIFY DATE = "+dateFormat.format(new Date())+" --------");

		customerService.modify(board);

		return "redirect:/customer/notice/";
	}
	
	@RequestMapping(value="/questions", method=RequestMethod.GET)
	public String customerQuestionsGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- CUSTOMER : QUESTIONS METHOD = GET --------");
		
		String path = "";
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			path = "/customer/questions";

			model.addAttribute("categories", customerService.categoryList());
			model.addAttribute("headerBanners", customerService.mainBannerList("헤더")); // Main banner list in this view
		}else {
			path = "/auth/login";
		}
		
		return path;
	}
	
	@RequestMapping(value="/questions", method=RequestMethod.POST)
	public String customerQuestionsPOST(HttpSession session, QuestionsVO question, @RequestParam(value="question[images_url]") MultipartFile[] images) throws Exception{
		logger.info("-------- CUSTOMER : QUESTIONS METHOD = POST --------");
		
		String path = "";
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			
			String url = "";
			for(int i=0;i<images.length;i++) {
				if(images[i].getOriginalFilename().equals("")) continue;
				
				if(i == 0) {
					url = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
					continue;
				}
				url = url + ";" + "/" + "imgUpload" + ymdPath + "/" +UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
			}

			question.setMno(member.getMno());
			question.setImagesurl(url);
			
			customerService.questionRegist(question);
			
			path = "/customer/notice";
		}else {
			path = "/auth/login";
		}
		
		return path;
	}
	
	@RequestMapping(value="/faq", method=RequestMethod.GET)
	public void customerFaqGET(HttpSession session, Model model, String order) throws Exception{
		logger.info("-------- CUSTOMER : FAQ METHOD = POST --------");

		//Settings
		model.addAttribute("list", customerService.listFAQ(order));
		model.addAttribute("categories", customerService.categoryList());
		model.addAttribute("headerBanners", customerService.mainBannerList("헤더")); // Main banner list in this view
	}
}