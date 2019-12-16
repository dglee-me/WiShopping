package com.lee.myapp.controls;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
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
import com.lee.myapp.domain.ProductOptionVO;
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
	public int cartToOrderRequestPOST(String[] ono, HttpSession session, Model model) throws Exception{
		logger.info("-------- ORDER : ORDER_REQUEST METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("login");

		if(member != null) {
			
			/*
			if(pnoList.length == 0) { // If order directly from the product screen
				List<OrderListVO> orderList = orderService.productToOrderList(onoList); 
				session.setAttribute("orderList", orderList);
				
				for(int i=0;i<orderList.size();i++) {
					System.out.println(orderList.get(i).toString());
				}
			}else { // If order from a cart
				List<OrderListVO> orderList = orderService.cartToOrderList(pnoList);
				session.setAttribute("orderList",orderList);
			}*/
			result = 1;
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
		
		return "/order/preorder";
	}
	
	@RequestMapping(value="/pre_order", method=RequestMethod.POST)
	public String pre_orderPOST(HttpSession session, OrderVO order, String[] cartno, String[] ono, ProductOptionVO option) throws Exception{
		logger.info("-------- ORDER : PRE_ORDER METHOD=POST --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
				
		if(member != null) {
			String orderNo = CommonUtils.CreateRandomNumber();
			
			//To order
			order.setMno(member.getMno());
			orderService.orderInfo(order.setOrderno(orderNo));
			
			//If cart to order case
			if(cartno != null) {
				HashMap<String,Object> map = new HashMap<String,Object>();
				
				map.put("cartno", cartno);
				map.put("orderno", orderNo);
			
				int result = orderService.orderInfo_Detail(map);

				//When the number of insert is more than 1
				if(result >= 1) {
					//Delete cart if order succeeds
					map.put("mno", member.getMno());
					orderService.cartDelete(map);
				}else {
					//If order failed
					return "redirect:/error";
				}
			}else {
				System.out.println("cart to order 만 구현. 곧 product to order 구현 예정");
			}
		}
		return "redirect:/order/result";
	}
	
	@RequestMapping(value="/result", method=RequestMethod.GET)
	public void resultGET() throws Exception{
		logger.info("-------- ORDER : RESULT METHOD=GET --------");
	}
}
