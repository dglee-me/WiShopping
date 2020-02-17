<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
	var mno = "${login.mno}";
	
	//date format init
	function dateFormatTransfer(parameter){
		var date = new Date(parameter);
		
		var year = date.getFullYear();
		
		var month = (1 + date.getMonth());
		month = month >= 10 ? month : "0" + month;
		
		var day = date.getDate();
		day = day >= 10 ? day : "0" + day;
		
		var hour = date.getHours();
		hour = hour >= 10 ? hour : "0" + hour;
		
		var min = date.getMinutes();
		min = min >= 10 ? min : "0" + min;

		date = year + "년 " + month + "월 " +day + "일 " + hour + "시 " + min + "분";
		
		return date;
	}
	
	$(document).ready(function(){
		$(".product_selling_nav_content-list li").click(function(e){
			e.preventDefault();
			
			var nav = $(this).children().text();
			
			if(nav == "상품정보"){
				var href = $("#production-selling-information").offset();
				href.top -= 80;
			}else if(nav == "리뷰"){
				var href = $("#production-selling-review").offset();
				href.top -= 40;
			}else if(nav == "문의"){
				var href = $("#production-selling-question").offset();
				href.top -= 40;
			}else if(nav == "배송/환불"){
				var href = $("#production-selling-delivery").offset();
				href.top -= 40;
			}
			
			$("html, body").animate({scrollTop : href.top},300);
		});
	});
	
	//Change the active state to the corresponding Nav when scrolling
	$(window).scroll(function(){
		var $window = $(window);
		var $body = $("body");
		
		var scroll = $window.scrollTop() + ($window.height() / 3);
		
		var info = $("#production-selling-information").offset().top;
		var review = $("#production-selling-review").offset().top;
		var qna = $("#production-selling-question").offset().top;
		var delivery = $("#production-selling-delivery").offset().top;

		if(scroll >= info &&scroll <= review){
			$(".product_selling_nav_item-active").removeClass("product_selling_nav_item-active");
			$($(".product_selling_nav_item")[0]).addClass("product_selling_nav_item-active");
		}else if(scroll >= review && scroll <= qna){
			$(".product_selling_nav_item-active").removeClass("product_selling_nav_item-active");
			$($(".product_selling_nav_item")[1]).addClass("product_selling_nav_item-active");
		}else if(scroll >= qna && scroll <= delivery){
			$(".product_selling_nav_item-active").removeClass("product_selling_nav_item-active");
			$($(".product_selling_nav_item")[2]).addClass("product_selling_nav_item-active");
		}else if(scroll >= delivery){
			$(".product_selling_nav_item-active").removeClass("product_selling_nav_item-active");
			$($(".product_selling_nav_item")[3]).addClass("product_selling_nav_item-active");
		}
	});
	
	//If this product is a single option, reflect total price
	$(document).ready(function(){
		var price = parseInt(uncomma($(".selling-option-item_price_number").text()),10);
		
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
					url : "/WiShopping/cart/addCart",
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
						location.href="/WiShopping/error";
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
					url : "/WiShopping/order/order_request",
					type : "post",
					data : {ono : ono,
							number : number
					},success : function(result){
						if(result == 1){
							location.href="/WiShopping/order/pre_order";
						}else if(result == 2){
							alert("로그인 후 이용해주세요!");
							location.href="/WiShopping/auth/login";
						}else{
							location.href="/WiShopping/error";
						}
					}
				});
			}
		});
	});
	
	//image layer pop-up open when review image clicked
	$(document).on("click", ".production-review-item_img", function(){
		$("body").css("overflow-y","hidden");
		
		var img = $(this).attr("src");
		
		var div = document.createElement("div");
		div.className = "modal-root";
		div.innerHTML =
			"<div id='modal-image-modal_modal' class='modal modal-image-modal_modal'>"+
			"<div class='modal_dialog image-modal_modal_dialog'>"+
			"<img src='"+img+"'"+
			"</div>"+
			"</div>"+
			"<div class='modal_larg-close modal-image-modal_modal_large-close'>"+
			"<button class='modal_large-close_button' type='button'>"+
			"<svg width='20' height='20' viewBox='0 0 20 20' fill='currentColor' preserveAspectRatio='xMidYMid meet'>"+
			"<path fill-rule='nonzero' d='M11.6 10l7.1 7.1-1.6 1.6-7.1-7.1-7.1 7.1-1.6-1.6L8.4 10 1.3 2.9l1.6-1.6L10 8.4l7.1-7.1 1.6 1.6z'></path>"+
			"</svg></button></div>"
			
		$("body").append(div);
	});
	
	$(document).on("click",".modal_large-close_button",function(){
		$("body").css("overflow-y","scroll");
		$("#modal-image-modal_modal").remove();
	})
	
	//Delete review layer pop-up when click outside review area
	$(document).on("click","html",function(e){
		if($(e.target).hasClass("modal-image-modal_modal")){ // Image modal popup exit
			$("body").css("overflow-y","scroll");
			$("#modal-image-modal_modal").remove();
		}else if($(e.target).hasClass("popup-modal_content-wrap")){ // question modal popup exit
			var var_confirm = confirm("작성된 내용이 모두 유실됩니다.\n그래도 나가시겠습니까?");
			
			if(var_confirm){
				$("body").css("overflow-y","scroll");
				$(".popup-modal.open").remove();
			}
		}
	});
	
	//Right button clicked event
	$(document).ready(function(){
		$(".product_selling_section-right button").click(function(){
			var text = $(this).text();
			
			if(text == "리뷰쓰기"){//Review case
				alert("주문 목록에서 작성할 수 있습니다.");
				
				location.href="/WiShopping/purchase/list";
			}else if(text == "문의하기"){ // About case
				if(mno == ""){
					location.href = "/WiShopping/auth/login";
				}else{
					$("body").css("overflow-y","hidden");
					
					var div = document.createElement("div");
					div.className = "popup-modal product-question_modal open";
					
					div.innerHTML =
						"<div class='popup-modal_content-wrap'>"+
							"<div class='popup-modal_content product-question'>"+
								"<form class='product-question_wrap'>"+
									"<input type='hidden' name='member[number]' value='"+mno+"'>"+
									"<div class='product-question_wrap_close'>"+
										"<svg class='product-question_wrap_close_icon' width='20' height='20' viewBox='0 0 20 20' fill='currentColor' preserveAspectRatio='xMidYMid meet'>"+
										"<path fill-rule='nonzero' d='M11.6 10l7.1 7.1-1.6 1.6-7.1-7.1-7.1 7.1-1.6-1.6L8.4 10 1.3 2.9l1.6-1.6L10 8.4l7.1-7.1 1.6 1.6z'></path>"+
										"</svg>"+
									"</div>"+
									"<div class='product-question_wrap_title'>문의하기</div>"+
										"<div class='product-question_wrap_sub-title'>문의유형</div>"+
										"<div class='product-question_wrap_category-select'>"+
										"<div class='product-question_wrap_type-select_box product-question_wrap_type-select_box-select'>상품</div>"+
										"<div class='product-question_wrap_type-select_box'>배송</div>"+
										"<div class='product-question_wrap_type-select_box'>반품</div>"+
										"<div class='product-question_wrap_type-select_box'>교환</div>"+
										"<div class='product-question_wrap_type-select_box'>환불</div>"+
										"<div class='product-question_wrap_type-select_box'>기타</div>"+
									"</div>"+
									"<div class='product-question_wrap_sub-title'>문의내용</div>"+
									"<textarea placeholder='문의 내용을 입력하세요' maxlength='1000' class='form-control product-question_wrap_question' style='height:auto;'></textarea>"+
									"<div class='form-check checkbox-input product-question_checkbox'>"+
										"<label class='form-check-label'><input class='form-check' type='checkbox'><span class='check-img'></span>비밀글로 문의하기</label>"+
									"</div>"+
									"<div class='product-question_wrap_explain'>문의내용에 대한 답변은 ‘상품 상세페이지’에서 확인 가능합니다.</div>"+
									"<div class='product-question_wrap_buttons'>"+
										"<button class='button button-color-blue product-question_wrap_buttons_submit' type='button'>완료</button>"+
									"</div>"+
								"</form>"+
							"</div>"+
						"</div>"

					$("body").append(div);
				}
			}
		});
	});
	
	//When review like btn clicked
	$(document).on("click",".production-review-item_like_btn",function(){
		var button = $(this);
		
		var like = $(this).siblings().children("span");
		
		var rno = $(this).closest("article").attr("data-number");

		$.ajax({
			url : "/WiShopping/productions/review_like",
			type : "post",
			data : {rno : rno},
			success : function(result){
				if(result == 0) location.href = "/WiShopping/auth/login";
				else if(result == 1){
					//When like complete
					button.addClass("production-review-item_like_btn-active");
					like.text(parseInt(like.text(),10)+1);
				}else if(result == 2){
					//When like cancel
					button.removeClass("production-review-item_like_btn-active");
					like.text(like.text()-1);
				}
			}
		});
	});
	
	//Prev button click event
	$(document).on("click",".list-paginator_prev",function(){
		var url = decodeURI(location.href);
		var pno = url.slice(url.indexOf('=') + 1);
		
		if($(this).hasClass("review-list-paginator_prev")){
			var page = parseInt($(".review-list-paginator_page.selected").text(),10) - 1;
			var prev_page = $(".review-list-paginator_page.selected").parent().prev().children();

			//Select order reflect
			var order = $(".production-review-feed_filter_order-active").text();
			
			if(order == "베스트순"){
				order = "best";
			}else if(order == "최신순"){
				order = "desc";
			}
			
			if(page > 0){
				if(page >= 9){
					var ul = $(".production-review_paginator li:first-child");
					
					var li = document.createElement("li");
					li.innerHTML = "<button class='list-paginator_page review-list-paginator_page'>" + (parseInt(page,10) - 8) + "</button>";

					$(".review-list-paginator_page.selected").parent().remove();
					ul.after(li);
				}
				
				$.ajax({
					url : "/WiShopping/productions/reviewListUpdate",
					type : "post",
					data : {
						page : page,
						pno : pno,
						order : order
					},success : function(reviews){
						$(".production-review-feed-item_container").remove(); //Delete an existing oul

						$.each(reviews, function(){
							//date fomrat init
							var date = new Date(this.writedate);
							
							var year = date.getFullYear();
							var month = (1 + date.getMonth());
							month = month >= 10 ? month : "0" + month;
							
							var day = date.getDate();
							
							date = year + "-" + month + "-" +day;

							if(this.likecheck == 1){
								var div = document.createElement("div");
								div.className = "production-review-feed-item_container";
								div.innerHTML =
									"<article class='production-review-item' data-number="+this.rno+">"+
									"<div class='production-review-item_writer'>"+
									"<a href='javascript:void(0);'>"+
									"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
									"</a>"+
									"<div class='production-review-item_writer_info'>"+
									"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
									"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
									"</div>"+
									"</div>"+
									"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
									"<button type='button' class='production-review-item_img_btn'>"+
									"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
									"</button>"+
									"<p class='production-review-item_description'>"+this.content+"</p>"+
									"<div class='production-review-item_like'>"+
									"<button type='button' class='production-review-item_like_btn production-review-item_like_btn-active'>좋아요</button>"+
									"<div class='production-review-item_like_text'>"+
									"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
									"</div>"+
									"</div>"+
									"</article>";
							}else{
								var div = document.createElement("div");
								div.className = "production-review-feed-item_container";
								div.innerHTML =
									"<article class='production-review-item' data-number="+this.rno+">"+
									"<div class='production-review-item_writer'>"+
									"<a href='javascript:void(0);'>"+
									"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
									"</a>"+
									"<div class='production-review-item_writer_info'>"+
									"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
									"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
									"</div>"+
									"</div>"+
									"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
									"<button type='button' class='production-review-item_img_btn'>"+
									"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
									"</button>"+
									"<p class='production-review-item_description'>"+this.content+"</p>"+
									"<div class='production-review-item_like'>"+
									"<button type='button' class='production-review-item_like_btn'>좋아요</button>"+
									"<div class='production-review-item_like_text'>"+
									"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
									"</div>"+
									"</div>"+
									"</article>";
							}
							
							$(".production-review-feed_list").append(div);
							$(".review-list-paginator_page.selected").removeClass("selected");
							prev_page.addClass("selected");
						});
					}
				});
			}
		}else if($(this).hasClass("qna-list-paginator_prev")){
			var is_seller = $("input[name='productions[is_seller]']").val();
			
			$.ajax({
				url : "/WiShopping/productions/questionListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					if(count % 5 == 0) var page_nav = parseInt(count / 5, 10);
					else var page_nav = parseInt(count / 5, 10) + 1;
					
					var page = parseInt($(".qna-list-paginator_page.selected").text(),10) - 1;
					var prev_page = $(".qna-list-paginator_page.selected").parent().prev().children();
					
					if(page > 0){
						if(page <= page_nav){
							//Create page button
							if(page > 0){
								if(prev_page.hasClass("qna-list-paginator_prev")){
									$(".production-qna_paginator li:last-child").prev().children().remove();

									var first = $(".production-qna_paginator li:first-child");
									
									var li = document.createElement("li");
									li.innerHTML = "<button class='list-paginator_page qna-list-paginator_page'>"+ page +"</button>";
									
									first.after(li);
								}
							}

							var prev_page = $(".qna-list-paginator_page.selected").parent().prev().children();
							
							$.ajax({
								url : "/WiShopping/productions/questionListUpdate",
								type : "post",
								async: false,
								data : {
									page : page,
									pno : pno
								},success : function(list){
									$(".product-question-feed_item").remove(); //Delete an existing questions

									$.each(list, function(){
										var article = document.createElement("article");
										article.className = "product-question-feed_item";
										article.setAttribute("qna-number",this.qno);
										
										//Status init
										var status = "";
										
										if(this.status == 0){
											status = " | <span class='unanswered'>답변대기</span>";
										}else{
											status = " | <span class='answered'>답변완료</span>";
										}
										
										if(this.answer == null){
											if(is_seller == 1){
												if(this.mno == mno){
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
															"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
															"<button class='product-question-feed_item_header_answer' type='button'>답변하기</button>"+
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>";
												}else{
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
														"<button class='product-question-feed_item_header_answer' type='button'>답변하기</button>"+
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>";
												}
											}else{
												if(this.mno == mno){
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
															"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>";
												}else{
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>";
												}
											}
										}else{
											if(is_seller == 1){
												if(this.mno == mno){
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
															"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>"+
														"<div class='product-question-feed_item_answer'>"+
															"<span class='product-question-feed_item_badge'>A</span>"+
															"<p class='product-question-feed_item_answer_author'>"+
															"<span class='author'>"+this.brand+" </span>"+
															"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
															"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
														"</div>";
												}else{
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>"+
														"<div class='product-question-feed_item_answer'>"+
															"<span class='product-question-feed_item_badge'>A</span>"+
															"<p class='product-question-feed_item_answer_author'>"+
															"<span class='author'>"+this.brand+" </span>"+
															"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
															"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
														"</div>";
												}
											}else{
												if(this.mno == mno){
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
															"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>"+
														"<div class='product-question-feed_item_answer'>"+
															"<span class='product-question-feed_item_badge'>A</span>"+
															"<p class='product-question-feed_item_answer_author'>"+
															"<span class='author'>"+this.brand+" </span>"+
															"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
															"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
														"</div>";
												}else{
													article.innerHTML =
														"<header class='product-question-feed_item_header'>"+ this.category + status +
														"</header>"+
														"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
														"<div class='product-question-feed_item_question'>"+
															"<span class='product-question-feed_item_badge'>Q</span>"+
															"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
														"</div>"+
														"<div class='product-question-feed_item_answer'>"+
															"<span class='product-question-feed_item_badge'>A</span>"+
															"<p class='product-question-feed_item_answer_author'>"+
															"<span class='author'>"+this.brand+" </span>"+
															"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
															"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
														"</div>";
												}
											}
										}
										
										$(".product-question-feed_list").append(article);
										$(".qna-list-paginator_page.selected").removeClass("selected");
										prev_page.addClass("selected");
									});
								}
							});
						}
					}
				}
			});
		}
	});
	
	//Next button click event
	$(document).on("click", ".list-paginator_next", function(){
		var url = decodeURI(location.href);
		var pno = url.slice(url.indexOf('=') + 1);
		
		if($(this).hasClass("review-list-paginator_next")){
			var page = parseInt($(".review-list-paginator_page.selected").text(),10) + 1;
			
			//Select order reflect
			var order = $(".production-review-feed_filter_order-active").text();
			
			if(order == "베스트순"){
				order = "best";
			}else if(order == "최신순"){
				order = "desc";
			}
			
			$.ajax({
				url : "/WiShopping/productions/reviewListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					if(count % 5 == 0) var page_nav = parseInt(count / 5, 10);
					else var page_nav = parseInt(count / 5, 10) + 1;
					
					//Only run when the next page is less than or equal to the navigator
					if(page <= page_nav){
						//Create page button
						if(page > 9){
							$(".production-review_paginator li:first-child").next().remove();
							
							var ul = $(".production-review_paginator li:last-child");
							
							var li = document.createElement("li");
							li.innerHTML = "<button class='list-paginator_page review-list-paginator_page'>" + page + "</button>";
							
							ul.before(li);
						}

						var next_page = $(".review-list-paginator_page.selected").parent().next().children();
						
						$.ajax({
							url : "/WiShopping/productions/reviewListUpdate",
							type : "post",
							async: false,
							data : {
								page : page,
								pno : pno,
								order : order
							},success : function(reviews){
								$(".production-review-feed-item_container").remove(); //Delete an existing review

								$.each(reviews, function(){
									//date fomrat init
									var date = new Date(this.writedate);
									
									var year = date.getFullYear();
									var month = (1 + date.getMonth());
									month = month >= 10 ? month : "0" + month;
									var day = date.getDate();
									
									date = year + "-" + month + "-" +day;

									if(this.likecheck == 1){
										var div = document.createElement("div");
										div.className = "production-review-feed-item_container";
										div.innerHTML =
											"<article class='production-review-item' data-number="+this.rno+">"+
											"<div class='production-review-item_writer'>"+
											"<a href='javascript:void(0);'>"+
											"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
											"</a>"+
											"<div class='production-review-item_writer_info'>"+
											"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
											"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
											"</div>"+
											"</div>"+
											"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
											"<button type='button' class='production-review-item_img_btn'>"+
											"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
											"</button>"+
											"<p class='production-review-item_description'>"+this.content+"</p>"+
											"<div class='production-review-item_like'>"+
											"<button type='button' class='production-review-item_like_btn production-review-item_like_btn-active'>좋아요</button>"+
											"<div class='production-review-item_like_text'>"+
											"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
											"</div>"+
											"</div>"+
											"</div>"+
											"</article>"+
											"</div>";
									}else{
										var div = document.createElement("div");
										div.className = "production-review-feed-item_container";
										div.innerHTML =
											"<article class='production-review-item' data-number="+this.rno+">"+
											"<div class='production-review-item_writer'>"+
											"<a href='javascript:void(0);'>"+
											"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
											"</a>"+
											"<div class='production-review-item_writer_info'>"+
											"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
											"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
											"</div>"+
											"</div>"+
											"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
											"<button type='button' class='production-review-item_img_btn'>"+
											"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
											"</button>"+
											"<p class='production-review-item_description'>"+this.content+"</p>"+
											"<div class='production-review-item_like'>"+
											"<button type='button' class='production-review-item_like_btn'>좋아요</button>"+
											"<div class='production-review-item_like_text'>"+
											"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
											"</div>"+
											"</div>"+
											"</div>"+
											"</article>"+
											"</div>";
									}
								
									$(".production-review-feed_list").append(div);
									$(".review-list-paginator_page.selected").removeClass("selected");
									next_page.addClass("selected");
								});
							}
						});
					}
				}
			});
		}else if($(this).hasClass("qna-list-pagenator_next")){
			var page = parseInt($(".qna-list-paginator_page.selected").text(),10) + 1;
			var is_seller = $("input[name='productions[is_seller]']").val();
			
			$.ajax({
				url : "/WiShopping/productions/questionListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					if(count % 5 == 0) var page_nav = parseInt(count / 5, 10);
					else var page_nav = parseInt(count / 5, 10) + 1;
					
					//Only run when the next page is less than or equal to the navigator
					if(page <= page_nav){
						//Create page button
						if(page > 9){
							$(".production-qna_paginator li:first-child").next().remove();
							
							var ul = $(".production-qna_paginator li:last-child");
							
							var li = document.createElement("li");
							li.innerHTML = "<button class='list-paginator_page qna-list-paginator_page'>" + page + "</button>";
							
							ul.before(li);
						}

						var next_page = $(".qna-list-paginator_page.selected").parent().next().children();
						
						$.ajax({
							url : "/WiShopping/productions/questionListUpdate",
							type : "post",
							async: false,
							data : {
								page : page,
								pno : pno
							},success : function(list){
								$(".product-question-feed_item").remove(); //Delete an existing questions

								$.each(list, function(){
									var article = document.createElement("article");
									article.className = "product-question-feed_item";
									article.setAttribute("qna-number",this.qno);
									
									//Status init
									var status = "";
									
									if(this.status == 0){
										status = " | <span class='unanswered'>답변대기</span>";
									}else{
										status = " | <span class='answered'>답변완료</span>";
									}
									
									if(this.answer == null){
										if(is_seller == 1){
											if(this.mno == mno){
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
														"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
														"<button class='product-question-feed_item_header_answer' type='button'>답변하기</button>"+
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>";
											}else{
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
													"<button class='product-question-feed_item_header_answer' type='button'>답변하기</button>"+
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>";
											}
										}else{
											if(this.mno == mno){
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
														"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>";
											}else{
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>";
											}
										}
									}else{
										if(is_seller == 1){
											if(this.mno == mno){
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
														"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>"+
													"<div class='product-question-feed_item_answer'>"+
														"<span class='product-question-feed_item_badge'>A</span>"+
														"<p class='product-question-feed_item_answer_author'>"+
														"<span class='author'>"+this.brand+" </span>"+
														"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
														"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
													"</div>";
											}else{
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>"+
													"<div class='product-question-feed_item_answer'>"+
														"<span class='product-question-feed_item_badge'>A</span>"+
														"<p class='product-question-feed_item_answer_author'>"+
														"<span class='author'>"+this.brand+" </span>"+
														"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
														"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
													"</div>";
											}
										}else{
											if(this.mno == mno){
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
														"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>"+
													"<div class='product-question-feed_item_answer'>"+
														"<span class='product-question-feed_item_badge'>A</span>"+
														"<p class='product-question-feed_item_answer_author'>"+
														"<span class='author'>"+this.brand+" </span>"+
														"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
														"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
													"</div>";
											}else{
												article.innerHTML =
													"<header class='product-question-feed_item_header'>"+ this.category + status +
													"</header>"+
													"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
													"<div class='product-question-feed_item_question'>"+
														"<span class='product-question-feed_item_badge'>Q</span>"+
														"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
													"</div>"+
													"<div class='product-question-feed_item_answer'>"+
														"<span class='product-question-feed_item_badge'>A</span>"+
														"<p class='product-question-feed_item_answer_author'>"+
														"<span class='author'>"+this.brand+" </span>"+
														"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
														"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
													"</div>";
											}
										}
									}
									
									$(".product-question-feed_list").append(article);
									$(".qna-list-paginator_page.selected").removeClass("selected");
									next_page.addClass("selected");
								});
							}
						});
					}
				}
			});
		}
	});

	//Reflect when selecting review page
	$(document).on("click",".list-paginator_page",function(){
		var curPage = $(this);
		var page = $(this).text();
		
		var is_seller = $("input[name='productions[is_seller]']").val();
		
		if($(this).hasClass("qna-list-paginator_page")){
			var idx = $(".qna-list-paginator_page");
			
			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			//ajax to know page list count
			$.ajax({
				url : "/WiShopping/productions/questionListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					$(".qna-list-paginator_page.selected").removeClass("selected");
					
					if(count % 5 == 0) var max = parseInt(count / 5, 10);
					else var max = parseInt(count / 5, 10) + 1;
					
					var min = page - 4;

					if(min <= 0){
						min = 1;
						
						$.each(idx, function(){
							$(this).text(min++);

							if($(this).text() == page){
								$(this).addClass("selected");
							}
						});
					}else{
						if((max - page) <= 4){
							var min = max - 8;
							if(min == 0) min = 1;
						}
						
						$.each(idx, function(){
							$(this).text(min++);

							if($(this).text() == page){
								$(this).addClass("selected");
							}
						});
					}
					
					//Reflect composition to match selected page
					$.ajax({
						url : "/WiShopping/productions/questionListUpdate",
						type : "post",
						data : {
							page : page,
							pno : pno
						},success : function(list){
							$(".product-question-feed_item").remove(); //Delete an existing questions
							
							$.each(list, function(){
								var article = document.createElement("article");
								article.className = "product-question-feed_item";
								article.setAttribute("qna-number",this.qno);
								
								//Status init
								var status = "";
								
								if(this.status == 0){
									status = " | <span class='unanswered'>답변대기</span>";
								}else{
									status = " | <span class='answered'>답변완료</span>";
								}

								if(this.answer == null){
									if(is_seller == 1){
										if(this.mno == mno){
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
													"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
													"<button class='product-question-feed_item_header_answer' type='button'>답변하기</button>"+
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>";
										}else{
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
												"<button class='product-question-feed_item_header_answer' type='button'>답변하기</button>"+
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>";
										}
									}else{
										if(this.mno == mno){
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
													"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>";
										}else{
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>";
										}
									}
								}else{
									if(is_seller == 1){
										if(this.mno == mno){
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
													"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>"+
												"<div class='product-question-feed_item_answer'>"+
													"<span class='product-question-feed_item_badge'>A</span>"+
													"<p class='product-question-feed_item_answer_author'>"+
													"<span class='author'>"+this.brand+" </span>"+
													"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
													"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
												"</div>";
										}else{
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>"+
												"<div class='product-question-feed_item_answer'>"+
													"<span class='product-question-feed_item_badge'>A</span>"+
													"<p class='product-question-feed_item_answer_author'>"+
													"<span class='author'>"+this.brand+" </span>"+
													"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
													"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
												"</div>";
										}
									}else{
										if(this.mno == mno){
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
													"<button class='product-question-feed_item_header_delete' type='button'>삭제</button>"+
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>"+
												"<div class='product-question-feed_item_answer'>"+
													"<span class='product-question-feed_item_badge'>A</span>"+
													"<p class='product-question-feed_item_answer_author'>"+
													"<span class='author'>"+this.brand+" </span>"+
													"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
													"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
												"</div>";
										}else{
											article.innerHTML =
												"<header class='product-question-feed_item_header'>"+ this.category + status +
												"</header>"+
												"<p class='product-question-feed_item_author'>"+this.name+" | "+dateFormatTransfer(this.writedate)+"</p>"+
												"<div class='product-question-feed_item_question'>"+
													"<span class='product-question-feed_item_badge'>Q</span>"+
													"<p class='product-question-feed_item_content'>"+this.content+"</p>"+
												"</div>"+
												"<div class='product-question-feed_item_answer'>"+
													"<span class='product-question-feed_item_badge'>A</span>"+
													"<p class='product-question-feed_item_answer_author'>"+
													"<span class='author'>"+this.brand+" </span>"+
													"<span class='date'>"+dateFormatTransfer(this.answerdate)+"</span>"+
													"<p class='product-question-feed_item_content'>"+this.answer+"</p>"+
												"</div>";
										}
									}
								}
								
								$(".product-question-feed_list").append(article);
							});
						}
					});
				}
			});
		}else if($(this).hasClass("review-list-paginator_page")){
			var idx = $(".review-list-paginator_page");
			
			//Select order reflect
			var order = $(".production-review-feed_filter_order-active").text();
			
			if(order == "베스트순"){
				order = "best";
			}else if(order == "최신순"){
				order = "desc";
			}

			$(".review-list-paginator_page.selected").removeClass("selected");

			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			//ajax to know page list count
			$.ajax({
				url : "/WiShopping/productions/reviewListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					if(count % 5 == 0) var max = parseInt(count / 5, 10);
					else var max = parseInt(count / 5, 10) + 1;
					var min = page - 4;

					if(min <= 0){
						min = 1;

						$.each(idx, function(){
							$(this).text(min++);

							if($(this).text() == page){
								$(this).addClass("selected");
							}
						});
					}else{
						if((max - page) <= 4){
							var min = max - 8;
						}
						
						$.each(idx, function(){
							$(this).text(min++);

							if($(this).text() == page){
								$(this).addClass("selected");
							}
						});
					}
					
					//Reflect composition to match selected page
					$.ajax({
						url : "/WiShopping/productions/reviewListUpdate",
						type : "post",
						async: false,
						data : {
							page : page,
							pno : pno,
							order : order
						},success : function(reviews){
							$(".production-review-feed-item_container").remove(); //Delete an existing review

							$.each(reviews, function(){
								//date fomrat init
								var date = new Date(this.writedate);
								
								var year = date.getFullYear();
								var month = (1 + date.getMonth());
								month = month >= 10 ? month : "0" + month;
								var day = date.getDate();
								
								date = year + "-" + month + "-" +day;

								if(this.likecheck == 1){
									var div = document.createElement("div");
									div.className = "production-review-feed-item_container";
									div.innerHTML =
										"<article class='production-review-item' data-number="+this.rno+">"+
										"<div class='production-review-item_writer'>"+
										"<a href='javascript:void(0);'>"+
										"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
										"</a>"+
										"<div class='production-review-item_writer_info'>"+
										"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
										"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
										"</div>"+
										"</div>"+
										"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
										"<button type='button' class='production-review-item_img_btn'>"+
										"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
										"</button>"+
										"<p class='production-review-item_description'>"+this.content+"</p>"+
										"<div class='production-review-item_like'>"+
										"<button type='button' class='production-review-item_like_btn production-review-item_like_btn-active'>좋아요</button>"+
										"<div class='production-review-item_like_text'>"+
										"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
										"</div>"+
										"</div>"+
										"</article>";
								}else{
									var div = document.createElement("div");
									div.className = "production-review-feed-item_container";
									div.innerHTML =
										"<article class='production-review-item' data-number="+this.rno+">"+
										"<div class='production-review-item_writer'>"+
										"<a href='javascript:void(0);'>"+
										"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
										"</a>"+
										"<div class='production-review-item_writer_info'>"+
										"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
										"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
										"</div>"+
										"</div>"+
										"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
										"<button type='button' class='production-review-item_img_btn'>"+
										"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
										"</button>"+
										"<p class='production-review-item_description'>"+this.content+"</p>"+
										"<div class='production-review-item_like'>"+
										"<button type='button' class='production-review-item_like_btn'>좋아요</button>"+
										"<div class='production-review-item_like_text'>"+
										"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
										"</div>"+
										"</div>"+
										"</article>";
								}
								
								$(".production-review-feed_list").append(div);
								$(".review-list-paginator_page.selected").removeClass("selected");
								curPage.addClass("selected");
							});
						}
					});
				}
			});
		}
	});
	
	//Event when order modify btn clicked
	$(document).ready(function(){
		$(".production-review-feed_filter_order").click(function(){
			var text = $(this).text();
			var order = "desc";

			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			if(!$(this).hasClass("production-review-feed_filter_order-active")){
				if(text == "베스트순"){
					order = "best";
				}else if(text == "최신순"){
					order = "desc";
				}
			}
			
			$.ajax({
				url : "/WiShopping/productions/reviewOrder",
				type : "post",
				data : {
					order : order,
					pno : pno
				},success : function(reviews){
					$(".production-review-feed-item_container").remove(); //Delete an existing review

					$.each(reviews, function(){
						//date fomrat init
						var date = new Date(this.writedate);
						
						var year = date.getFullYear();
						
						var month = (1 + date.getMonth());
						month = month >= 10 ? month : "0" + month;
						
						var day = date.getDate();
						day = day >= 10 ? day : "0" + day;
						
						date = year + "-" + month + "-" +day;

						if(this.likecheck == 1){
							var div = document.createElement("div");
							div.className = "production-review-feed-item_container";
							div.innerHTML =
								"<article class='production-review-item' data-number="+this.rno+">"+
								"<div class='production-review-item_writer'>"+
								"<a href='javascript:void(0);'>"+
								"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
								"</a>"+
								"<div class='production-review-item_writer_info'>"+
								"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
								"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
								"</div>"+
								"</div>"+
								"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
								"<button type='button' class='production-review-item_img_btn'>"+
								"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
								"</button>"+
								"<p class='production-review-item_description'>"+this.content+"</p>"+
								"<div class='production-review-item_like'>"+
								"<button type='button' class='production-review-item_like_btn production-review-item_like_btn-active'>좋아요</button>"+
								"<div class='production-review-item_like_text'>"+
								"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
								"</div>"+
								"</div>"+
								"</article>";
						}else{
							var div = document.createElement("div");
							div.className = "production-review-feed-item_container";
							div.innerHTML =
								"<article class='production-review-item' data-number="+this.rno+">"+
								"<div class='production-review-item_writer'>"+
								"<a href='javascript:void(0);'>"+
								"<img src='${pageContext.request.contextPath}/resources/image/none_user.png' class='production-review-item_writer_img'>"+
								"</a>"+
								"<div class='production-review-item_writer_info'>"+
								"<p class='production-review-item_writer_info_name'>"+this.name+"</p>"+
								"<span class='production-review-item_writer_info_date'>"+date+"</span>"+
								"</div>"+
								"</div>"+
								"<p class='production-review-item_name'>색상: "+this.optioncolor+" / 옵션: "+this.optionsize+"</p>"+
								"<button type='button' class='production-review-item_img_btn'>"+
								"<img class='production-review-item_img' src='${pageContext.request.contextPath}"+this.contentimg+"'>"+
								"</button>"+
								"<p class='production-review-item_description'>"+this.content+"</p>"+
								"<div class='production-review-item_like'>"+
								"<button type='button' class='production-review-item_like_btn'>좋아요</button>"+
								"<div class='production-review-item_like_text'>"+
								"<span class='production-review-item_help_like_number'>"+this.likecount+"</span>명이 좋아했습니다."+
								"</div>"+
								"</div>"+
								"</article>";
						}
						
						$(".production-review-feed_list").append(div);
					});

					$.ajax({
						url : "/WiShopping/productions/reviewListCount",
						type : "post",
						data : {pno : pno},
						success : function(count){
							$(".production-review_paginator li").remove();

							if(count % 5 == 0) var page_nav = parseInt(count / 5, 10);
							else var page_nav = parseInt(count / 5, 10) + 1;
							
							var prev = document.createElement("li");
							prev.innerHTML =
								"<button class='list-paginator_prev review-list-paginator_prev' type='button'>"+
								"<svg width='26' height='26' viewBox='0 0 26 26' preserveAspectRatio='xMidYMid meet'>"+
								"<g fill='none' fill-rule='evenodd'>"+
								"<rect width='25' height='25' x='.5' y='.5' stroke='#DCDCDC' rx='4'></rect>"+
								"<g stroke='#424242' stroke-linecap='square' stroke-width='2'>"+
								"<path d='M14.75 8.263L10.25 13M10.25 13l4.5 4.737'></path></g></g>"+
								"</svg>"+
								"</button>";
							$(".production-review_paginator").append(prev);
							
							//Paging from 1 to 9 at 'first'.
							if(page_nav > 10){
								page_nav = 9;
							}

							for(var i=1;i<=page_nav;i++){
								var paging = document.createElement("li");
								
								if(i == 1){
									paging.innerHTML = "<button class='list-paginator_page review-list-paginator_page selected'>"+i+"</button>";
								}else{
									paging.innerHTML = "<button class='list-paginator_page review-list-paginator_page'>"+i+"</button>";
								}
								
								$(".production-review_paginator").append(paging);
							}

							var next = document.createElement("li");
							next.innerHTML = 
								"<button class='list-paginator_next review-list-paginator_next' type='button'>"+
								"<svg width='26' height='26' viewBox='0 0 26 26' preserveAspectRatio='xMidYMid meet'>"+
								"<g fill='none' fill-rule='evenodd' transform='matrix(-1 0 0 1 26 0)'>"+
								"<rect width='25' height='25' x='.5' y='.5' stroke='#DCDCDC' rx='4'></rect>"+
								"<g stroke='#424242' stroke-linecap='square' stroke-width='2'>"+
								"<path d='M14.75 8.263L10.25 13M10.25 13l4.5 4.737'></path></g></g>"+
								"</svg>"+
								"</button>";
							$(".production-review_paginator").append(next);
						}
					});
				}
			});

			$(".production-review-feed_filter_order-active").removeClass("production-review-feed_filter_order-active");
			$(this).addClass("production-review-feed_filter_order-active");
		});
	});	
