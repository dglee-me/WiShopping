package com.lee.myapp.controls;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.CommentPageMaker;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.domain.ReviewLikeVO;
import com.lee.myapp.domain.ReviewVO;
import com.lee.myapp.service.ProductService;
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
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public void productionViewGET(HttpSession session, Model model, CommentCriteria cri) throws Exception{
		logger.info("-------- VIEW : PRODUCTIONS METHOD=GET --------");
		ProductVO product = productService.view(cri.getPno());
		
		//Detail image url split to show
		String[] detailUrl = product.getProducturl().split(";");		
		
		List<String> imageList = new ArrayList<String>();
		
		for(int i=0;i<detailUrl.length;i++) {
			imageList.add(detailUrl[i]);
		}
		
		CommentPageMaker pageMaker = new CommentPageMaker();
		pageMaker.setCri(cri);
		int count = productService.listCount(cri.getPno());
		pageMaker.setTotalCount(count);

		
		//Check member login when review paging
		MemberVO member = (MemberVO) session.getAttribute("login");

		List<ReviewVO> list = new ArrayList<ReviewVO>();
		
		if(member != null) {
			list = productService.listPaging(cri.setMno(member.getMno()));
		}else {
			list = productService.listPaging(cri.setMno(0));
		}
		
		//Setting
		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
		
		model.addAttribute("product",product);
		model.addAttribute("option",productService.view_option(cri.getPno()));
		model.addAttribute("max",productService.view_option(cri.getPno()).size());
		model.addAttribute("image",imageList);
		model.addAttribute("reviews", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("reviewCount", productService.listCount(cri.getPno()));
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
}