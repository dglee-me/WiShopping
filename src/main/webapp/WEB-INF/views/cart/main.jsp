<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>위쇼핑! - 장바구니</title>
	<script type="text/javascript">
		$(document).ready(function(){			
			$("#checkAll").click(function(){
				if($("#checkAll").prop("checked")){
					$(".round-checkbox-input_input").prop("checked",true);
				}else{
					$(".round-checkbox-input_input").prop("checked",false);
				}
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
				<a class="button button-color-blue commerce-cart-empty_content_button" href="${pageContext.request.contextPath}/category/group/fashion">상품 담으러 가기</a>
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
													<span class="caption">모두선택 (${cart.count}개)</span>
												</label>
											</div>
										</span>
										<span class="commerce-cart_header_right">
											<button class="commerce-cart_header_delete" type="button">선택삭제</button>
										</span>
									</div>
								</div>
								<ul class="commerce-cart_content_group-list">
									<c:forEach var="cart" items="${cartList}">
										<li class="commerce-cart_content_group-item">
											<article class="commerce-cart_group">
												<h1 class="commerce-cart_group_header">${cart.brand}<!--  --> 배송</h1>
												<ul class="commerce-cart_group_item-list">
													<li class="commerce-cart_group_item">
														<article class="commerce-cart_delivery-group">
															<ul class="commerce-cart_delivery-group_product_list">
																<li class="commerce-cart_delivery-group_product-item">
																	<article class="carted-product">
																		<div class="round-checkbox-input round-checkbox-input-blue carted-product_select">
																			<label class="round-checkbox-input_label">
																				<input type="checkbox" class="round-checkbox-input_input" checked>
																				<span class="round-checkbox-input_icon">
																					<svg class="check" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
																						<path fill="#FFF" d="M9.9 14.6l7-7.3 1.5 1.4-8.4 8.7-5-4.6 1.4-1.5z"></path>
																					</svg>
																				</span>
																			</label>
																		</div>
																		<a class="product-small-item product-small-item-clickable" href="${pageContext.request.contextPath}/productions/view?pno=${cart.pno}">
																			<div class="product-small-item_image">
																				<img src="${pageContext.request.contextPath}${cart.product_thumurl}">
																			</div>
																			<div class="product-small-item_content">
																				<h1 class="product-small-item_title">[${cart.brand}] ${cart.pname}</h1>
																				<p class="product-small-item_caption">
																					<c:if test="${cart.shipping eq 0 }">무료배송 </c:if>
																					<c:if test="${cart.shipping ne 0 }">${cart.shipping } 원 </c:if>| 일반택배
																				</p>
																			</div>
																		</a>
																		<button type="button" class="carted-product_delete" aria-label="삭제">
																			<svg width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
																				<path fill-rule="nonzero" d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path>
																			</svg>
																		</button>
																		<ul class="carted-product_option-list">
																			<li class="carted-product_option-list_item">
																				<article class="selling-option-item">
																					<h1 class="selling-option-item_name">${cart.cartsize}</h1>
																					<button type="button" class="selling-option-item_delete" aria-label="삭제">
																						<svg width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
																							<path fill-rule="nonzero" d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path>
																						</svg>
																					</button>
																					
																					<div class="selling-option-item_controls">
																						<div class="selling-option-item_quantity">
																							<div class="input-group select-input option-count-input">
																								<select class="form-control">
																									<option value="0">1</option>
																									<option value="1">2</option>
																									<option value="2">3</option>
																									<option value="3">4</option>
																									<option value="4">5</option>
																									<option value="5">6</option>
																									<option value="6">7</option>
																									<option value="7">8</option>
																									<option value="8">9</option>
																									<option value="9">10+</option>
																								</select>
																								<span class="select-input_icon">
																									<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;">
																										<path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path>
																									</svg>
																								</span>
																							</div>
																						</div>
																						<p class="selling-option-item_price">
																							<span class="selling-option-item_price_number">${cart.price}</span>원
																						</p>
																					</div>
																					
																				</article>
																			</li>
																		</ul>
																		<div class="carted-product_footer">
																			<span class="carted-product_footer_left">
																				<button class="carted-product_edit-btn" type="button">옵션변경</button>
																				<button class="carted-product_order-btn" type="button">바로구매</button>
																			</span>
																			<span class="carted-product_subtotal">
																				<span class="carted-product_subtotal_number">${cart.price}</span>원
																			</span>
																		</div>
																	</article>
																</li>
															</ul>
															<footer class="commerce-cart_delivery-group_footer">
																<p class="commerce-cart_delivery-group_total">배송비 <c:if test="${cart.shipping eq 0 }">무료</c:if><c:if test="${cart.shipping ne 0 }">${cart.shipping}원</c:if></p>
															</footer>
														</article>
													</li>
												</ul>
											</article>
										</li>
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
											<dd><span class="number">1232141원</span></dd>
										</div>
										<div class="commerce-cart_summary_row">
											<dt>배송비</dt>
											<dd>+ <span class="number">12500원</span>
										</div>
										<div class="commerce-cart_summary_row">
											<dt>총 할인금액</dt>
											<dd>- <span class="number">1293821원</span></dd>
										</div>
										<div class="commerce-cart_summary_row commerce-cart_summary_row-total">
											<dt>결제금액</dt>
											<dd><span class="number">190238912원</span></dd>
										</div>
									</dl>
									<div class="commerce-cart_side-bar_order">
										<button class="button button-color-blue commerce-cart_side-bar_order_btn" type="button">0개 상품 구매하기</button>
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