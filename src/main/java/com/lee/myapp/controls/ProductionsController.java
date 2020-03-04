package com.lee.myapp.controls;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

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

import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.CommentPageMaker;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductQuestionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.domain.ReviewLikeVO;
import com.lee.myapp.domain.ReviewVO;
import com.lee.myapp.service.ProductService;
import com.lee.myapp.utils.FileDelete;
import com.lee.myapp.utils.UploadFileUtils;

@Controller
@RequestMapping("/productions/")
public class ProductionsController {
	private static final Logger logger = LoggerFactory.getLogger(ProductionsController.class);
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	ProductService productService;
	
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public String productionRegistGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- CREATE : PRODUCTIONS METHOD=GET --------");
		
		String path = "redirect:/auth/login";
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		if(member != null) {
			int seller = productService.isSeller(member.getMno());
			
			if(seller == 0) {
				path = "redirect:/auth/notseller";
			}else {
				//Setting
				model.addAttribute("categories", productService.categoryList());
				model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
				
				path = "/productions/regist";
			}
		}
		
		return path;
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String productionRegistPOST(@RequestParam("product_thumurl") MultipartFile file1, @RequestParam("product_url") MultipartFile[] file2,
			ProductVO product, char has_option, ProductOptionVO option, int[] inventory,HttpSession session) throws Exception{
		logger.info("-------- CREATE : PRODUCTIONS METHOD=POST --------");
		logger.info("-------- SELLER : "+((MemberVO)session.getAttribute("login")).getName()+" --------");
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String thumbUrl = null;
		
		//Thumbnail image upload to server
		thumbUrl = UploadFileUtils.fileUpload(imgUploadPath, file1.getOriginalFilename(), file1.getBytes(), ymdPath);
		product.setProductthumurl("/" + "imgUpload" + ymdPath + "/" + thumbUrl);	
			
		//Detail images upload to server
		String detailUrl = "";
		
		for(int i=0;i<file2.length-1;i++) {
			if(i == 0) {
				detailUrl = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
				continue;
			}
			detailUrl = detailUrl + ";"+ "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
		}
		
		product.setProducturl(detailUrl);
				
		//Insert product into database
		product.setMno(((MemberVO)session.getAttribute("login")).getMno());
		productService.register(product);
		
		//Create options for a product and insert into database
		if(has_option == 'T') {
			int inventory_count = 0;
			String[] array_option = option.getOptioncolor().split(",");

			for(int i=0;i<array_option.length;i++) {
				String[] temp = array_option[i].split("\\#\\$\\%");
				
				option.setOptioncolor(temp[0])
					.setOptionsize(temp[1])
					.setInventory(inventory[inventory_count++]);

				productService.register_option(option);
			}
		}else {
			productService.register_option(option);
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/{pno:.+}", method=RequestMethod.GET)
	public String productionViewGET(HttpSession session, Model model, @PathVariable("pno") int pno) throws Exception{
		logger.info("-------- VIEW : PRODUCTIONS METHOD=GET --------");

		CommentCriteria cri = new CommentCriteria().setPno(pno);
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		ProductVO product = new ProductVO();
		
		CommentPageMaker pageMaker = new CommentPageMaker();
		pageMaker.setCri(cri);
		int count = productService.listCount(cri.getPno());
		pageMaker.setTotalCount(count);

		//Check member login when review paging and question paging
		List<ReviewVO> reviewlist = new ArrayList<ReviewVO>();
		List<ProductQuestionVO> question_list = new ArrayList<ProductQuestionVO>();
		
		if(member != null) {
			reviewlist = productService.listPaging(cri.setMno(member.getMno()));
			question_list = productService.questionList(cri.setMno(member.getMno()));
			product = productService.view(cri.setMno(member.getMno()));
		}else {
			reviewlist = productService.listPaging(cri.setMno(0));
			question_list = productService.questionList(cri.setMno(0));
			product = productService.view(cri.setMno(0));
		}
		
		//QnA pageMaker create
		CommentPageMaker qnaPageMaker = new CommentPageMaker();
		qnaPageMaker.setCri(cri);
		count = productService.questionListCount(cri.getPno());
		qnaPageMaker.setTotalCount(count);
		
		//Detail image url split to show
		String[] detailUrl = product.getProducturl().split(";");		
		
		List<String> imageList = new ArrayList<String>();
		
		for(int i=0;i<detailUrl.length;i++) {
			imageList.add(detailUrl[i]);
		}
		
		//Setting
		model.addAttribute("categories", productService.categoryList());
		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
		
		model.addAttribute("product",product);
		model.addAttribute("option",productService.view_option(cri.getPno()));
		model.addAttribute("max",productService.view_option(cri.getPno()).size());
		model.addAttribute("image",imageList);
		
		model.addAttribute("reviews", reviewlist);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("reviewCount", productService.listCount(cri.getPno()));

		model.addAttribute("questions", question_list);
		model.addAttribute("qnaPageMaker", qnaPageMaker);
		model.addAttribute("questionCount", productService.questionListCount(cri.getPno()));
		
		return "/productions/view";
	}
	
	@ResponseBody
	@RequestMapping(value="/view/checkOption", method=RequestMethod.POST)
	public int productionCheckOptionPOST(int ono) throws Exception{
		logger.info("-------- VIEW : PRODUCTIONS CHECK OPTION METHOD=POST --------");
		
		int result = productService.checkInventory(ono);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/review", method=RequestMethod.POST)
	public int productionReviewPOST(HttpSession session, ReviewVO review, MultipartFile image) throws Exception{
		logger.info("-------- REGIST : PRODUCTION REVIEW REGIST METHOD=POST --------");

		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		if(member != null) {
			review.setMno(member.getMno());
			
			if(image != null) {
				String imgUploadPath = uploadPath + "/" + "imgUpload";
				String ymdPath = UploadFileUtils.calcPath(imgUploadPath);

				review.setContentimg("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, image.getOriginalFilename(), image.getBytes(), ymdPath));
			}else {
				review.setContentimg("noImage");
			}
						
			productService.reviewRegist(review);
			productService.updateReviewStatus(review);
			
			result = 1;
		}
		
		return result;
	}

	@ResponseBody
	@RequestMapping(value="/review_like", method=RequestMethod.POST)
	public int reviewLikePOST(HttpSession session, ReviewLikeVO like) throws Exception{
		logger.info("-------- UPDATE : REVIEW LIKE UPDATE METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		if(member != null) {
			like.setMno(member.getMno());
			
			int check = productService.checkLike(like);
			
			if(check == 0) {
				result = 1;
				productService.registLike(like);
			}else {
				result = 2;
				productService.deleteLike(like);
			}
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewListUpdate", method=RequestMethod.POST)
	public List<ReviewVO> reviewListUpdate(HttpSession session, CommentCriteria cri) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS REVIEW LIST UPDATE METHOD=POST --------");
		logger.info("-------- THIS PNO = " + cri.getPno() + " --------");
		logger.info("-------- CRITERIA INFO = " + cri.toString() + " --------");
		
		MemberVO member = (MemberVO) session.getAttribute("login");

		//Insert Paged Reviews
		List<ReviewVO> reviews = new ArrayList<ReviewVO>();
		if(member != null) {
			reviews = productService.listPaging(cri.setMno(member.getMno()));	
		}else {
			reviews = productService.listPaging(cri.setMno(0));
		}

		return reviews;
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewListCount", method=RequestMethod.POST)
	public int reviewListCountPOST(int pno) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS REVIEW LIST COUNT METHOD=POST --------");
		logger.info("-------- THIS PNO = " + pno + " --------");
		
		int count = productService.listCount(pno);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewOrder", method=RequestMethod.POST)
	public List<ReviewVO> reviewOrder(HttpSession session, CommentCriteria cri) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS REVIEW LIST ORDER MODIFY METHOD=POST --------");
		
		List<ReviewVO> reviews = new ArrayList<ReviewVO>();
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null ) {
			reviews = productService.listPaging(cri.setMno(member.getMno()));
		}else {
			reviews = productService.listPaging(cri.setMno(0));
		}
		
		return reviews;
	}
	
	@ResponseBody
	@RequestMapping(value="/review/delete/{rno:.+}", method=RequestMethod.GET)
	public int reviewDelete(HttpSession session, @PathVariable(value="rno") int rno) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS REVIEW DELETE METHOD = GET --------");
		
		int result = 0;
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			ReviewVO review = new ReviewVO().setRno(rno).setMno(member.getMno());
			
			result = productService.deleteReview(review);
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/questionRegist", method=RequestMethod.POST)
	public void questionRegistPOST(ProductQuestionVO question) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS QUESTION REGIST METHOD=POST --------");

		productService.questionRegist(question);
	}

	@ResponseBody
	@RequestMapping(value="/answerRegist", method=RequestMethod.POST)
	public int answerRegistPOST(HttpSession session, ProductQuestionVO question) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS ANSWER REGIST METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(question.getMno() != 0 && member != null) {
			productService.answerRegist(question);
			productService.questionStatusUpdate(question.getQno());
			result = 1;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/questionDelete", method=RequestMethod.POST)
	public int questionDeletePOST(HttpSession session, int qno) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS QUESTION DELETE METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			productService.questionDelete(qno);
			result = 1;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/questionListCount", method=RequestMethod.POST)
	public int questionListCount(int pno) throws Exception{
		return productService.questionListCount(pno);
	}
	
	@ResponseBody
	@RequestMapping(value="questionListUpdate", method=RequestMethod.POST)
	public List<ProductQuestionVO> questionListUpdatePOST(CommentCriteria cri) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS QUESTION LIST UPDATE METHOD=POST --------");
		logger.info("-------- THIS PNO = " + cri.getPno() + " --------");
		logger.info("-------- CRITERIA INFO = " + cri.toString() + " --------");
		
		List<ProductQuestionVO> list = productService.questionList(cri);
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="questionAnswerDelete", method=RequestMethod.POST)
	public int questionAnswerDeletePOST(HttpSession session, ProductQuestionVO question) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS ANSWER DELETE METHOD = POST --------");
		logger.info("-------- VO INFO = " + question.toString()  + " --------");
		
		int result = 0;
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			productService.answerDelete(question.setMno(member.getMno()));
			result = 1;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public int productionsDeleteGET(HttpSession session,ProductVO product) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS PRODUCT DELETE METHOD = GET --------");
		
		int result = 0;
		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			product.setMno(member.getMno());
			
			productService.deleteProduct(product);
			
			result = 1;
		}
		
		return result;
	}
	
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public void productionsModifyGET(Model model, HttpSession session, CommentCriteria cri) throws Exception{
		logger.info("-------- PRODUCTIONS : ACCESS PRODUCT MODIFY METHOD = GET --------");
		logger.info("-------- PRODUCTIONS : ACCESS PNO = "+cri.getPno()+" --------");

		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			ProductVO product = productService.view(cri);
			
			//Detail image url split to show
			String[] detailUrl = product.getProducturl().split(";");		
			
			List<String> imageList = new ArrayList<String>();
			
			for(int i=0;i<detailUrl.length;i++) {
				imageList.add(detailUrl[i]);
			}
			
			//Product option check the number
			List<ProductOptionVO> options = productService.view_option(cri.getPno());
			int option_count = options.size();
			
			//Setting
			model.addAttribute("categories", productService.categoryList());
			model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
			
			model.addAttribute("product", product);
			model.addAttribute("option_count", option_count);
			model.addAttribute("option", options);
			model.addAttribute("image", imageList);
		}
	}
	
