package com.lee.myapp.controls;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.service.OrderService;

@Controller
@RequestMapping("/order/")
public class OrderController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	OrderService orderService;
	
	@ResponseBody
	@RequestMapping(value="/order_request", method=RequestMethod.POST)
	public int orderRequestPOST(@RequestParam(value="pnoArray[]") String[] pnoList,HttpSession session, Model model) throws Exception{
		logger.info("-------- ORDER : ORDER_REQUEST METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			//Product information displayed in the pre_order view
			List<OrderListVO> orderList = orderService.orderList(pnoList);
			session.setAttribute("orderList",orderList);
			
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
	public String pre_orderPOST(HttpSession session, OrderVO order, String[] pno, String[] cartno, String[] cartsize) throws Exception{
		logger.info("-------- ORDER : PRE_ORDER METHOD=POST --------");

		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			//Make orderno
			Calendar calendar = Calendar.getInstance();
			String subNum = "";
			
			String ymd = calendar.get(Calendar.YEAR) 
					+ new DecimalFormat("00").format(calendar.get(Calendar.MONTH) + 1)
					+ new DecimalFormat("00").format(calendar.get(Calendar.DATE));
			
			for(int i=1;i<=6;i++) {
				subNum += (int)(Math.random() * 10);
			}
			
			String orderNo = ymd + "-" + subNum;
			
			//To order
			order.setMno(member.getMno());
			orderService.orderInfo(order.setOrderno(orderNo));
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("mno", member.getMno());
			map.put("pno", pno);
			map.put("orderno", orderNo);
			orderService.orderInfo_Detail(map);
			
			//Delete cart when order completes successfully
			if(cartno != null) {
				//Cart to order case
				int toInt[] = new int[10];

				for(int i=0;i<cartno.length;i++) {
					toInt[i] = Integer.parseInt(cartno[i]);
				}
				
				map.put("cartno", toInt);
				map.put("cartsize", cartsize);
				orderService.cartDelete(map);
			}else {
				//Product to order case
				System.out.println("Product to order case는 아직 미구현입니다~ 빠르게 처리하겠습니다.");
			}

			return "redirect:/order/result";
		}
		return "redirect:/error";
	}
	
	@RequestMapping(value="/result", method=RequestMethod.GET)
	public void resultGET() throws Exception{
		logger.info("-------- ORDER : RESULT METHOD=GET --------");
	}
}
