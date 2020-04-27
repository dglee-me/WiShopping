package com.lee.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.OrderListVO;
import com.lee.myapp.domain.OrderVO;
import com.lee.myapp.persistence.OrderDAO;
import com.lee.myapp.utils.CommonUtils;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Inject
	OrderDAO orderDAO;

	@Override
	public List<OrderListVO> cartToOrderList(Map<String,Object> map) throws Exception{
		// TODO Auto-generated method stub
		return orderDAO.cartToOrderList(map);
	}

	@Override
	public OrderListVO productToOrderList(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.productToOrderList(map);
	}

	@Override
	public List<OrderListVO> orderList(HttpServletRequest request, HashMap<String,Object> map, String number) throws Exception{
		// TODO Auto-generated method stub
		List<OrderListVO> list = new ArrayList<OrderListVO>();

		/*
		 * 이전 페이지가 장바구니라면 if문을, 아니라면 else문을 실행한다.
		 */
		String referer = request.getHeader("referer");
		if(referer.equals("http://15.165.119.77:8080/WiShopping/cart/main") || referer.equals("http://localhost:8081/WiShopping/cart/main")) {
			//If order from a cart
			list = cartToOrderList(map);
		}else {
			//If order directly from the product screen
			String[] ono = (String[]) map.get("ono");
			String[] inventory = number.split(";"); //구분자 ;를 활용한 문자열로 받아온 재고를 배열로 나누어준다.
			
			for(int i=0;i<ono.length;i++) {
				map.clear(); // Initialize existing HashMap
				
				map.put("ono", ono[i]);
				map.put("inventory",inventory[i]);

				OrderListVO order = productToOrderList(map);
				list.add(order);
			}
		}
		
		return list;
	}

	@Override
	public void orderInfo(OrderVO order) throws Exception {
		// TODO Auto-generated method stub
		orderDAO.orderInfo(order);
	}


	@Override
	public int cart_orderInfo_detail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.cart_orderInfo_detail(map);
	}
	
	@Override
	public int product_orderInfo_detail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.product_orderInfo_detail(map);
	}

	@Override
	public String order(OrderVO order, String payment, String[] cartno, String[] ono, int[] inventory) throws Exception{
		// TODO Auto-generated method stub
		/*
		 * path : return 할 주소값 변수
		 * payment : 결제수단 확인하는 변수
		 * orderNo : 주문번호에 사용되는 random 숫자
		 * cartno : 상품에서 바로 구매하는지, 장바구니에서 구매하는지를 판별하기 위한 변수임. 만약 장바구니에서 넘어와 결제한거라면 true, 상품에서 바로 구매하는 것이라면 false.
		 */
		String path = "redirect:/order/result";
		String orderNo = CommonUtils.CreateRandomNumber();
		
		
		
		if(payment.equals("credit_card")) { //If order by credit card
			order.setDeliverystatus(1);
		}

		//If product to order case, flag is false, and cart to order case, flag is true;
		boolean flag = true;
		if(cartno[0].equals("0")) flag = false;
		
		if(flag == true) {
			System.out.println("-------- ORDER TYPE : CART TO ORDER --------");
			
			// Order failed If the products in the cart are out of stock
			for(int i=0;i<ono.length;i++) {
				if(cartCheckInventory(cartno[i]) > checkInventory(ono[i])) {
					path = "redirect:orderFail";
				}
			}
			
			//To order
			orderInfo(order.setOrderno(orderNo));

			HashMap<String,Object> map = new HashMap<String,Object>();

			//Reflect inventory on successful order
			for(int i=0;i<ono.length;i++) {
				map.put("ono", ono[i]);
				map.put("inventory", inventory[i]);
				
				updateInventory(map);
				map.clear();
			}

			//If cart to order case
			map.put("cartno", cartno);
			map.put("orderno", orderNo);
		
			int result = cart_orderInfo_detail(map);

			for(int i=0;i<cartno.length;i++) {
				cartUpdateSalesVolume(cartno[i]);
			}

			//When the number of insert is more than 1
			if(result >= 1) {
				//Delete cart if order succeeds
				map.put("mno", order.getMno());
				cartDelete(map);
			}else {
				//If order failed
				path = "redirect:orderFail";
			}
		}else {
			System.out.println("-------- ORDER TYPE : PRODUCT TO ORDER --------");
			
			for(int i=0;i<ono.length;i++) {
				if(inventory[i] >= checkInventory(ono[i])) {
					path = "redirect:orderFail";
				}
			}
			
			//To order
			orderInfo(order.setOrderno(orderNo));
			
			HashMap<String,Object> map = new HashMap<String,Object>();

			for(int i=0;i<ono.length;i++) {
				map.put("ono", ono[i]);
				map.put("orderno", orderNo);
				map.put("inventory", inventory[i]);
				
				product_orderInfo_detail(map);
				updateInventory(map);
				productToUpdateSalesVolume(map);

				map.clear();
			}
		}
		
		return path;
	}
	
	@Override
	public void cartDelete(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		orderDAO.cartDelete(map);
	}
	
	@Override
	public void updateInventory(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		orderDAO.updateInventory(map);
	}

	@Override
	public int checkInventory(String ono) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.checkInventory(ono);
	}

	@Override
	public int cartCheckInventory(String cartno) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.cartCheckInventory(cartno);
	}

	@Override
	public int cartUpdateSalesVolume(String cartno) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.cartUpdateSalesVolume(cartno);
	}

	@Override
	public int productToUpdateSalesVolume(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.productToUpdateSalesVolume(map);
	}

	//Header category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.categoryList();
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.mainBannerList(area);
	}
}