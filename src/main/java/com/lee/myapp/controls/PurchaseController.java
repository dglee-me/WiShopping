package com.lee.myapp.controls;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.domain.PurchaseVO;
import com.lee.myapp.service.PurchaseService;

@Controller
@RequestMapping("/purchase/")
public class PurchaseController {
	private static final Logger logger = LoggerFactory.getLogger(PurchaseController.class);
	
	@Inject
	PurchaseService purchaseService;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String purchaseListGET(HttpSession session, Model model, String before, String status) throws Exception{
		logger.info("-------- PURCHASE : LIST METHOD=GET --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("mno", member.getMno());
			map.put("before", before);
			map.put("status", status);
			
			List<PurchaseVO> statusList = purchaseService.purchaseStatusList(map);
			List<PurchaseVO> orders = purchaseService.purchaseList(map);
			List<OrderVO> ordernos = purchaseService.ordernoList(map);

			//Setting
			model.addAttribute("categories", purchaseService.categoryList());
			model.addAttribute("headerBanners", purchaseService.mainBannerList("헤더")); // Main banner list in this view

			model.addAttribute("status",statusList);
			model.addAttribute("orders",orders);
			model.addAttribute("ordernos",ordernos);
			
			return "/purchase/list";
		}else {
			return "/auth/login";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="listUpdate", method=RequestMethod.POST)
	public void purchaseListUpdatePOST(HttpSession session, int before) throws Exception{
		logger.info("-------- PURCHASE : LIST UPDATE METHOD = POST --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			
		}
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public void purchaseDetailViewGET(HttpSession session, Model model, String orderno) throws Exception{
		logger.info("-------- PURCHASE : DETAIL VIEW METHOD=GET --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			//Setting
			model.addAttribute("categories", purchaseService.categoryList());
			model.addAttribute("headerBanners", purchaseService.mainBannerList("헤더")); // Main banner list in this view
			
			model.addAttribute("order",purchaseService.viewOrderNo(orderno));
			model.addAttribute("purchase",purchaseService.viewOrder(orderno));
		}
	}
}