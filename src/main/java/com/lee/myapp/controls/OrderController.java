package com.lee.myapp.controls;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.service.OrderService;
import com.lee.myapp.utils.CommonUtils;

@Controller
@RequestMapping("/order/")
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Inject
	OrderService orderService;
	
	@ResponseBody
	@RequestMapping(value="/order_request", method=RequestMethod.POST)
	public int orderRequestPOST(@RequestParam(value="ono[]") String[] ono, @RequestParam(value="number") String number,
			HttpServletRequest request, HttpSession session, Model model) throws Exception{
		logger.info("-------- ORDER : ORDER_REQUEST METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("login");

		if(member != null) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("ono", ono);
			map.put("mno", member.getMno());
			
			session.setAttribute("orderList", orderService.orderList(request, map, number));

			result = 1;
		}else {
			result = 2;
		}
		
		return result;
	}
	
	@RequestMapping(value="/pre_order", method=RequestMethod.GET)
	public String pre_orderGET(Model model,HttpServletRequest request,HttpSession session) throws Exception{
		logger.info("-------- ORDER : PRE_ORDER METHOD=GET --------");
		
		if(session.getAttribute("orderList") == null) {
			logger.info("---------------- Object Null ----------------");
			session.getAttribute("orderList");
		}

		//Setting
		model.addAttribute("categories", orderService.categoryList());
		model.addAttribute("headerBanners", orderService.mainBannerList("헤더")); // Main banner list in this view
		
		return "/order/preorder";
	}
	
	@Transactional
	@RequestMapping(value="/pre_order", method=RequestMethod.POST)
	public String pre_orderPOST(HttpSession session, OrderVO order, String[] cartno, String[] ono, int[] inventory
			, @RequestParam(value="order[payment_method]") String payment) throws Exception{
		logger.info("-------- ORDER : PRE_ORDER METHOD=POST --------");
		
		String path = "";
		MemberVO member = (MemberVO)session.getAttribute("login");
				
		if(member != null) {
			path = orderService.order(order.setMno(member.getMno()), payment, cartno, ono, inventory);
		}
		
		return path;
	}

	@RequestMapping(value="/result", method=RequestMethod.GET)
	public void resultGET(Model model) throws Exception{
		logger.info("-------- ORDER : RESULT METHOD=GET --------");
		
		//Setting
		model.addAttribute("categories", orderService.categoryList());
		model.addAttribute("headerBanners", orderService.mainBannerList("헤더")); // Main banner list in this view
	}
	
	@RequestMapping(value="/orderFail", method=RequestMethod.GET)
	public void orderFailGET() throws Exception{
		logger.info("-------- FAIL : ORDER FAIL METHOD=GET --------");
	}
}
