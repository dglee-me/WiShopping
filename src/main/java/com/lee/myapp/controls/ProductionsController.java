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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.ProductOptionVO;
import com.lee.myapp.domain.ProductVO;
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
	public void productionViewGET(Model model,int pno) throws Exception{
		logger.info("-------- VIEW : PRODUCTIONS METHOD=GET --------");
		ProductVO product = productService.view(pno);
		
		//Detail image url split to show
		String[] detailUrl = product.getProducturl().split(";");		
		
		List<String> imageList = new ArrayList<String>();
		
		for(int i=0;i<detailUrl.length;i++) {
			imageList.add(detailUrl[i]);
		}

		//Setting
		model.addAttribute("headerBanners", productService.mainBannerList("헤더")); // Main banner list in this view
		
		model.addAttribute("product",product);
		model.addAttribute("option",productService.view_option(pno));
		model.addAttribute("max",productService.view_option(pno).size());
		model.addAttribute("image",imageList);
	}
	
	@ResponseBody
	@RequestMapping(value="/view/checkOption", method=RequestMethod.POST)
	public int productionCheckOptionPOST(int ono) throws Exception{
		logger.info("-------- VIEW : PRODUCTIONS CHECK OPTION METHOD=POST --------");
		
		int result = productService.checkInventory(ono);
		
		return result;
	}
}