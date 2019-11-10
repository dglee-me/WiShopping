<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/productView.css?after">
	<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/productions.js" async></script>
	
	<script>
		$(document).ready(function(){
			$(document).on("click",".cart",function(){
				var cartsize = $('.prdprice_left').text().charAt(0);
				var cartstock = $('.ipt_count_chk').val();
				
				
				if(cartstock == null){
					alert("사이즈를 선택하여 주세요. :x")
				}else{
					var url = location.href;
					var pno = url.slice(url.indexOf('=') + 1);
					
					
					var data = {
							cartsize : cartsize,
							cartstock : cartstock,
							pno : pno
					};
					
					$.ajax({
						url : "/myapp/cart/addCart",
						type : "post",
						data : data,
						success : function(result){
							if(result == 1){
								alert("장바구니에 상품을 담았습니다.");
							}else{
								alert("회원만 담을 수 있습니다.");
							}
						},
						error : function(){
							alert("삐이");
						}
					});
				}
			});
		});
	</script>
	
	<meta charset="UTF-8">
	<title>위쇼핑! - ${product.pname}</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="product_selling">
			<div class="container">
				<h2 class="hide">컨텐츠 영역</h2>
				<nav class="product_selling_category">
					<ul>
						<li class="commerce-category-list"><a href="${pageContext.request.contextPath}/">홈</a></li>
						<li class="commerce-category-list"><a href="javascript:void(0);">${product.category1}</a></li>
						<li class="commerce-category-list"><a href="javascript:void(0);">${product.category2}</a></li>
					</ul>
				</nav>
				<div class="container_inner">
					<div class="contents_wrap">
						<div class="content_main">
							<div class="info_box">
								<div class="info_thumnail">
									<div>
										<div class="info_img_wrap">
											<img src="${pageContext.request.contextPath}/${product.product_thumurl}" style="display:block;">
										</div>
									</div>
								</div>
								<div class="info_description">
									<div class="info_product">
										<h1 class="product_header-title">
											<p class="product_header-title-brand-wrap"><a href="javascript:void(0);">${product.brand}</a></p>
											<span class="product_header-title-name">${product.pname}</span>
										</h1>
										<div class="price">
											<div class="sale_box">
												<strong class="sale_price"><em class="num" id="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/></em>원
												</strong>
											</div>
										</div>
										<div class="info_price_wrap">
											<dl class="info_price shipping">
												<dt class="ico">배송</dt>
												<dd>
													<p class="shipping"><c:if test="${product.shipping eq '0'}">무료배송</c:if><c:if test="${product.shipping ne '0'}">${product.shipping}원</c:if></p>
													<p class="today">
														<span class="color_blue">상품별배송</span>
														<span class="line">ㅣ</span>
														<span class="post">택배배송<span class="line">ㅣ</span>${product.shippingday}일 이내 출고</span>
														<span class="text_etc">(주말, 공휴일 제외)</span>
													</p>
												</dd>
											</dl>
										</div>
										<div class="box_optarea">
											<label><span>Size</span></label>
											<div class="box_size_opt">
												<c:if test="${product.free eq 0 }">
													<div class="sel" id="select_s"><a href="javascript:void(0);">S size</a></div>
													<div class="sel" id="select_m"><a href="javascript:void(0);">M size</a></div>
													<div class="sel" id="select_l"><a href="javascript:void(0);">L size</a></div>
												</c:if>
												<c:if test="${product.free ne 0 }">
													<div class="sel" id="select_free"><a href="javascript:void(0);">FREE</a></div>
												</c:if>
											</div>
											<div class="optselect_area">
												<ul id="_optionSelectList" class="opt_selectlist">
												</ul>
											</div>
										</div>
									</div>
									<div class="info_product wrap_button">
										<div class="button_box">
											<a href="javascript:void(0);" class="btn_sys big_xl cart"><span>장바구니</span></a>
											<a href="javascript:void(0);" class="btn_sys red_big_xb bui" onclick="document.getElementById('frm').submit()"><span>구매하기</span></a>
										</div>
									</div>
								</div>
							</div>
							<div class="info_itemdetail" style="height:2500px;">
								<div class="sticky-container product_selling_nav_wrap">
									<div class="sticky-child product_selling_nav">
										<nav class="product_selling_nav_content">
											<ol class="product_selling_nav_content-list">
												<li><a href="javascript:void(0);" class="product_selling_nav_item product_selling_nav_item-active">상품정보</a></li>
												<li><a href="javascript:void(0);" class="product_selling_nav_item">리뷰</a></li>
												<li><a href="javascript:void(0);" class="product_selling_nav_item">문의</a></li>
												<li><a href="javascript:void(0);" class="product_selling_nav_item">배송/환불</a></li>
											</ol>
										</nav>
									</div>
								</div>
								<div class="item_desc">
									<div class="prd_detail cut view">
										<div id="productdetails" class="tab_conts">
											<div class="deal_detailimg">
												<p>
													<img src="${pageContext.request.contextPath}/${product.product_url}">
												</p>
											</div>
										</div>
										<div class="product_selling_section">
											<header class="product_selling_section-header">
												<h1 class="product_selling_section-header-title">리뷰<span class="count">0</span></h1>
												<div class="product_selling_section-right"><button type="button">리뷰쓰기</button></div>
											</header>
										</div>
									</div>	
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>