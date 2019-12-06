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
	public void productionRegistGET() throws Exception{
		logger.info("-------- CREATE : PRODUCTIONS METHOD=GET --------");
		
	}
	
	/*
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
	*/
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String productionRegistPOST(@RequestParam("product_thumurl") MultipartFile file1, @RequestParam("product_url") MultipartFile[] file2,
			ProductVO product, char has_option, ProductOptionVO option, int[] inventory) throws Exception{
		logger.info("-------- CREATE : PRODUCTIONS METHOD=POST --------");

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String thumbUrl = null;
		String detailUrl = "";
		
		//Thumbnail image upload to server
		thumbUrl = UploadFileUtils.fileUpload(imgUploadPath, file1.getOriginalFilename(), file1.getBytes(), ymdPath);
			
		//Detail images upload to server
		for(int i=0;i<file2.length-1;i++) {
			if(i == 0) {
				detailUrl = UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
				continue;
			}
			detailUrl = detailUrl+";"+UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
		}
		
		product.setProductthumurl(File.separator + "imgUpload" + ymdPath + File.separator + thumbUrl);
		product.setProducturl(File.separator + "imgUpload" + ymdPath + File.separator + detailUrl);
		
		//Insert product into database
		productService.register(product);
		
		//Create options for a product and insert into database
		if(has_option == 'T') { // if checked the option checkbox in the register view
			String[] color = option.getColor().split(",");
			String[] size = option.getSize().split(",");
			int inventory_count = 0;
			
			for(int i=0;i<color.length;i++) {
				for(int j=0;j<size.length;j++) {
					option = new ProductOptionVO()
							.setColor(color[i])
							.setSize(size[j])
							.setInventory(inventory[inventory_count++]);
					
					productService.register_option(option);
				}
			}
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public void productionViewGET(HttpServletRequest request,int pno) throws Exception{
		logger.info("-------- VIEW : PRODUCTIONS METHOD=GET --------");
		
		request.setAttribute("product",productService.view(pno));
	}
}