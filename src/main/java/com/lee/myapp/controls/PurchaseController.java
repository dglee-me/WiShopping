package com.lee.myapp.controls;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String purchaseListGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- PURCHASE : LIST METHOD=GET --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			List<PurchaseVO> orders = purchaseService.purchaseList(member.getMno());
			List<OrderVO> ordernos = purchaseService.ordernoList(member.getMno());
			
			for(int i=0;i<orders.size();i++) {
				orders.get(i).setProduct_thumurl(orders.get(i).getProduct_thumurl().replace("\\","/"));
			}
			
			model.addAttribute("orders",orders);
			model.addAttribute("ordernos",ordernos);
			
			return "/purchase/list";
		}else {
			return "/error";
		}
	}
}