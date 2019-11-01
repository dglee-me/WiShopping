package com.lee.myapp.controls;

import java.io.File;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.ProductVO;
import com.lee.myapp.service.ProductService;
import com.lee.myapp.utils.UploadFileUtils;

@Controller
@RequestMapping("/category/")
public class CategoryController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	ProductService productService;
	
	@RequestMapping(value="/group/fashion", method=RequestMethod.GET)
	public void fashionCategoryGET(HttpServletRequest request) throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (FASHION) METHOD=GET --------");	
		
		request.setAttribute("list", productService.list("ÆÐ¼Ç"));
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public void categoryRegistGET() throws Exception{
		logger.info("-------- REGIST : CATEGORY METHOD=GET --------");
		
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String categoryRegistPOST(ProductVO pd, @RequestParam("productthumurl") MultipartFile file1,@RequestParam("producturl") MultipartFile file2  ) throws Exception{
		logger.info("-------- REGIST : CATEGORY METHOD=POST --------");
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String thumUrl, detailUrl = null;
		
		if(file1.getOriginalFilename() != null && file1.getOriginalFilename() != "" && file2.getOriginalFilename() != null && file2.getOriginalFilename() != "") {
			thumUrl = UploadFileUtils.fileUpload(imgUploadPath, file1.getOriginalFilename(), file1.getBytes(), ymdPath);
			detailUrl = UploadFileUtils.fileUpload(imgUploadPath, file2.getOriginalFilename(), file2.getBytes(), ymdPath);
		}else {
			thumUrl = uploadPath + File.separator + "image" + File.separator + "none.png";
			detailUrl = uploadPath + File.separator + "image" + File.separator + "none.png";
		}
		
		pd.setProduct_thumurl(File.separator + "imgUpload" + ymdPath + File.separator + thumUrl);
		pd.setProduct_url(File.separator + "imgUpload" + ymdPath + File.separator + detailUrl);
		
		productService.register(pd);
		
		return "redirect:/";
	}
}