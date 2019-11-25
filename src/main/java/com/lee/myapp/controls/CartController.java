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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lee.myapp.domain.CartListVO;
import com.lee.myapp.domain.CartVO;
import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.service.CartService;

@Controller
@RequestMapping("/cart/")
public class CartController {
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	@Inject
	CartService cartService;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void cartMainGET(HttpSession session, Model model) throws Exception{
		logger.info("-------- CART : MAIN METHOD=GET --------");
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		model.addAttribute("cartList",cartService.cartList(member.getMno()));
	}
	
	@ResponseBody
	@RequestMapping(value="/addCart", method=RequestMethod.POST)
	public int addCartListPOST(CartVO cart, HttpSession session) throws Exception{
		logger.info("-------- CART : ADD METHOD=POST --------");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			cart.setMno(member.getMno());
			cartService.addCart(cart);
			result = 1;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/cartUpdate", method=RequestMethod.POST)
	public int cartUpdatePOST(CartVO cart,HttpSession session) throws Exception{
		logger.info("-------- CART : UPDATE METHOD=POST --------");
		
		int result = 0;
		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			cart.setMno(member.getMno());
			cartService.cartUpdate(cart);
			
			result = 1;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/cartRemove", method=RequestMethod.POST)
	public int cartRemovePOST(@RequestParam(value="checkArray[]") List<String> checkArray,CartListVO cart,HttpSession session) throws Exception{
		logger.info("-------- CART : REMOVE METHOD=POST --------");
		
		int result = 0;
		int cartNo = 0;

		MemberVO member = (MemberVO)session.getAttribute("login");
		
		if(member != null) {
			cart.setMno(member.getMno());
			
			for(String i : checkArray) {
				cart.setCartno(Integer.parseInt(i));
				cartService.cartRemove(cart);
			}
			result = 1;
		}
		
		
		return result;
	}
}
