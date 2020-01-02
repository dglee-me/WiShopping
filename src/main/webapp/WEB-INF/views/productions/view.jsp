<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js" async></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	var previous;
	
	//If this product is a single option, reflect total price
	$(document).ready(function(){
		var price = parseInt($(".selling-option-item_price_number").text(),10);
		
		if(!isNaN(price)){
			$(".selling-option-form-content_price_number").text(comma(price));
		}
	});
	
	$(document).ready(function(){
		//If you select option, present this
		$(document).on("change",".form-control",function(){
			var select_text = $(".form-control option:checked").text();
			var select_ono = $(".form-control option:checked").attr("data-number");
			var option_arr = $(".selling-option-item_name").text().split(" ");
			var flag = true;
			
			for(var i=0;i<option_arr.length;i++){
				if(select_text == option_arr[i]){
					alert("이미 선택한 옵션입니다.");

					$(".form-control option:eq(0)").prop("selected",true);
					
					flag = false;
					break;
				}
			}
			
			if(flag == true){
				var option_li = document.createElement("li");
				option_li.innerHTML = 
					"<article class='selling-option-item'>"
					+"<h1 class='selling-option-item_name' data-number='"+select_ono+"'>"+select_text+" "+"</h1>" //The reason for adding " " is because it splits above to compare option duplication.
					+"<button type='button' class='selling-option-item_delete' label='삭제'>"
					+"<svg width='12' height='12' viewBox='0 0 12 12' fill='currentColor' preserveAspectRatio='xMidYMid meet'>"
					+"<path fill-rule='nonzero' d='M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z'></path></svg>"
					+"</button>"
					+"<div class='selling-option-item_controls'>"
					+"<div class='selling-option-item_inventory'>"
					+"<div class='input-group select-input option-count-input'>"
					+"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" 
					+"\<input type='text' class='ipt_count_chk' value='1'>"
					+"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" 
					+"</div>"
					+"<p class='selling-option-item_price'>"
					+"<span class='selling-option-item_price_number'>"+$("#price").text()+" "+"</span>"+" 원"+"</p>"
					+"</article>"
				
				$(".selling-option-form-content_list").append(option_li);
				$(".form-control option:eq(0)").prop("selected",true);
				
				//Set total order amount
				var price = $(".selling-option-item_price_number").text().split(" ");
				var total_price = 0;
				
				for(var i=0;i<price.length;i++){
					if(price[i] == ""){
						continue;
					}
					price[i] = uncomma(price[i]) * 1;
					total_price += price[i];
				}
				$(".selling-option-form-content_price_number").text(comma(total_price));
			}
		});
		
		/*Count num ++ event*/
		$(document).ready(function(){
			$(document).on("click",".up_count",function(){				
				var count = parseInt($(this).parent().children(".ipt_count_chk").val(),10);

				var totalPrice = parseInt(uncomma($(".selling-option-form-content_price_number").text()),10);
				var optPrice = parseInt(uncomma($('#price').text()),10);
									
				
				var flag = productionOptionCheck($(this).parent().children(".ipt_count_chk"));
				
				if(flag > count){
					$(this).parent().children(".ipt_count_chk").val(++count);
					$(this).closest("article")
						.children(".selling-option-item_controls")
						.children(".selling-option-item_price")
						.children(".selling-option-item_price_number").text(comma(optPrice*count)+" ");
					
					//Set total order amount
					var price = $(".selling-option-item_price_number").text().split(" ");
					var total_price = 0;
					
					for(var i=0;i<price.length;i++){
						if(price[i] == ""){
							continue;
						}
						price[i] = uncomma(price[i]) * 1;
						total_price += price[i];
					}
					$(".selling-option-form-content_price_number").text(comma(total_price));
				}else{
					alert("선택한 수량이 재고보다 많습니다!");
				}
			});
		});
		
		/*Count num -- event*/
		$(document).ready(function(){
			$(document).on("click",".down_count",function(){
				var count = parseInt($(this).parent().children(".ipt_count_chk").val(),10);
				var optPrice = parseInt(uncomma($('#price').text()),10);
				
				if(count == 0){
					alert("품절된 상품입니다.");
					count = 1;
				}else if(count == 1){
					alert("수량을 더 내릴 수 없습니다.");
					count = 2;
				}

				$(this).parent().children(".ipt_count_chk").val(--count);
				$(this).closest("article")
					.children(".selling-option-item_controls")
					.children(".selling-option-item_price")
					.children(".selling-option-item_price_number").text(comma(optPrice*count)+" ");
				
				//Set total order amount
				var price = $(".selling-option-item_price_number").text().split(" ");
				var total_price = 0;
				
				for(var i=0;i<price.length;i++){
					if(price[i] == ""){
						continue;
					}
					price[i] = uncomma(price[i]) * 1;
					total_price += price[i];
				}
				$(".selling-option-form-content_price_number").text(comma(total_price));
			});
		});
	
		//If the selected option is out of stock
		$(document).on("focus",".ipt_count_chk",function(){
			previous = this.value;	
		});
		$(document).on("change",".ipt_count_chk",function(){
			direct_productionOptionCheck($(this));
		});
		
		//Delete select option
		$(document).on("click",".selling-option-item_delete",function(){
			$(this).closest("li").remove();
			
			//Set total order amount
			var price = $(".selling-option-item_price_number").text().split(" ");
			var total_price = 0;
			
			for(var i=0;i<price.length;i++){
				if(price[i] == ""){
					continue;
				}
				price[i] = uncomma(price[i]) * 1;
				total_price += price[i];
			}
			$(".selling-option-form-content_price_number").text(comma(total_price));
		});
		
		//If you modified the input box of the option
		$(document).on("change",".ipt_count_chk",function(){
			var count = $(this).val();
			var price = uncomma($("#price").text());

			$(this).parent().parent().parent().children(".selling-option-item_price").children(".selling-option-item_price_number").text(comma(price*count));
		})
		
		//add to cart
		$(document).on("click",".cart",function(){
			var selected = $(".selling-option-item_name").text().split(" ");
			
			if(selected.length == 1 && selected[0] == ""){
				alert("상품을 선택하여 주세요.");
			}else{
				var ono = new Array();
				var option = $(".selling-option-item_name");
				
				$.each(option,function(){
					var option_number = $(this).attr("data-number");
					ono.push(option_number);
				});
				
				var number = "";
				var input = $(".ipt_count_chk");
				for(var i=0;i<input.length;i++){
					number = number + input[i].value +";";
				}
				
				$.ajax({
					url : "/myapp/cart/addCart",
					type : "post",
					data : {ono : ono,
							number : number
					},success : function(result){
						if(result == 1){
							alert("장바구니에 상품을 담았습니다. :)");
						}else{
							alert("회원만 담을 수 있습니다.");
						}
					},error : function(){
						alert("다시 시도해주세요.");
						location.href="/myapp/error";
					}
				});
			}
		});
	});
	
	$(document).ready(function(){
		$(".buy").click(function(){
			var selected = $(".selling-option-item_name");
			
			if(selected.length == 0){
				alert("상품 옵션을 선택하여 주세요.");
			}else{
				var ono = new Array();
				
				$.each(selected,function(){
					ono.push($(this).attr("data-number"));							
				});
				
				var number = "";
				var input = $(".ipt_count_chk");
				for(var i=0;i<input.length;i++){
					number = number + input[i].value +";";
				}
				
				$.ajax({
					url : "/myapp/order/order_request",
					type : "post",
					data : {ono : ono,
							number : number
					},success : function(result){
						if(result == 1){
							location.href="/myapp/order/pre_order";
						}else if(result == 2){
							alert("로그인 후 이용해주세요!");
							location.href="/myapp/auth/login";
						}else{
							location.href="/myapp/error";
						}
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
		<div class="production-selling">
			<div class="production-selling-overview container">
				<h2 class="hide">컨텐츠 영역</h2>
				<nav class="product-selling-category">
					<ul class="product-selling-category_breadcrumb">
						<li class="commerce-category-list"><a href="${pageContext.request.contextPath}/">홈</a></li>
						<li class="commerce-category-list">
							<c:if test="${product.category1 eq '패션'}"><a href="${pageContext.request.contextPath}/category/group/fashion">${product.category1}</a></c:if>
							<c:if test="${product.category1 eq '잡화'}"><a href="${pageContext.request.contextPath}/category/group/accessories">${product.category1}</a></c:if>
							<c:if test="${product.category1 eq '인테리어'}"><a href="${pageContext.request.contextPath}/category/group/interior">${product.category1}</a></c:if>
							<c:if test="${product.category1 eq '가전·디지털'}"><a href="${pageContext.request.contextPath}/category/group/digital">${product.category1}</a></c:if>
						</li>
						<li class="commerce-category-list"><a href="javascript:void(0);">${product.category2}</a></li>
					</ul>
				</nav>
				<div class="product-selling-overview_container row">
					<div class="product-selling-overview_cover-image-wrap">
						<div class="product-selling-overview_cover-image">
							<div class="product-selling_cover-image-wrap">
								<div class="product-selling_cover-image_entry">
									<img src="${pageContext.request.contextPath}${product.productthumurl}" class="product-selling_cover-image_entry_image">
								</div>
							</div>							
						</div>
					</div>
					<div class="product-selling-overview_content">
						<div class="production-selling-header">
							<h1 class="production-selling-header_title">
								<p class="production-selling-header_title_brand-wrap">
									<a href="javascript:void(0);" class="production-selling-header_title_brand">${product.brand}</a>
								</p>
								<span class="production-selling-header_title_name">${product.pname}</span>
							</h1>
							<div class="production-selling-header_content">
								<p class="production-selling-header_content_price">
									<span class="production-selling-header_content_price_row">
										<span class="production-selling-header_content_price_discount">
											<span class="number">00</span>
											<span class="percent">%</span>
										</span>
										<span class="production-selling-header_price_pirce-wrap">
											<del class="production-selling-header_price_original">
												<span class="number"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/></span>
												<span class="won">원</span>
											</del>
											<span class="production-selling-header_price_price">
												<span class="number" id="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/></span>
												<span class="won">원</span>
											</span>
										</span>
									</span>
								</p>
								<p class="production-selling-header_delivery">
									<span class="production-selling-header_delivery_type">
										<span>일반택배</span>
									</span>
									<span class="production-selling-header_delivery_fee">
										<c:if test="${product.shippingfee eq 0}">무료배송</c:if>
										<c:if test="${product.shippingfee ne 0}"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.shippingfee}"/>원</c:if>
									</span>
									<span class="production-selling-header_delivery_disclaimer-wrap">
										<span class="production-selling-header_delivery_disclaimer">조건에 따라 추가비용 발생 가능 (상품 상세 정보 참고)</span>
									</span>
								</p>
							</div>
						</div>
						<div class="production-selling-option-form production-selling-overview_option-form">
							<section class="selling-option-form-content">
								<div class="selling-option-form-content_contents">
									<div class="selling-option-select-input">
										<c:if test="${max ne 1}">
										<div class="input-group select-input selling-option-select-input_option">
											<select class="form-control empty">
												<option selected value disabled>옵션 선택</option>
												<c:forEach items="${option}" var="option">
													<c:if test="${option.inventory ne 0}">
														<option data-number ="${option.ono}" value="${option.sequence}">${option.optioncolor}/${option.optionsize}</option>
													</c:if>
													<c:if test="${option.inventory eq 0}">
														<option data-number ="${option.ono}" value="${option.sequence}" disabled>${option.optioncolor}/${option.optionsize}(품절)</option>
													</c:if>
												</c:forEach>
											</select>
											<span class="select-input_icon">
												<svg class="icon" width="10" height="10" style="fill:currentColor" preserveAspectRatio="xMidYMid meet">
													<path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path>
												</svg>
											</span>
										</div>
										</c:if>
									</div>
								</div>
								<ul class="selling-option-form-content_list">
									<c:if test="${max eq 1}"> 
										<li>
											<article class="selling-option-item">
												<c:forEach items="${option}" var="option">
													<c:if test="${option.inventory > 0}">
														<h1 class="selling-option-item_name" data-number="${option.ono}">${option.optioncolor}/${option.optionsize}</h1>
														<div class="selling-option-item_controls">
															<div class="selling-option-item_inventory">
																<div class="input-group select-input option-count-input">
																	<a href="javascript:void(0);" class="ico down_count on">-감소</a>
																	<input type="text" class="ipt_count_chk" value="1">
																	<a href="javascript:void(0);" class="ico up_count on">+증가</a></div>
																</div>
															<p class="selling-option-item_price">
																<span class="selling-option-item_price_number">${product.price}</span>원
															</p>
														</div>
													</c:if>
													<c:if test="${option.inventory <= 0}">
														<h1 class="selling-option-item_name" data-number="${option.ono}">${option.optioncolor}/${option.optionsize}</h1>
														<div class="selling-option-item_controls">
															<div class="selling-option-item_inventory">
																<div class="input-group select-input option-count-input">
																	<a href="javascript:void(0);" class="ico down_count on">-감소</a>
																	<input type="text" class="ipt_count_chk" value="0">
																	<a href="javascript:void(0);" class="ico up_count on">+증가</a></div>
																</div>
															<p class="selling-option-item_price">
																<span class="selling-option-item_price_number">0 </span>원
															</p>
														</div>
													</c:if>
												</c:forEach>
											</article>
										</li>
									</c:if>
								</ul>
								<p class="selling-option-form-content_price">
									<span class="selling-option-form-content_price_left">주문금액</span>
									<span class="selling-option-form-content_price_right">
										<span class="selling-option-form-content_price_number">0</span>원
									</span>
								</p>
							</section>
							<div class="production-selling-option-form_footer">
								<button type="button" class="button button-color-blue-inverted button-size-55 button-shape-4 cart">장바구니</button>
								<button type="button" class="button button-color-blue button-size-55 button-shape-4 buy">바로구매</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="sticky-container production-selling-navigation-wrap">
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
			<div class="production-selling_detail-wrap container">
				<div class="item_desc">
					<div class="prd_detail cut view">
						<div id="productdetails" class="tab_conts">
							<div class="deal_detailimg">
								<p>
									<c:forEach var="image" items="${image}">
										<img src="${pageContext.request.contextPath}${image}">
									</c:forEach>
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
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>