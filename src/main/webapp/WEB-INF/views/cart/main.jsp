<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>위쇼핑! - 장바구니</title>
	<script type="text/javascript">
		//Check all product count
		$(document).ready(function(){		
			var count = $("input:checkbox[name='product_check']").length;
			$(".commerce-cart_side-bar_order_btn").append(count+"개 상품 구매하기");
			$(".caption").append("모두선택 ("+count+")개");
		});
		
		//When entering a page all price setting
		$(document).ready(function(){
			//Total price
			var option_price = $(".selling-option-item_price").text();
			option_price = option_price.split("원");
			
			var total_price = 0;
			
			for(var i=0;i<option_price.length-1;i++){
				total_price += parseInt(uncomma(option_price[i]),10);
			}
			
			//Delivery price
			var delivery_price = $(".product-small-item_delivery").text();			
			delivery_price = delivery_price.split("원");
			
			var total_delivery = 0;
			
			for(var i=0;i<delivery_price.length-1;i++){
				if(isNaN(parseInt(delivery_price[i],10)) == true){
					delivery_price[i]=0;
				}
				total_delivery += parseInt(delivery_price[i],10);
			}
			
			//Setting
			$(".summary_total-price").text(comma(total_price)+"원");
			$(".summary_delivery").text(comma(total_delivery)+"원");
			$(".summary_payment").text(comma(total_price+total_delivery)+"원");
		});
		
		/*Check checked product count*/
		$(document).ready(function(){
			$(".round-checkbox-input_input").click(function(){
				var count = $("input:checkbox[name='product_check']:checked").length;
				
				$(".commerce-cart_side-bar_order_btn").text(count+"개 상품 구매하기");
			})
		});
		
		/* Select box onchange*/
		$(document).ready(function(){			
			$("#checkAll").click(function(){
				if($("#checkAll").prop("checked")){
					var count = $("input:checkbox[name='product_check']").length;
					
					$(".round-checkbox-input_input").prop("checked",true);
					$(".commerce-cart_side-bar_order_btn").text(count+"개 상품 구매하기"); 
				}else{
					$(".round-checkbox-input_input").prop("checked",false);
					$(".commerce-cart_side-bar_order_btn").text("0개 상품 구매하기");
				}
			});
		});
		
		$(document).ready(function(){
			$(".round-checkbox-input_input").click(function(){
				var checkbox = $(".round-checkbox-input_input");

				var string_price = $(".carted-product_subtotal").text();
				string_price = string_price.split("원");
				
				var total_price = 0;
				
				/* 89~99 Line CheckAll when checking all checkbox */
				var check_select = 0;

				for(var i=1;i<checkbox.length;i++){
					if(checkbox[i].checked == false){
						$("#checkAll").prop("checked",false);
						check_select = 0 ;
					}
					if(checkbox[i].checked == true){
						check_select += 1;
					}
				}
				// If all checkbox are checked, 'all selected' checkbox checked.
				if(check_select == checkbox.length-1){
					$("#checkAll").prop("checked",true);
				}
				
				/* 105~133 Line Only checked checkbox will be reflected in total price */
				var total_delivery = 0;
				
				if(checkbox[0].checked == true){
					var delivery = $(".product-small-item_delivery").text();
					delivery = delivery.split("원");
					for(var i=0;i<checkbox.length-1;i++){
						if(isNaN(parseInt(delivery[i],10)) == true){
							delivery[i]=0;
						}
						total_price += parseInt(uncomma(string_price[i]));
						total_delivery += parseInt(delivery[i],10)
					}
				}else{
					for(var i=1;i<checkbox.length;i++){
						if(checkbox[i].checked == true){
							total_price += parseInt(uncomma(string_price[i-1]));
						}
					}

					total_delivery =  0;
					
					var delivery = $(".round-checkbox-input_input:checked").closest("article")
						.children(".product-small-item-clickable").children(".product-small-item_content")
						.children(".product-small-item_caption").children(".product-small-item_delivery").text().split(" 원 ");
					for(var i=0;i<delivery.length-1;i++){
						total_delivery += parseInt(delivery[i],10);
					}
				}
				
				//Setting price
				$(".summary_total-price").text(comma(total_price)+"원");
				$(".summary_delivery").text(comma(total_delivery)+"원");
				$(".summary_payment").text(comma(total_price+total_delivery)+"원");
			});
		});
		
		/* Reflect price when inventory changes */
		$(document).ready(function(){
			$(".form-control").change(function(){
				/* A product option price modify */
				var inventory = $(this).val();
				var price = $(this).closest("ul").closest("li").attr("data-value");
				
				var flag = productionOptionCheck($(this));
				
				if(flag >= inventory){
					var modify_price = comma(inventory * price);
					
					$(this).parent().parent().parent().children(".selling-option-item_price").children(".selling-option-item_price_number").text(modify_price);
					
					//A product total price modfiy
					var total = $(this).closest("ul").children("li").children("article").children("div").children("p").text();
					total = total.split("원");
					
					var total_price = 0;
					for(var i=0;i<total.length-1;i++){
						total_price += parseInt(uncomma(total[i]),10);
					}
					
					$(this).closest("ul").closest("article").children("div").children(".carted-product_subtotal").children("span").text(comma(total_price));
					
					//payment price modify
					total = $(".carted-product_subtotal").text();
					total = total.split("원");
					
					total_price = 0;
					for(var i=0;i<total.length-1;i++){
						total_price += parseInt(uncomma(total[i]),10);
					}
					var delivery = $(".summary_delivery").text();
					delivery = parseInt(uncomma(delivery.slice(0,-1)),10);

					//Setting
					$(".summary_total-price").text(comma(total_price)+"원");
					$(".summary_payment").text(comma(total_price + delivery)+"원");
				}else{
					$(this).val(flag);

					var modify_price = comma(flag * price);
					$(this).parent().parent().parent().children(".selling-option-item_price").children(".selling-option-item_price_number").text(modify_price);
					
					//A product total price modfiy
					var total = $(this).closest("ul").children("li").children("article").children("div").children("p").text();
					total = total.split("원");
					
					var total_price = 0;
					for(var i=0;i<total.length-1;i++){
						total_price += parseInt(uncomma(total[i]),10);
					}
					
					$(this).closest("ul").closest("article").children("div").children(".carted-product_subtotal").children("span").text(comma(total_price));
					
					//payment price modify
					total = $(".carted-product_subtotal").text();
					total = total.split("원");
					
					total_price = 0;
					for(var i=0;i<total.length-1;i++){
						total_price += parseInt(uncomma(total[i]),10);
					}
					var delivery = $(".summary_delivery").text();
					delivery = parseInt(uncomma(delivery.slice(0,-1)),10);

					//Setting
					$(".summary_total-price").text(comma(total_price)+"원");
					$(".summary_payment").text(comma(total_price + delivery)+"원");
					
					alert("선택한 수량이 재고보다 많습니다.");
				}
			});
		});
		
		/*Reflect inventory changes to db*/
		$(document).ready(function(){
			$(".form-control").change(function(){
				var cartno = $(this).closest("li").attr("cart-data")
				var pno = $(this).closest("ul").closest("article").children(".product-small-item-clickable").attr("data-number");
				var inventory = $(this).val();
				
				$.ajax({
					url : "/WiShopping/cart/cartUpdate",
					type : "post",
					data : {
						cartno : cartno,
						pno : pno,
						inventory : inventory
					},success : function(result){
						if(result == 0){
							location.href="/WiShopping/error";
						}
					}
				});
			})
		});
		
		/* Delete product in cart */
		$(document).ready(function(){			
			$(".carted-product_delete").click(function(){
				var confirm_val = confirm("선택한 상품을 삭제하시겠습니까?");
				
				if(confirm_val){
					var checkArray = new Array();
					
					checkArray.push($(this).closest("article").children("a").attr("data-number"));
					
					$.ajax({
						url : "/WiShopping/cart/cartRemove",
						type : "post",
						data : {checkArray : checkArray},
						success : function(result){
							if(result==1){
								location.href="/WiShopping/cart/main";	
							}else{
								location.href="/WiShopping/error";
							}
						}
					});
				}
			});
		});
		
		/*Delete all selected carts*/
		$(document).ready(function(){
			$(".commerce-cart_header_delete").click(function(){
				var confirm_val = confirm("선택한 상품(들)을 삭제하시겠습니까?");
				
				if(confirm_val){
					var checkArray = new Array();
					
					$("input:checkbox[name='product_check']:checked").each(function(){
						checkArray.push($(this).attr("data-no"));
					});
					
					$.ajax({
						url : "/WiShopping/cart/cartRemove",
						type : "post",
						data : {checkArray : checkArray},
						success : function(result){
							if(result==1){
								location.href="/WiShopping/cart/main";	
							}else{
								location.href="/WiShopping/error";
							}
						}
					});
				}
			});
		});
		
		//Delete product option in cart
		$(document).on("click",".selling-option-item_delete",function(){				
			var cartno = $(this).closest("li").attr("cart-data");
						
			$.ajax({
				url : "/WiShopping/cart/cartOptionRemove",
				type : "post",
				data : {cartno : cartno},
				success : function(result){
					if(result == 0)	location.href = "/WiShopping/error";
					if(result == 1) location.href = "/WiShopping/cart/main";
				}
			});
		});
		
		//Checkout product to order
		$(document).ready(function(){
			$(".commerce-cart_side-bar_order_btn").click(function(){
				var check_count = $("input:checkbox[name='product_check']:checked").length;
				
				if(check_count == 0 ){
					alert("선택한 상품이 없습니다.");
				}else{
					var option = $("input:checkbox[name='product_check']:checked").closest("article")
					.children(".carted-product_option-list").children(".carted-product_option-list_item");

					var ono = new Array();
					
					$.each(option,function(){
						ono.push($(this).attr("data-number"));
					});
					
					var number = "";
					var input = $(".form-control");
					for(var i=0;i<input.length;i++){
						number = number + input[i].value +";";
					}
					
					$.ajax({
						url : "/WiShopping/order/order_request",
						type : "post",
						data : {ono : ono,
								number : number		
						},success : function(result){
							if(result == 1)	location.href="/WiShopping/order/pre_order"; 
							else location.href="/WiShopping/error";
						}
					});
				}
			});
		});
		
		//When Direct order btn clicked
		$(document).ready(function(){
			$(".carted-product_order-btn").click(function(){
				var option = $(this).closest("article").children(".carted-product_option-list").children("li");
				
				var ono = new Array();
				var number = "";
				
				$.each(option, function(){
					ono.push($(this).attr("data-number"));
					
					var input = $(this).children().children(".selling-option-item_controls").children(".selling-option-item_quantity").children().children("select");
					number += input.val() + ";";
				});
				
				$.ajax({
					url : "/WiShopping/order/order_request",
					type : "post",
					data : {ono : ono,
							number : number		
					},success : function(result){
						if(result == 1)	location.href="/WiShopping/order/pre_order"; 
						else location.href="/WiShopping/error";
					}
				});
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<c:if test="${empty cartList}">
		<div class="commerce-cart-empty">
			<div class="commerce-cart-empty_content">
				<img class="commerce-cart-empty_content_image" src="${pageContext.request.contextPath}/resources/image/cart-empty-placeholder.png" alt="장바구니가 비었습니다.">
				<a class="button button-color-blue commerce-cart-empty_content_button" href="${pageContext.request.contextPath}/category/group/list?category1=1">상품 담으러 가기</a>
			</div>
		</div>
	</c:if>
	<c:if test="${!empty cartList}">
		<div class="layout">
			<div class="commerce-cart-wrap">
				<div class="container">
					<div class="commerce-cart row">
						<div class="commerce-cart_content-wrap">
							<div class="commerce-cart_content">
								<div class="sticky-container commerce-cart_header-wrap">
									<div class="sticky-child commerce-cart_header" style="position:relative;">
										<span class="commerce-cart_header_left">
											<div class="round-checkbox-input round-checkbox-input-blue">
												<label class="round-checkbox-input_label">
													<input type="checkbox" class="round-checkbox-input_input" id="checkAll" checked>
													<span class="round-checkbox-input_icon">
														<svg class="check" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
															<path fill="#FFF" d="M9.9 14.6l7-7.3 1.5 1.4-8.4 8.7-5-4.6 1.4-1.5z"></path>
														</svg>
													</span>
													<span class="caption"></span>
												</label>
											</div>
										</span>
										<span class="commerce-cart_header_right">
											<button class="commerce-cart_header_delete" type="button">선택삭제</button>
										</span>
									</div>
								</div>
								<ul class="commerce-cart_content_group-list">
									<c:forEach var="cart" items="${cartList}" varStatus="status">
										<c:if test="${cart.pno ne equal}">
											<li class="commerce-cart_content_group-item">
												<article class="commerce-cart_group">
													<h1 class="commerce-cart_group_header">${cart.brand}<!--  --> 배송</h1>
													<ul class="commerce-cart_group_item-list">
														<li class="commerce-cart_group_item">
															<article class="commerce-cart_delivery-group">
																<ul class="commerce-cart_delivery-group_product_list">
																	<li class="commerce-cart_delivery-group_product-item" data-value="${cart.price}">
																		<article class="carted-product">
																			<div class="round-checkbox-input round-checkbox-input-blue carted-product_select">
																				<label class="round-checkbox-input_label">
																					<input type="checkbox" class="round-checkbox-input_input" name="product_check" data-no="${cart.pno}" data-cartno="${cart.cartno}" checked>
																					<span class="round-checkbox-input_icon">
																						<svg class="check" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
																							<path fill="#FFF" d="M9.9 14.6l7-7.3 1.5 1.4-8.4 8.7-5-4.6 1.4-1.5z"></path>
																						</svg>
																					</span>
																				</label>
																			</div>
																			<a class="product-small-item product-small-item-clickable" href="${pageContext.request.contextPath}/productions/${cart.pno}" data-number="${cart.pno}">
																				<div class="product-small-item_image">
																					<img src="${pageContext.request.contextPath}${cart.productthumurl}">
																				</div>
																				<div class="product-small-item_content">
																					<h1 class="product-small-item_title">[${cart.brand}] ${cart.pname}</h1>
																					<p class="product-small-item_caption">
																						<c:if test="${cart.shippingfee eq 0 }">무료배송 </c:if>
																						<span class="product-small-item_delivery"><c:if test="${cart.shippingfee ne 0 }">${cart.shippingfee} 원 </c:if></span>| 일반택배
																					</p>
																				</div>
																			</a>
																			<button type="button" class="carted-product_delete" aria-label="삭제">
																				<svg width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
																					<path fill-rule="nonzero" d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path>
																				</svg>
																			</button>
																			<ul class="carted-product_option-list">
																				<c:forEach var="option" items="${cartOption}">
																				<c:if test="${option.pno eq cart.pno}">
																					<li class="carted-product_option-list_item" data-number="${option.ono}" cart-data="${option.cartno}">
																						<article class="selling-option-item">
																							<h1 class="selling-option-item_name" data-number="${option.ono}">${option.optioncolor}/${option.optionsize}</h1>
																							<button class="selling-option-item_delete" type="button" aria-label="삭제">
																								<svg width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
																									<path fill-rule="nonzero" d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path>
																								</svg>
																							</button>
																							<div class="selling-option-item_controls">
																								<div class="selling-option-item_quantity">
																									<div class="input-group select-input option-count-input">
																										<select name="stock" class="form-control">
																											<option value="1"<c:if test="${option.inventory eq 1}">selected</c:if>>1</option>
																											<option value="2"<c:if test="${option.inventory eq 2}">selected</c:if>>2</option>
																											<option value="3"<c:if test="${option.inventory eq 3}">selected</c:if>>3</option>
																											<option value="4"<c:if test="${option.inventory eq 4}">selected</c:if>>4</option>
																											<option value="5"<c:if test="${option.inventory eq 5}">selected</c:if>>5</option>
																											<option value="6"<c:if test="${option.inventory eq 6}">selected</c:if>>6</option>
																											<option value="7"<c:if test="${option.inventory eq 7}">selected</c:if>>7</option>
																											<option value="8"<c:if test="${option.inventory eq 8}">selected</c:if>>8</option>
																											<option value="9"<c:if test="${option.inventory eq 9}">selected</c:if>>9</option>
																											<option value="10"<c:if test="${option.inventory eq 10}">selected</c:if>>10</option>
																										</select>
																										<span class="select-input_icon">
																											<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;">
																												<path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path>
																											</svg>
																										</span>
																									</div>
																								</div>
																								<p class="selling-option-item_price">
																									<span class="selling-option-item_price_number"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cart.price * option.inventory}"/></span> 원
																								</p>
																							</div>
																						</article>
																					</li>
																				</c:if>
																				</c:forEach>
																			</ul>
																			<div class="carted-product_footer">
																				<span class="carted-product_footer_left">
																					<button class="carted-product_order-btn" type="button">바로구매</button>
																				</span>
																				<span class="carted-product_subtotal">
																					<c:set var="total_price" value="0"/>
																					<!-- Total Price Calculation -->
																					<c:forEach var="price" items="${cartOption}">
																						<c:if test="${cart.pno eq price.pno}">
																							<c:set var="total_price" value="${total_price + price.inventory * cart.price}"/>
																						</c:if>
																					</c:forEach>
																					<span class="carted-product_subtotal_number"><fmt:formatNumber type="number" maxFractionDigits="3" value="${total_price}"/></span>원
																				</span>
																			</div>
																		</article>
																	</li>
																</ul>
																<footer class="commerce-cart_delivery-group_footer">
																	<p class="commerce-cart_delivery-group_total">배송비 <c:if test="${cart.shippingfee eq 0 }">무료</c:if><c:if test="${cart.shippingfee ne 0 }"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cart.shippingfee}"/>원</c:if></p>
																</footer>
															</article>
														</li>
													</ul>
												</article>
											</li>
										</c:if>
										<c:set var="equal" value="${cart.pno}"></c:set>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="commerce-cart_side-bar-wrap">
							<div class="sticky-container commerce-cart_side-bar-container" style="position:sticky; top:-1px;">
								<div class="sticky-child commerce-cart_side-bar" style="position:relative;">
									<dl class="commerce-cart_summary">
										<div class="commerce-cart_summary_row">
											<dt>총 상품금액</dt>
											<dd><span class="number summary_total-price">0원</span></dd>
										</div>
										<div class="commerce-cart_summary_row">
											<dt>배송비</dt>
											<dd>+ <span class="number summary_delivery">0원</span>
										</div>
										<div class="commerce-cart_summary_row">
											<dt>총 할인금액</dt>
											<dd>- <span class="number summary_discount-price">0원</span></dd>
										</div>
										<div class="commerce-cart_summary_row commerce-cart_summary_row-total">
											<dt>결제금액</dt>
											<dd><span class="number summary_payment">0원</span></dd>
										</div>
									</dl>
									<div class="commerce-cart_side-bar_order">
										<button class="button button-color-blue commerce-cart_side-bar_order_btn" type="button"></button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	<jsp:include page="../footer.jsp"/>
</body>
</html>