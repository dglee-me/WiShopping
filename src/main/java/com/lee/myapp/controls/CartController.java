package com.lee.myapp.controls;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.service.CartService;

@Controller
@RequestMapping("/cart/")
public class CartController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	CartService cartService;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void cartMainGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- Cart : MAIN METHOD=GET --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		model.addAttribute("cartList",cartService.cartList(member.getMno()));
	}
	
	@ResponseBody
	@RequestMapping(value="/addCart", method=RequestMethod.POST)
	public int addCartListPOST(CartVO cart, HttpSession session) throws Exception{
		logger.info("-------- Cart : ADD METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			cart.setMno(member.getMno());
			cartService.addCart(cart);
			result = 1;
		}
		
		return result;
	}
}
