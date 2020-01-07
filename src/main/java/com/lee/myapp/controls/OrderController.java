package com.lee.myapp.controls;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import com.lee.myapp.domain.OrderListVO;
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
			String[] inventory = number.split(";");
			
			String referer = request.getHeader("referer");
			if(referer.equals("http://localhost:8081/WiShopping/cart/main")) {
				//If order from a cart
				HashMap<String,Object> map = new HashMap<String,Object>();
				
				map.put("ono", ono);
				map.put("mno", member.getMno());
				
				session.setAttribute("orderList",orderService.cartToOrderList(map));
			}else {
				//If order directly from the product screen
				List<OrderListVO> list = new ArrayList<OrderListVO>();

				for(int i=0;i<ono.length;i++) {
					HashMap<String,Object> map = new HashMap<String,Object>();
					map.put("ono",ono[i]);
					map.put("inventory",inventory[i]);
					
					OrderListVO order = orderService.productToOrderList(map);
					
					list.add(order);
				}
				session.setAttribute("orderList",list);
			}
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
		model.addAttribute("headerBanners", orderService.mainBannerList("헤더")); // Main banner list in this view
		
		return "/order/preorder";
	}
	
	@Transactional
	@RequestMapping(value="/pre_order", method=RequestMethod.POST)
	public String pre_orderPOST(HttpSession session, OrderVO order, String[] cartno, String[] ono, int[] inventory) throws Exception{
		logger.info("-------- ORDER : PRE_ORDER METHOD=POST --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
				
		if(member != null) {
			String orderNo = CommonUtils.CreateRandomNumber();
			
			//If product to order case, flag is false, and cart to order case, flag is true;
			boolean flag = true;
			if(cartno[0].equals("0")) flag = false;
			
			if(flag == true) {
				logger.info("-------- ORDER TYPE : CART TO ORDER --------");
				// Order failed If the products in the cart are out of stock
				for(int i=0;i<ono.length;i++) {
					if(orderService.cartCheckInventory(cartno[i]) > orderService.checkInventory(ono[i])) {
						return "redirect:orderFail";
					}
				}
				//To order
				order.setMno(member.getMno());
				orderService.orderInfo(order.setOrderno(orderNo));

				HashMap<String,Object> map = new HashMap<String,Object>();
				
				//Reflect inventory on successful order
				for(int i=0;i<ono.length;i++) {
					map.put("ono", ono[i]);
					map.put("inventory", inventory[i]);
					
					orderService.updateInventory(map);
					map.clear();
				}

				//If cart to order case
				map.put("cartno", cartno);
				map.put("orderno", orderNo);
			
				int result = orderService.cart_orderInfo_detail(map);
				
				for(int i=0;i<cartno.length;i++) {
					orderService.cartUpdateSalesVolume(cartno[i]);
				}
				
				//When the number of insert is more than 1
				if(result >= 1) {
					//Delete cart if order succeeds
					map.put("mno", member.getMno());
					orderService.cartDelete(map);
				}else {
					//If order failed
					return "redirect:orderFail";
				}
			}else {//If product to order case
				logger.info("-------- ORDER TYPE : PRODUCT TO ORDER --------");
				for(int i=0;i<ono.length;i++) {
					if(inventory[i] >= orderService.checkInventory(ono[i])) {
						return "redirect:orderFail";
					}
				}
				//To order
				order.setMno(member.getMno());
				orderService.orderInfo(order.setOrderno(orderNo));
				
				HashMap<String,Object> map = new HashMap<String,Object>();
				
				for(int i=0;i<ono.length;i++) {
					map.put("ono", ono[i]);
					map.put("orderno", orderNo);
					map.put("inventory", inventory[i]);
					
					orderService.product_orderInfo_detail(map);
					orderService.updateInventory(map);
					orderService.productToUpdateSalesVolume(map);

					map.clear();
				}
			}
		}
		return "redirect:/order/result";
	}

	@RequestMapping(value="/result", method=RequestMethod.GET)
	public void resultGET(Model model) throws Exception{
		logger.info("-------- ORDER : RESULT METHOD=GET --------");
		
		//Setting
		model.addAttribute("headerBanners", orderService.mainBannerList("헤더")); // Main banner list in this view
	}
	
	@RequestMapping(value="/orderFail", method=RequestMethod.GET)
	public void orderFailGET() throws Exception{
		logger.info("-------- FAIL : ORDER FAIL METHOD=GET --------");
	}
}
