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
	
	//Review counting
	$(document).ready(function(){
		var count = $(".production-review-feed-item_container").length;
		
		$(".product_selling_section-header-title .count").text(count);
	});
	
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
			}
			
			$("html, body").animate({scrollTop : href.top},300);
		});
	});
	
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
		if($(e.target).hasClass("modal-image-modal_modal")){
			$("body").css("overflow-y","scroll");
			$("#modal-image-modal_modal").remove();
		}
	});
	
	$(document).ready(function(){
		$(".product_selling_section-right button").click(function(){
			location.href="/WiShopping/purchase/list";			
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
	
	//Check if the like btn when entering the view
	$(document).ready(function(){
		var url = location.href;
		var pno = url.slice(url.indexOf("=") + 1);
		
		$.ajax({
			url : "/WiShopping/productions/likecheck",
			type : "post",
			data : {pno : pno},
			success : function(list){
				var review = $(".production-review-item");
				
				$.each(list, function(){
					var rno = this.rno;
					
					for(var i=0;i<review.length;i++){
						var temp = $(review[i]);
						
						if(temp.attr("data-number") == rno){
							temp.children(".production-review-item_like").children("button").addClass("production-review-item_like_btn-active");
						}
					}
				});
			}
		});
	});
	
	//review like count setting when entering the view
	$(document).ready(function(){
		var url = location.href;
		var pno = url.slice(url.indexOf("=") + 1);
		
		$.ajax({
			url : "/WiShopping/productions/likecount",
			type : "post",
			data : {pno : pno},
			success : function(list){
				var review = $(".production-review-item");
				
				$.each(list, function(){
					var rno = this.rno;
					var count = this.count;
					
					for(var i=0;i<review.length;i++){
						var temp = $(review[i]);
						
						if(temp.attr("data-number") == rno){
							temp.children(".production-review-item_like")
								.children(".production-review-item_like_text").children(".production-review-item_help_like_number").text(count);
						}
					}
				});
			}
		})
	});
	
	//Change the active state to the corresponding Nav when scrolling
	$(window).scroll(function(){
		var $window = $(window);
		var $body = $("body");
		
		var scroll = $window.scrollTop() + ($window.height() / 3);
		
		var info = $("#production-selling-information").offset().top;
		var review = $("#production-selling-review").offset().top;

		if(scroll >= info &&scroll <= review){
			$(".product_selling_nav_item-active").removeClass("product_selling_nav_item-active");
			$($(".product_selling_nav_item")[0]).addClass("product_selling_nav_item-active");
		}else if(scroll >= review){
			$(".product_selling_nav_item-active").removeClass("product_selling_nav_item-active");
			$($(".product_selling_nav_item")[1]).addClass("product_selling_nav_item-active");
		}
	});
	

	$(document).ready(function(){
		//Prev button click event
		$(".list-paginator_prev").click(function(){
			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			var page = parseInt($(".list-paginator_page.selected").text(),10) - 1;
			var prev_page = $(".list-paginator_page.selected").parent().prev().children();

			if(page > 0){
				if(page >= 9){
					var ul = $(".list-paginator li:first-child");
					
					var li = document.createElement("li");
					li.innerHTML = "<button class='list-paginator_page'>" + (parseInt(page,10) - 8) + "</button>";

					$(".selected").parent().remove();
					ul.after(li);
				}
				
				$.ajax({
					url : "/WiShopping/productions/reviewListUpdate",
					type : "post",
					data : {
						page : page,
						pno : pno	
					},success : function(map){
						$(".production-review-feed-item_container").remove(); //Delete an existing oul

						var reviews = map.reviews;
						var likecheck = map.likecheck;
						var count = map.count;
						
						$.each(reviews, function(){
							//date fomrat init
							var date = new Date(this.writedate);
							
							var year = date.getFullYear();
							var month = (1 + date.getMonth());
							month = month >= 10 ? month : "0" + month;
							var day = date.getDate();
							
							date = year + "-" + month + "-" +day;

							var check = false;
							
							for(var i=0;i<likecheck.length;i++){
								if(this.rno == likecheck[i].rno){
									check = true;
								}
							}
							
							var likeCount = 0;
							
							if(check == true){
								//Setting like count
								for(var i=0;i<count.length;i++){
									if(this.rno == count[i].rno){
										likeCount = count[i].count;
									}
								}
								
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
									"<span class='production-review-item_help_like_number'>"+likeCount+"</span>명이 좋아했습니다."+
									"</div>"+
									"</div>"+
									"</article>"
							}else{
								//Setting like count
								for(var i=0;i<count.length;i++){
									if(this.rno == count[i].rno){
										likeCount = count[i].count;
									}
								}

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
									"<span class='production-review-item_help_like_number'>"+likeCount+"</span>명이 좋아했습니다."+
									"</div>"+
									"</div>"+
									"</div>"+
									"</article>"+
									"</div>";
							}
							
							$(".production-review-feed_list").append(div);
							$(".selected").removeClass("selected");
							prev_page.addClass("selected");
						});
					}
				});
			}
		});
		
		//Next button click event
		$(".list-paginator_next").click(function(){
			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			var page = parseInt($(".list-paginator_page.selected").text(),10) + 1;
			
			$.ajax({
				url : "/WiShopping/productions/reviewListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					var page_nav = parseInt(count / 5,10) + 1;
					
					//Only run when the next page is less than or equal to the navigator
					if(page <= page_nav){
						//Create page button
						if(page > 9){
							$(".list-paginator li:first-child").next().remove();
							
							var ul = $(".list-paginator li:last-child");
							
							var li = document.createElement("li");
							li.innerHTML = "<button class='list-paginator_page'>" + page + "</button>";
								
							ul.before(li);
						}

						var next_page = $(".list-paginator_page.selected").parent().next().children();
						
						$.ajax({
							url : "/WiShopping/productions/reviewListUpdate",
							type : "post",
							async: false,
							data : {
								page : page,
								pno : pno	
							},success : function(map){
								$(".production-review-feed-item_container").remove(); //Delete an existing review

								var reviews = map.reviews;
								var likecheck = map.likecheck;
								var count = map.count;
								
								$.each(reviews, function(){
									//date fomrat init
									var date = new Date(this.writedate);
									
									var year = date.getFullYear();
									var month = (1 + date.getMonth());
									month = month >= 10 ? month : "0" + month;
									var day = date.getDate();
									
									date = year + "-" + month + "-" +day;

									var check = false;
									
									for(var i=0;i<likecheck.length;i++){
										if(this.rno == likecheck[i].rno){
											check = true;
										}
									}
									
									var likeCount = 0;
									
									if(check == true){
										//Setting like count
										for(var i=0;i<count.length;i++){
											if(this.rno == count[i].rno){
												likeCount = count[i].count;
											}
										}
										
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
											"<span class='production-review-item_help_like_number'>"+likeCount+"</span>명이 좋아했습니다."+
											"</div>"+
											"</div>"+
											"</div>"+
											"</article>"+
											"</div>";
									}else{
										//Setting like count
										for(var i=0;i<count.length;i++){
											if(this.rno == count[i].rno){
												likeCount = count[i].count;
											}
										}

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
											"<span class='production-review-item_help_like_number'>"+likeCount+"</span>명이 좋아했습니다."+
											"</div>"+
											"</div>"+
											"</div>"+
											"</article>"+
											"</div>";
									}
									
									$(".production-review-feed_list").append(div);
									$(".selected").removeClass("selected");
									next_page.addClass("selected");
								});
							}
						});
					}
				}
			});
		});
	});


	//Reflect when selecting comment page
	$(document).on("click",".list-paginator_page",function(){
		var curPage = $(this);
		
		var page = $(this).text();
		var idx = $(".list-paginator_page");

		$(".selected").removeClass("selected");

		var url = decodeURI(location.href);
		var pno = url.slice(url.indexOf('=') + 1);
		
		//ajax to know page list count
		$.ajax({
			url : "/WiShopping/productions/reviewListCount",
			type : "post",
			data : {pno : pno},
			success : function(count){
				var max = parseInt((count/5),10) + 1;
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
						pno : pno	
					},success : function(map){
						$(".production-review-feed-item_container").remove(); //Delete an existing review

						var reviews = map.reviews;
						var likecheck = map.likecheck;
						var count = map.count;
						
						$.each(reviews, function(){
							//date fomrat init
							var date = new Date(this.writedate);
							
							var year = date.getFullYear();
							var month = (1 + date.getMonth());
							month = month >= 10 ? month : "0" + month;
							var day = date.getDate();
							
							date = year + "-" + month + "-" +day;

							var check = false;
							
							for(var i=0;i<likecheck.length;i++){
								if(this.rno == likecheck[i].rno){
									check = true;
								}
							}
							
							var likeCount = 0;
							
							if(check == true){
								//Setting like count
								for(var i=0;i<count.length;i++){
									if(this.rno == count[i].rno){
										likeCount = count[i].count;
									}
								}
								
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
									"<span class='production-review-item_help_like_number'>"+likeCount+"</span>명이 좋아했습니다."+
									"</div>"+
									"</div>"+
									"</article>"
							}else{
								//Setting like count
								for(var i=0;i<count.length;i++){
									if(this.rno == count[i].rno){
										likeCount = count[i].count;
									}
								}

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
									"<span class='production-review-item_help_like_number'>"+likeCount+"</span>명이 좋아했습니다."+
									"</div>"+
									"</div>"+
									"</article>"
							}
							
							$(".production-review-feed_list").append(div);
							$(".selected").removeClass("selected");
							curPage.addClass("selected");
						});
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
							<li><a href="#production-selling-information" class="product_selling_nav_item product_selling_nav_item-active">상품정보</a></li>
							<li><a href="#production-selling-review" class="product_selling_nav_item">리뷰</a></li>
							<li><a href="javascript:void(0);" class="product_selling_nav_item">문의</a></li>
							<li><a href="javascript:void(0);" class="product_selling_nav_item">배송/환불</a></li>
						</ol>
					</nav>
				</div>
			</div>
			<div class="production-selling_detail-wrap container">
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
								<h1 class="product_selling_section-header-title">리뷰<span class="count">0</span></h1>
								<div class="product_selling_section-right"><button type="button">리뷰쓰기</button></div>
							</header>
							<div class="production-review-feed">
								<div class="filter">
									<div class="production-review-feed_filter-wrap">
										<div class="production-review-feed_filter">
											<div class="production-review-feed_filter_order-list">
												<button class="production-review-feed_filter_order production-review-feed_filter_order-active" type="button">최신순</button>
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
												<button type="button" class="production-review-item_like_btn">좋아요</button>
												<div class="production-review-item_like_text">
													<span class="production-review-item_help_like_number">0</span>명이 좋아했습니다.
												</div>
											</div>
										</article>
									</div>
									</c:forEach>
								</div>
								<ul class="list-paginator production-review_paginator">
									<li>
										<button class="list-paginator_prev" type="button">
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
												<button class="list-paginator_page selected">${idx}</button>
											</c:if>
											<c:if test="${idx ne 1}">
												<button class="list-paginator_page">${idx}</button>
											</c:if>
										</li>
									</c:forEach>
									<li>
										<button class="list-paginator_next" type="button">
											<svg width="26" height="26" viewBox="0 0 26 26" preserveAspectRatio="xMidYMid meet">
												<g fill="none" fill-rule="evenodd" transform="matrix(-1 0 0 1 26 0)">
													<rect width="25" height="25" x=".5" y=".5" stroke="#DCDCDC" rx="4"></rect>
												<g stroke="#424242" stroke-linecap="square" stroke-width="2">
												<path d="M14.75 8.263L10.25 13M10.25 13l4.5 4.737"></path></g></g>
											</svg>
										</button>
									</li>
								</ul>
							</div>
						</div>
						<a id="production-selling-question"></a>
						<div class="product_selling_section">
							<header class="product_selling_section-header">
								<h1 class="product_selling_section-header-title">문의 <span class="count">0</span>
								</h1>
								<div class="product_selling_section-right">
									<button>문의하기</button>
								</div>
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