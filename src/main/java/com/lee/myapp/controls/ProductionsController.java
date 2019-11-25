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
@RequestMapping("/productions/")
public class ProductionsController {
	private static final Logger logger = LoggerFactory.getLogger(ProductionsController.class);
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	ProductService productService;
	
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public void productionRegistGET() throws Exception{
		logger.info("-------- CREATE : PRODUCTIONS METHOD=GET --------");
		
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String productionRegistPOST(@RequestParam("productthumurl") MultipartFile file1,@RequestParam("producturl") MultipartFile file2, ProductVO pd) throws Exception{
		logger.info("-------- CREATE : PRODUCTIONS METHOD=POST --------");
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String thumUrl, detailUrl = null;
		
		//Image upload line
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
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public void productionViewGET(HttpServletRequest request,int pno) throws Exception{
		logger.info("-------- VIEW : PRODUCTIONS METHOD=GET --------");
		
		request.setAttribute("product",productService.view(pno));
	}
}