	@RequestMapping(value="modify", method=RequestMethod.POST)
	public void productionsModifyPOST(HttpSession session, @RequestParam("product_thumurl") MultipartFile file1, @RequestParam("product_url") MultipartFile[] file2,
			ProductVO product, char has_option, ProductOptionVO option, int[] inventory) throws Exception{
		logger.info("-------- UPDATE : PRODUCTIONS MODIFY METHOD=POST --------");

		MemberVO member = (MemberVO) session.getAttribute("login");
		
		if(member != null) {
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			
			CommentCriteria cri = new CommentCriteria().setMno(member.getMno()).setPno(product.getPno());
			ProductVO exist_product = productService.view(cri);
			
			if(file1.getOriginalFilename() != "") {
				//Set thumbnail image name and upload image to server and delete exist image
				FileDelete.deleteFile(exist_product.getProductthumurl());
				product.setProductthumurl("/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file1.getOriginalFilename(), file1.getBytes(), ymdPath));
			}
			
			//Detail images upload to server
			for(int i=0;i<file2.length;i++) {
				if(file2[i].getOriginalFilename() == "") break;
				
				if(i == 0) {
					product.setProducturl("/" + "imgUpload" + ymdPath + "/" 
											+ UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath));
				}else {
					product.setProducturl(product.getProducturl() 
							+";" + "/" + "imgUpload" + ymdPath + "/" 
							+ UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath));
				}
			}

			if(product.getProducturl() != null) {
				String[] arr_exist = exist_product.getProducturl().split(";");
				
				for(int i=0;i<arr_exist.length;i++) {
					FileDelete.deleteFile(arr_exist[i]);
				}
			}
			
			product.setMno(member.getMno());
			productService.modifyProduct(product);
			
			//Exist option delete and new option regist
			productService.delete_option(product.getPno());
			
			if(has_option == 'T') {
				int inventory_count = 0;
				String[] array_option = option.getOptioncolor().split(",");

				for(int i=0;i<array_option.length;i++) {
					String[] temp = array_option[i].split("\\#\\$\\%");
					
					option.setOptioncolor(temp[0])
						.setOptionsize(temp[1])
						.setInventory(inventory[inventory_count++]);

					productService.register_option(option);
				}
			}else {
				productService.register_option(option);
			}
		}
	}
}