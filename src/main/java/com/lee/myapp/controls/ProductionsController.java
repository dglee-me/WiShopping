package com.lee.myapp.controls;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String productionRegistPOST(@RequestParam("product_thumurl") MultipartFile file1, @RequestParam("product_url") MultipartFile[] file2,
			ProductVO product, char has_option, ProductOptionVO option, int[] inventory) throws Exception{
		logger.info("-------- CREATE : PRODUCTIONS METHOD=POST --------");

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String thumbUrl = null;
		
		//Thumbnail image upload to server
		thumbUrl = UploadFileUtils.fileUpload(imgUploadPath, file1.getOriginalFilename(), file1.getBytes(), ymdPath);
			
		//Detail images upload to server
		String detailUrl = "";
		
		for(int i=0;i<file2.length-1;i++) {
			if(i == 0) {
				detailUrl = UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
				continue;
			}
			detailUrl = detailUrl+";"+UploadFileUtils.fileUpload(imgUploadPath, file2[i].getOriginalFilename(), file2[i].getBytes(), ymdPath);
		}

		//Detail image set path
		String[] url = detailUrl.split(";");
		detailUrl = "";
		
		for(int i=0;i<url.length;i++) {
			url[i] = File.separator + "imgUpload" + ymdPath + File.separator + url[i];
			
			if(i == 0) {
				detailUrl = url[i];
				continue;
			}
			detailUrl += ";" + url[i];
		}
		
		product.setProductthumurl(File.separator + "imgUpload" + ymdPath + File.separator + thumbUrl);		
		product.setProducturl(detailUrl);
		
		//Insert product into database
		productService.register(product);
		
		//Create options for a product and insert into database
		if(has_option == 'T') { // if checked the option checkbox in the register view
			String[] color = option.getOptioncolor().split(",");
			String[] size = option.getOptionsize().split(",");
			int inventory_count = 0;
			
			for(int i=0;i<color.length;i++) {
				for(int j=0;j<size.length;j++) {
					option = new ProductOptionVO()
							.setOptioncolor(color[i])
							.setOptionsize(size[j])
							.setInventory(inventory[inventory_count++]);
					
					productService.register_option(option);
				}
			}
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
		
		model.addAttribute("product",product);
		model.addAttribute("option",productService.view_option(pno));
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