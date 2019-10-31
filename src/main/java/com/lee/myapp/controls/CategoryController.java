package com.lee.myapp.controls;

import java.io.File;

import javax.annotation.Resource;
import javax.inject.Inject;

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
	public void fashionCategoryGET() throws Exception{
		logger.info("-------- CATEGORY : GROUP 1 (FASHION) METHOD=GET --------");	
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public void categoryRegistGET() throws Exception{
		logger.info("-------- REGIST : CATEGORY METHOD=GET --------");
		
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public void categoryRegistPOST(ProductVO pd, @RequestParam("productthumurl") MultipartFile file1,@RequestParam("producturl") MultipartFile file2  ) throws Exception{
		logger.info("-------- REGIST : CATEGORY METHOD=POST --------");
		
		logger.info("파일이름 : "+file1.getOriginalFilename()+" /// "+file2.getOriginalFilename());
		logger.info("파일크키 : "+file1.getSize()+" /// "+file2.getSize());
		logger.info("Content 타입 : "+file1.getContentType()+" /// "+file2.getContentType());
		
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
	}
}