</script>
<script type="text/javascript">
	/*
		This is product javascript part
	*/
	$(document).ready(function(){
		$(".product-selling-admin-button").click(function(){
			var text = $(this).text();

			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			if(text == "수정"){ // Modify button clicked event
				location.href = "/WiShopping/productions/modify?pno="+pno;
			}else{//Delete button clicked event
				var var_confirm = confirm("정말로 삭제하시겠습니까?\n삭제된 상품 정보는 다시 복구할 수 없습니다.");
			
				if(var_confirm){
					$.ajax({
						url : "/WiShopping/productions/delete",
						type : "get",
						data : {pno : pno},
						success : function(result){
							if(result == 1){
								alert("상품이 삭제되었습니다.");
								location.href = "/WiShopping";
							}else if(result == 0) location.href = "/WiShopping/erorr";
						}
					});
				}
			}
		});
	});
	
</script>
<script type="text/javascript">
	/*
		This is Questions javascript part
	*/
	
	//Expand textarea size by number of characters
	$(document).on("keydown keyup", ".product-question_wrap_question",function(){
		$(this).height(1).height($(this).prop("scrollHeight"));
	});
	$(document).on("keydown keyup", ".product-question_wrap_question_answer_content",function(){
		$(this).height(1).height($(this).prop("scrollHeight"));
	});
	
	//Events when selecting select box from question popup-modal
	$(document).on("click", ".product-question_wrap_type-select_box", function(){
		$(".product-question_wrap_type-select_box-select").removeClass("product-question_wrap_type-select_box-select");
		$(this).addClass("product-question_wrap_type-select_box-select");
	});
	
	//Events when clicked question modal layer pop-up exit button
	$(document).on("click", ".product-question_wrap_close", function(){
		var var_confirm = confirm("작성된 내용이 모두 유실됩니다.\n그래도 나가시겠습니까?");
		
		if(var_confirm){
			$("body").css("overflow-y","scroll");
			$(".product-question_modal.open").remove();
		}
	});
	
	//Question submit button clicked event
	$(document).on("click", ".product-question_wrap_buttons_submit", function(){
		var url = decodeURI(location.href);
		var pno = url.slice(url.indexOf('=') + 1);
		
		var category = $(".product-question_wrap_type-select_box-select").text();
		var content = $(".product-question_wrap_question").val();
		var issecret = $(".form-check").is(":checked");
		
		if(issecret) issecret = 1;
		else issecret = 0;
		
		$.ajax({
			url : "/WiShopping/productions/questionRegist",
			type : "post",
			data : {
				pno : pno,
				mno : mno,
				category : category,
				content : content,
				issecret : issecret
			},success : function(){
				location.reload();

				var href = $("#production-selling-question").offset();
				href.top -= 40;
				
				$("html, body").animate({scrollTop : href.top},300);
			}
		})
	});

	//Product Question delete button clicked event
	$(document).on("click", ".product-question-feed_item_header_delete", function(){
		if(mno == ""){
			location.href = "/WiShopping/auth/login";
		}else{
			var var_confirm = confirm("해당 문의를 삭제하시겠습니까?");
			
			if(var_confirm){
				var qno = $(this).closest("article").attr("qna-number");
				
				$.ajax({
					url : "/WiShopping/productions/questionDelete",
					type : "post",
					data : {qno : qno},
					success : function(result){
						if(result == 1){
							location.reload(); 

							var href = $("#production-selling-question").offset();
							href.top -= 40;
							
							$("html, body").animate({scrollTop : href.top},300);
						}else if(result == 0){
							location.href = "/WiShopping/auth/login";
						}
					}
				});
			}
		}
	});

	//Product question answer button clicked event
	$(document).on("click", ".product-question-feed_item_header_answer", function(){
		var content = $(this).closest("article").children("div").children("p").text();
		var qno = $(this).closest("article").attr("qna-number");
		
		var div = document.createElement("div");
		div.className = "popup-modal product-question-answer_modal open";
		
		div.innerHTML =
			"<div class='popup-modal_content-wrap'>"+
				"<div class='popup-modal_content product-question'>"+
					"<form class='product-question-answer_wrap'>"+
						"<input type='hidden' value='"+qno+"' name='qna[number]'>"+
						"<div class='product-question_wrap_close'>"+
							"<svg class='product-question_wrap_close_icon' width='20' height='20' viewBox='0 0 20 20' fill='currentColor' preserveAspectRatio='xMidYMid meet'>"+
							"<path fill-rule='nonzero' d='M11.6 10l7.1 7.1-1.6 1.6-7.1-7.1-7.1 7.1-1.6-1.6L8.4 10 1.3 2.9l1.6-1.6L10 8.4l7.1-7.1 1.6 1.6z'></path>"+
							"</svg>"+
						"</div>"+
						"<div class='product-question_wrap_title'>문의하기</div>"+
						"<div class='product-question_wrap_sub-title'>문의내용</div>"+
						"<textarea maxlength='1000' class='form-control product-question_wrap_question_answer' readonly='readonly' style='height:auto;'>"+content+"</textarea>"+
						"<div class='product-question_wrap_sub-title'>답변내용</div>"+
						"<textarea maxlength='1000' class='form-control product-question_wrap_question_answer_content' style='height:auto;'></textarea>"+
						"<div class='product-question_wrap_buttons'>"+
							"<button class='button button-color-blue product-answer_wrap_buttons_submit' type='button'>완료</button>"+
						"</div>"+
					"</form>"+
				"</div>"+
			"</div>";

		$("body").append(div);
	});
	
	//Product question answer submit button clicked event
	$(document).on("click", ".product-answer_wrap_buttons_submit", function(){
		var answer = $(".product-question_wrap_question_answer_content").val();
		var qno = $("input[name='qna[number]']").val();
		
		$.ajax({
			url : "/WiShopping/productions/answerRegist",
			type : "post",
			data : {
				mno : mno,
				qno : qno,
				answer : answer
			},success : function(result){
				if(result == 0){
					location.href = "/WiShopping/auth/login";
				}else if(result == 1){
					location.reload();

					var href = $("#production-selling-question").offset();
					href.top -= 40;
					
					$("html, body").animate({scrollTop : href.top},300);
				}
			},error : function(){
				location.href = "/WiShopping/error";
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
							<c:if test="${product.category1 eq '패션'}"><a href="${pageContext.request.contextPath}/category/group/fashion?category2=all">${product.category1}</a></c:if>
							<c:if test="${product.category1 eq '잡화'}"><a href="${pageContext.request.contextPath}/category/group/accessories?category2=all">${product.category1}</a></c:if>
							<c:if test="${product.category1 eq '인테리어'}"><a href="${pageContext.request.contextPath}/category/group/interior?category2=all">${product.category1}</a></c:if>
							<c:if test="${product.category1 eq '가전·디지털'}"><a href="${pageContext.request.contextPath}/category/group/digital?category2=all">${product.category1}</a></c:if>
						</li>
						<c:if test="${product.category1 eq '패션'}">
							<li class="commerce-category-list"><a href="${pageContext.request.contextPath}/category/group/fashion?category2=${product.category2}">${product.category2}</a></li>
						</c:if>
						<c:if test="${product.category1 eq '잡화'}">
							<li class="commerce-category-list"><a href="${pageContext.request.contextPath}/category/group/accessories?category2=${product.category2}">${product.category2}</a></li>
						</c:if>
						<c:if test="${product.category1 eq '인테리어'}">
							<li class="commerce-category-list"><a href="${pageContext.request.contextPath}/category/group/interior?category2=${product.category2}">${product.category2}</a></li>
						</c:if>
						<c:if test="${product.category1 eq '가전·디지털'}">
							<li class="commerce-category-list"><a href="${pageContext.request.contextPath}/category/group/digital?category2=${product.category2}">${product.category2}</a></li>
						</c:if>
					</ul>
				</nav>
				<c:if test="${product.isseller eq 1}">
					<nav class="product-selling-admin-category">
						<ul class="product-selling-admin-category_breadcrumb">
							<li><button type="button" class="product-selling-admin-button">수정</button></li>
							<li><button type="button" class="product-selling-admin-button">삭제</button></li>
						</ul>
					</nav>
				</c:if>
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
									<a href="${pageContext.request.contextPath}/brands/home?query=${product.brand}" class="production-selling-header_title_brand">${product.brand}</a>
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
																<span class="selling-option-item_price_number"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/></span>원
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
							<li><a href="#production-selling-information" class="product_selling_nav_item product_selling_nav_item-active">상품정보</a></li>
							<li><a href="#production-selling-review" class="product_selling_nav_item">리뷰</a></li>
							<li><a href="javascript:void(0);" class="product_selling_nav_item">문의</a></li>
							<li><a href="javascript:void(0);" class="product_selling_nav_item">배송/환불</a></li>
						</ol>
					</nav>
				</div>
			</div>
			<div class="production-selling_detail-wrap container">
				<input type="hidden" name="productions[is_seller]" value="${product.isseller}">
				<div class="item_desc">
					<div class="prd_detail cut view">
						<a id="production-selling-information"></a>
						<div id="productdetails" class="tab_conts">
							<div class="deal_detailimg">
								<p>
									<c:forEach var="image" items="${image}">
										<img src="${pageContext.request.contextPath}${image}">
									</c:forEach>
								</p>
							</div>
						</div>
						<a id="production-selling-review"></a>
						<div class="product_selling_section">
							<header class="product_selling_section-header">
								<h1 class="product_selling_section-header-title">리뷰<span class="count">${reviewCount}</span></h1>
								<div class="product_selling_section-right"><button type="button">리뷰쓰기</button></div>
							</header>
							<div class="production-review-feed">
								<div class="filter">
									<div class="production-review-feed_filter-wrap">
										<div class="production-review-feed_filter">
											<div class="production-review-feed_filter_order-list">
												<button class="production-review-feed_filter_order production-review-feed_filter_order-active" type="button">베스트순</button>
												<button class="production-review-feed_filter_order" type="button">최신순</button>
											</div>
										</div>
									</div>
								</div>
								<div class="production-review-feed_list">
									<c:forEach var="review" items="${reviews}">
									<div class="production-review-feed-item_container">
										<article class="production-review-item" data-number="${review.rno}">
											<div class="production-review-item_writer">
												<a href="javascript:void(0);">
													<img src="${pageContext.request.contextPath}/resources/image/none_user.png" class="production-review-item_writer_img">
												</a>
												<div class="production-review-item_writer_info">
													<p class="production-review-item_writer_info_name">${review.name}</p>
													<span class="production-review-item_writer_info_date">${review.writedate}</span>
												</div>
											</div>
											<p class="production-review-item_name">색상: ${review.optioncolor} / 옵션: ${review.optionsize}</p>
											<button type="button" class="production-review-item_img_btn">
												<img class="production-review-item_img" src="${pageContext.request.contextPath}${review.contentimg}">
											</button>
											<p class="production-review-item_description">${review.content}</p>
											<div class="production-review-item_like">
												<c:if test="${review.likecheck eq 0}">
													<button type="button" class="production-review-item_like_btn">좋아요</button>
												</c:if>
												<c:if test="${review.likecheck eq 1}">
													<button type="button" class="production-review-item_like_btn production-review-item_like_btn-active">좋아요</button>
												</c:if>
												<div class="production-review-item_like_text">
													<span class="production-review-item_help_like_number">${review.likecount}</span>명이 좋아했습니다.
												</div>
											</div>
										</article>
									</div>
									</c:forEach>
								</div>
								<c:if test="${!empty reviews}">
								<ul class="list-paginator production-review_paginator">
									<li>
										<button class="list-paginator_prev review-list-paginator_prev" type="button">
											<svg width="26" height="26" viewBox="0 0 26 26" preserveAspectRatio="xMidYMid meet">
												<g fill="none" fill-rule="evenodd">
													<rect width="25" height="25" x=".5" y=".5" stroke="#DCDCDC" rx="4"></rect>
												<g stroke="#424242" stroke-linecap="square" stroke-width="2">
												<path d="M14.75 8.263L10.25 13M10.25 13l4.5 4.737"></path></g></g>
											</svg>
										</button>
									</li>
									<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
										<li>
											<c:if test="${idx eq 1}">
												<button class="list-paginator_page review-list-paginator_page selected">${idx}</button>
											</c:if>
											<c:if test="${idx ne 1}">
												<button class="list-paginator_page review-list-paginator_page">${idx}</button>
											</c:if>
										</li>
									</c:forEach>
									<li>
										<button class="list-paginator_next review-list-paginator_next" type="button">
											<svg width="26" height="26" viewBox="0 0 26 26" preserveAspectRatio="xMidYMid meet">
												<g fill="none" fill-rule="evenodd" transform="matrix(-1 0 0 1 26 0)">
													<rect width="25" height="25" x=".5" y=".5" stroke="#DCDCDC" rx="4"></rect>
												<g stroke="#424242" stroke-linecap="square" stroke-width="2">
												<path d="M14.75 8.263L10.25 13M10.25 13l4.5 4.737"></path></g></g>
											</svg>
										</button>
									</li>
								</ul>
								</c:if>
							</div>
						</div>
						<a id="production-selling-question"></a>
						<div class="product_selling_section">
							<header class="product_selling_section-header">
								<h1 class="product_selling_section-header-title">문의 <span class="count">${questionCount}</span>
								</h1>
								<div class="product_selling_section-right">
									<button type="button">문의하기</button>
								</div>
							</header>
							<div class="product-question-feed">
								<div class="product-question-feed_list">
									<c:forEach var="question" items="${questions}">
									<c:if test="${question.issecret eq 1}">
										<c:if test="${question.mno eq login.mno }">
											<article class="product-question-feed_item" qna-number="${question.qno}">
												<header class="product-question-feed_item_header">${question.category} | 
													<c:if test="${question.status eq 0}">
														<span class="unanswered">답변대기</span>
													</c:if>
													<c:if test="${question.status eq 1}">
														<span class="answered">답변완료</span>
													</c:if>
													<c:if test="${question.mno eq login.mno}">
														<button class="product-question-feed_item_header_delete" type="button">삭제</button>
													</c:if>
													<c:if test="${product.isseller eq 1}">
														<c:if test="${question.status eq 0}">
															<button class="product-question-feed_item_header_answer" type="button">답변하기</button>
														</c:if>
													</c:if>
												</header>
												<p class="product-question-feed_item_author"><c:out value="${fn:substring(question.name,0,2)}"/>* | <fmt:formatDate value="${question.writedate}" pattern="yyyy년 MM월 dd일 HH시 MM분"/></p>
												<div class="product-question-feed_item_question">
													<span class="product-question-feed_item_badge">Q</span>
													<p class="product-question-feed_item_content">${question.content}</p>
												</div>
												<c:if test="${question.brand ne null}">
												<div class="product-question-feed_item_answer">
													<span class="product-question-feed_item_badge">A</span>
													<p class="product-question-feed_item_answer_author">
														<span class="author">${question.brand}</span> 
														<span class="date"><fmt:formatDate value="${question.answerdate}" pattern="yyyy년 MM월 dd일 HH시 MM분"/></span>
													</p>
													<p class="product-question-feed_item_content">${question.answer}</p>
												</div>
												</c:if>
											</article>
										</c:if>
										<c:if test="${question.mno ne login.mno}">
											<article class="product-question-feed_item" qna-number="${question.qno}">
												<header class="product-question-feed_item_header">${question.category} | 
													<c:if test="${question.status eq 0}">
														<span class="unanswered">답변대기</span>
													</c:if>
													<c:if test="${question.status eq 1}">
														<span class="answered">답변완료</span>
													</c:if>
													<c:if test="${question.mno eq login.mno}">
														<button class="product-question-feed_item_header_delete" type="button">삭제</button>
													</c:if>
													<c:if test="${product.isseller eq 1}">
														<c:if test="${question.status eq 0}">
															<button class="product-question-feed_item_header_answer" type="button">답변하기</button>
														</c:if>
													</c:if>
												</header>
												<p class="product-question-feed_item_author"><c:out value="${fn:substring(question.name,0,2)}"/>* | <fmt:formatDate value="${question.writedate}" pattern="yyyy년 MM월 dd일 HH시 MM분"/></p>
												<div class="product-question-feed_item_question">
													<span class="product-question-feed_item_badge">Q</span>
													<p class="product-question-feed_item_content">비밀글입니다.</p>
												</div>
											</article>
										</c:if>
									</c:if>
									<c:if test="${question.issecret eq 0}">
										<article class="product-question-feed_item" qna-number="${question.qno}">
											<header class="product-question-feed_item_header">${question.category} | 
												<c:if test="${question.status eq 0}">
													<span class="unanswered">답변대기</span>
												</c:if>
												<c:if test="${question.status eq 1}">
													<span class="answered">답변완료</span>
												</c:if>
												<c:if test="${question.mno eq login.mno}">
													<button class="product-question-feed_item_header_delete" type="button">삭제</button>
												</c:if>
												<c:if test="${product.isseller eq 1}">
													<c:if test="${question.status eq 0}">
														<button class="product-question-feed_item_header_answer" type="button">답변하기</button>
													</c:if>
												</c:if>
											</header>
											<p class="product-question-feed_item_author"><c:out value="${fn:substring(question.name,0,2)}"/>* | <fmt:formatDate value="${question.writedate}" pattern="yyyy년 MM월 dd일 HH시 MM분"/></p>
											<div class="product-question-feed_item_question">
												<span class="product-question-feed_item_badge">Q</span>
												<p class="product-question-feed_item_content">${question.content}</p>
											</div>
											<c:if test="${question.brand ne null}">
											<div class="product-question-feed_item_answer">
												<span class="product-question-feed_item_badge">A</span>
												<p class="product-question-feed_item_answer_author">
													<span class="author">${question.brand}</span> 
													<span class="date"><fmt:formatDate value="${question.answerdate}" pattern="yyyy년 MM월 dd일 HH시 MM분"/></span>
												</p>
												<p class="product-question-feed_item_content">${question.answer}</p>
											</div>
											</c:if>
										</article>
									</c:if>
									</c:forEach>
								</div>
								<c:if test="${!empty questions}">
								<ul class="list-paginator production-qna_paginator">
									<li>
										<button class="list-paginator_prev qna-list-paginator_prev" type="button">
											<svg width="26" height="26" viewBox="0 0 26 26" preserveAspectRatio="xMidYMid meet">
												<g fill="none" fill-rule="evenodd">
													<rect width="25" height="25" x=".5" y=".5" stroke="#DCDCDC" rx="4"></rect>
												<g stroke="#424242" stroke-linecap="square" stroke-width="2">
												<path d="M14.75 8.263L10.25 13M10.25 13l4.5 4.737"></path></g></g>
											</svg>
										</button>
									</li>
									<c:forEach begin="${qnaPageMaker.startPage}" end="${qnaPageMaker.endPage}" var="idx">
										<li>
											<c:if test="${idx eq 1}">
												<button class="list-paginator_page qna-list-paginator_page selected">${idx}</button>
											</c:if>
											<c:if test="${idx ne 1}">
												<button class="list-paginator_page qna-list-paginator_page">${idx}</button>
											</c:if>
										</li>
									</c:forEach>
									<li>
										<button class="list-paginator_next qna-list-pagenator_next" type="button">
											<svg width="26" height="26" viewBox="0 0 26 26" preserveAspectRatio="xMidYMid meet">
												<g fill="none" fill-rule="evenodd" transform="matrix(-1 0 0 1 26 0)">
													<rect width="25" height="25" x=".5" y=".5" stroke="#DCDCDC" rx="4"></rect>
												<g stroke="#424242" stroke-linecap="square" stroke-width="2">
												<path d="M14.75 8.263L10.25 13M10.25 13l4.5 4.737"></path></g></g>
											</svg>
										</button>
									</li>
								</ul>
								</c:if>
							</div>
						</div>
						<a id="production-selling-delivery"></a>
						<div class="product_selling_section">
							<header class="product_selling_section-header">
								<h1 class="product_selling_section-header-title">배송</h1>
							</header>
							<table class="product_selling_section-table">
								<tbody>
									<tr>
										<th>배송</th>
										<td>일반택배</td>
									</tr>
									<tr>
										<th>배송비</th>
										<td><c:if test="${product.shippingfee eq 0}">무료배송</c:if><c:if test="${product.shippingfee ne 0}"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.shippingfee}"/>원</c:if>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="product_selling_section">
							<header class="product_selling_section-header">
								<h1 class="product_selling_section-header-title">교환/환불</h1>
							</header>
							<div class="prouct_selling_section-refund">
								<table class="product_selling_section-table product_selling_section-refund_table">
									<tbody>
										<tr>
											<th>반품배송비</th>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.returnfee}"/>원</td>
										</tr>
										<tr>
											<th>교환배송비</th>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.returnfee}"/>원</td>
										</tr>
										<tr>
											<th>보내실 곳</th>
											<td>${product.returnplace}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>