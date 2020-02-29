<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type='text/javascript'>
	$(document).ready(function(){
		$(".filter-bar-control_button_delivery").click(function(){
			if($(".popout-prepared-delivery").length == 0){
				var url = decodeURI(location.href);
				var split_url = url.split("&");
				
				var check = false;
				
				for(var i=0;i<split_url.length;i++){
					if(split_url[i] == "delivery_free=true") check = true;	
				}
				
				if(check){ //Delivery_free status check, reflect this layer-popup
					var div = document.createElement("div");
					div.innerHTML =
						"<div class='popout popout-prepared popout-prepared-delivery' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
							"<div class='animated-popout drop-down_content open open-active'>"+
								"<div class='drop-down-panel'>"+
									"<ul class='panel-entry-list'>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list-item toggle-schema-list-item'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>무료배송만 보기</span>"+
													"<span class='panel-entry-list_item_right'>"+
														"<span class='toggle-icon checked'><span class='toggle-icon_handle'></span></span>"+
													"</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
									"</ul>"+
								"</div>"+
							"</div>"+
						"</div>";
				}else{
					var div = document.createElement("div");
					div.innerHTML =
						"<div class='popout popout-prepared popout-prepared-delivery' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
							"<div class='animated-popout drop-down_content open open-active'>"+
								"<div class='drop-down-panel'>"+
									"<ul class='panel-entry-list'>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list-item toggle-schema-list-item'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>무료배송만 보기</span>"+
													"<span class='panel-entry-list_item_right'>"+
														"<span class='toggle-icon'><span class='toggle-icon_handle'></span></span>"+
													"</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
									"</ul>"+
								"</div>"+
							"</div>"+
						"</div>";
				}
				$("body").append(div);
			}else{
				$(".popout-prepared-delivery").parent().remove();
			}
		});
	});
	
	//Delivery toggle btn clicked event
	$(document).on("click", ".panel-entry-list_item_right", function(){
		var url = decodeURI(location.href);
		var query = url.split("&");
		
		if($(this).children().hasClass("checked")){
			//Url init.
			var string = "";
			for(var i=0;i<query.length;i++){
				if(query[i] == "delivery_free=true") continue;
				
				if(i == 0) string = query[i];
				else string = string + "&" + query[i];
			}
			
			location.href = string;
		}else{
			location.href = url+"&delivery_free=true";
		}
	});
	
	//Tag button clicked event
	$(document).ready(function(){
		$(".filter-bar_tag_delivery").click(function(){
			var url = decodeURI(location.href);
			var query = url.split("&");
			
			//Url init.
			var string = "";
			for(var i=0;i<query.length;i++){
				if(query[i] == "delivery_free=true") continue;
				
				if(i == 0) string = query[i];
				else string = string + "&" + query[i];
			}
			
			location.href = string;
		});

		$(".filter-bar_tag_price").click(function(){
			var url = decodeURI(location.href);
			var query = url.split("&");
			
			//Url init.
			var string = "";
			for(var i=0;i<query.length;i++){
				if(query[i].startsWith("min") || query[i].startsWith("max")) continue;
				
				if(i == 0) string = query[i];
				else string = string + "&" + query[i];
			}
			
			location.href = string;
		});
		
	});
	
	$(document).on("click", ".filter-bar-control_button_price", function(){
		if($(".popout-prepared-price").length == 0){
			if($(this).hasClass("active")){
				var price = "${price}";

				if(price.split(" ~ ").length == 1){
					var url = decodeURI(location.href);
					var temp = url.split("&");
					
					var type = false;
					for(var i=0;i<temp.length;i++){
						if(temp[i].startsWith("min")){
							type = true; // True if min, false if max
						}
					}
					
					temp = price.split(" ~ ")[0].replace("원", "");
					
					if(type){
						var div = document.createElement("div");
						div.innerHTML =
							"<div class='popout popout-prepared popout-prepared-price' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
								"<div class='animated-popout drop-down_content open open-active'>"+
									"<div class='drop-down-panel'>"+
										"<section class='panel-price-range-contrl'>"+
											"<div class='panel-price-range-control_input-row'>"+
												"<span class='panel-price-range-control_input-row_cell'>"+
													"<span class='panel-price-range-control_input-row_header'>최소</span>"+
													"<span class='panel-price-range-control_input-row_input-wrap'>"+
														"<input type='text' name='min' width='5' placeholder='1000' class='panel-price-range-control_input-row_input' value='"+temp+"'>"+
													"</span>"+
													"<span class='panel-price-range-control_input-row_footer'>원</span>"+
												"</span>"+
												"<span class='panel-price-range-control_input-row_separator'>~</span>"+
												"<span class='panel-price-range-control_input-row_cell'>"+
													"<span class='panel-price-range-control_input-row_header'>최대</span>"+
													"<span class='panel-price-range-control_input-row_input-wrap'>"+
														"<input type='text' name='max' width='5' placeholder='1000000' class='panel-price-range-control_input-row_input' value=''>"+
													"</span>"+
													"<span class='panel-price-range-control_input-row_footer'>원</span>"+
												"</span>"+
											"</div>"+
										"</section>"+
									"</div>"+
								"</div>"+
							"</div>";
					}else{
						var div = document.createElement("div");
						div.innerHTML =
							"<div class='popout popout-prepared popout-prepared-price' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
								"<div class='animated-popout drop-down_content open open-active'>"+
									"<div class='drop-down-panel'>"+
										"<section class='panel-price-range-contrl'>"+
											"<div class='panel-price-range-control_input-row'>"+
												"<span class='panel-price-range-control_input-row_cell'>"+
													"<span class='panel-price-range-control_input-row_header'>최소</span>"+
													"<span class='panel-price-range-control_input-row_input-wrap'>"+
														"<input type='text' name='min' width='5' placeholder='1000' class='panel-price-range-control_input-row_input' value=''>"+
													"</span>"+
													"<span class='panel-price-range-control_input-row_footer'>원</span>"+
												"</span>"+
												"<span class='panel-price-range-control_input-row_separator'>~</span>"+
												"<span class='panel-price-range-control_input-row_cell'>"+
													"<span class='panel-price-range-control_input-row_header'>최대</span>"+
													"<span class='panel-price-range-control_input-row_input-wrap'>"+
														"<input type='text' name='max' width='5' placeholder='1000000' class='panel-price-range-control_input-row_input' value='"+temp+"'>"+
													"</span>"+
													"<span class='panel-price-range-control_input-row_footer'>원</span>"+
												"</span>"+
											"</div>"+
										"</section>"+
									"</div>"+
								"</div>"+
							"</div>";
					}
				}else{
					var min = price.split(" ~ ")[0].replace("원", "");
					var max = price.split(" ~ ")[1].replace("원", "");

					var div = document.createElement("div");
					div.innerHTML =
						"<div class='popout popout-prepared popout-prepared-price' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
							"<div class='animated-popout drop-down_content open open-active'>"+
								"<div class='drop-down-panel'>"+
									"<section class='panel-price-range-contrl'>"+
										"<div class='panel-price-range-control_input-row'>"+
											"<span class='panel-price-range-control_input-row_cell'>"+
												"<span class='panel-price-range-control_input-row_header'>최소</span>"+
												"<span class='panel-price-range-control_input-row_input-wrap'>"+
													"<input type='text' name='min' width='5' placeholder='1000' class='panel-price-range-control_input-row_input' value='"+min+"'>"+
												"</span>"+
												"<span class='panel-price-range-control_input-row_footer'>원</span>"+
											"</span>"+
											"<span class='panel-price-range-control_input-row_separator'>~</span>"+
											"<span class='panel-price-range-control_input-row_cell'>"+
												"<span class='panel-price-range-control_input-row_header'>최대</span>"+
												"<span class='panel-price-range-control_input-row_input-wrap'>"+
													"<input type='text' name='max' width='5' placeholder='1000000' class='panel-price-range-control_input-row_input' value='"+max+"'>"+
												"</span>"+
												"<span class='panel-price-range-control_input-row_footer'>원</span>"+
											"</span>"+
										"</div>"+
									"</section>"+
								"</div>"+
							"</div>"+
						"</div>";
				}
			}else{
				var div = document.createElement("div");
				div.innerHTML =
					"<div class='popout popout-prepared popout-prepared-price' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
						"<div class='animated-popout drop-down_content open open-active'>"+
							"<div class='drop-down-panel'>"+
								"<section class='panel-price-range-contrl'>"+
									"<div class='panel-price-range-control_input-row'>"+
										"<span class='panel-price-range-control_input-row_cell'>"+
											"<span class='panel-price-range-control_input-row_header'>최소</span>"+
											"<span class='panel-price-range-control_input-row_input-wrap'>"+
												"<input type='text' name='min' width='5' placeholder='1000' class='panel-price-range-control_input-row_input' value=''>"+
											"</span>"+
											"<span class='panel-price-range-control_input-row_footer'>원</span>"+
										"</span>"+
										"<span class='panel-price-range-control_input-row_separator'>~</span>"+
										"<span class='panel-price-range-control_input-row_cell'>"+
											"<span class='panel-price-range-control_input-row_header'>최대</span>"+
											"<span class='panel-price-range-control_input-row_input-wrap'>"+
												"<input type='text' name='max' width='5' placeholder='1000000' class='panel-price-range-control_input-row_input' value=''>"+
											"</span>"+
											"<span class='panel-price-range-control_input-row_footer'>원</span>"+
										"</span>"+
									"</div>"+
								"</section>"+
							"</div>"+
						"</div>"+
					"</div>";
			}
			
			$("body").append(div);
		}else{
			$(".popout-prepared-price").parent().remove();
		}
	});
	
	//Price popup exit event
	$(document).on("mouseleave", ".popout-prepared-price", function(){
		var min = $("input:text[name='min']").val();
		var max = $("input:text[name='max']").val();

		var url = decodeURI(location.href);
		var temp = url.split("&");
		
		//Check min and max value in url
		var min_check = false;
		var max_check = false;
		
		for(var i=0;i<temp.length;i++){
			if(temp[i].startsWith("min")){
				min_check = true;
			}else if(temp[i].startsWith("max")){
				max_check = true;
			}
		}
		
		var string = "";
		if(min_check || max_check){ // Check if the price has already been set
			if(min == "" && max == ""){ //Both max and min are null
				for(var i=0;i<temp.length;i++){
					if(temp[i].startsWith("min") || temp[i].startsWith("max")) continue;
					
					if(i == 0) string = temp[i];
					else string += "&" + temp[i];
				}
				
				location.href = string;
			}else if(min == "" && max != ""){ 
				for(var i=0;i<temp.length;i++){ //Min only null
					if(temp[i].startsWith("min")) continue;
					
					if(i == 0) string = temp[i];
					else string += "&" + temp[i];
				}

				location.href = string;
			}else if(min != "" && max == ""){ //Max only null
				for(var i=0;i<temp.length;i++){
					if(temp[i].startsWith("max")) continue;
					
					if(i == 0) string = temp[i];
					else string += "&" + temp[i];
				}

				location.href = string;
			}else{
				for(var i=0;i<temp.length;i++){
					if(temp[i].startsWith("min")) continue;
					if(temp[i].startsWith("max")) continue;
					
					if(i == 0) string = temp[i];
					else string += "&" + temp[i];
				}
				
				location.href = string+"&min="+min+"&max="+max;
			}
		}else{ // First time price se
			if(!(min == "" && max == "")){
				if(min != "" && max == ""){
					location.href = url+"&min="+min;
				}else if(min == "" && max != ""){
					location.href = url+"&max="+max;
				}else{
					location.href = url+"&min="+min+"&max="+max;
				}
			}else{
				$(this).parent().remove();
			}
		}
	});
	
	$(document).on("click", ".filter-bar-control_order", function(){
		if($(".popout-prepared-order").length == 0){
			var url = decodeURI(location.href);
			var query = url.split("order=")[1];
			
			if(typeof query != "undefined"){
				if(query == "recent"){ // Add selected class.
					var div = document.createElement("div");
					div.innerHTML = 
						"<div class='popout popout-prepared popout-prepared-order' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
							"<div class='animated-popout drop-down_content open open-active'>"+
								"<div class='drop-down-panel'>"+
									"<ul class='panel-entry-list'>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order selected' data-type='recent'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>최신순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='popular'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>인기순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='min_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>낮은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='max_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>높은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
									"</ul>"+
								"</div>"+
							"</div>"+
						"</div>";
				}
				else if(query == "popular"){
					var div = document.createElement("div");
					div.innerHTML = 
						"<div class='popout popout-prepared popout-prepared-order' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
							"<div class='animated-popout drop-down_content open open-active'>"+
								"<div class='drop-down-panel'>"+
									"<ul class='panel-entry-list'>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='recent'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>최신순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order selected' data-type='popular'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>인기순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='min_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>낮은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='max_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>높은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
									"</ul>"+
								"</div>"+
							"</div>"+
						"</div>";
				}
				else if(query == "min_cost"){
					var div = document.createElement("div");
					div.innerHTML = 
						"<div class='popout popout-prepared popout-prepared-order' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
							"<div class='animated-popout drop-down_content open open-active'>"+
								"<div class='drop-down-panel'>"+
									"<ul class='panel-entry-list'>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='recent'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>최신순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='popular'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>인기순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order selected' data-type='min_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>낮은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='max_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>높은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
									"</ul>"+
								"</div>"+
							"</div>"+
						"</div>";
				}
				else if(query == "max_cost"){
					var div = document.createElement("div");
					div.innerHTML = 
						"<div class='popout popout-prepared popout-prepared-order' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
							"<div class='animated-popout drop-down_content open open-active'>"+
								"<div class='drop-down-panel'>"+
									"<ul class='panel-entry-list'>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='recent'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>최신순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='popular'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>인기순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='min_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>낮은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
										"<li class='panel-entry-list_item-wrap'>"+
											"<button type='button' class='panel-entry-list_item panel-entry-list_item-order selected' data-type='max_cost'>"+
												"<div class='panel-entry-list_item_header'>"+
													"<span class='panel-entry-list_item_title'>높은 가격순</span>"+
												"</div>"+
											"</button>"+
										"</li>"+
									"</ul>"+
								"</div>"+
							"</div>"+
						"</div>";
				}
			}else{
				var div = document.createElement("div");
				div.innerHTML = 
					"<div class='popout popout-prepared popout-prepared-order' style='position:absolute; z-index:1000; left:"+$(this).offset().left+"; top:"+($(this).offset().top+30)+"; transform:translateX(-50%);'>"+
						"<div class='animated-popout drop-down_content open open-active'>"+
							"<div class='drop-down-panel'>"+
								"<ul class='panel-entry-list'>"+
									"<li class='panel-entry-list_item-wrap'>"+
										"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='recent'>"+
											"<div class='panel-entry-list_item_header'>"+
												"<span class='panel-entry-list_item_title'>최신순</span>"+
											"</div>"+
										"</button>"+
									"</li>"+
									"<li class='panel-entry-list_item-wrap'>"+
										"<button type='button' class='panel-entry-list_item panel-entry-list_item-order selected' data-type='popular'>"+
											"<div class='panel-entry-list_item_header'>"+
												"<span class='panel-entry-list_item_title'>인기순</span>"+
											"</div>"+
										"</button>"+
									"</li>"+
									"<li class='panel-entry-list_item-wrap'>"+
										"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='min_cost'>"+
											"<div class='panel-entry-list_item_header'>"+
												"<span class='panel-entry-list_item_title'>낮은 가격순</span>"+
											"</div>"+
										"</button>"+
									"</li>"+
									"<li class='panel-entry-list_item-wrap'>"+
										"<button type='button' class='panel-entry-list_item panel-entry-list_item-order' data-type='max_cost'>"+
											"<div class='panel-entry-list_item_header'>"+
												"<span class='panel-entry-list_item_title'>높은 가격순</span>"+
											"</div>"+
										"</button>"+
									"</li>"+
								"</ul>"+
							"</div>"+
						"</div>"+
					"</div>";
			}
			
			$("body").append(div);
		}else{
			$(".popout-prepared-order").parent().remove();
		}
	});
	
	//Reflect select order
	$(document).ready(function(){
		var url = decodeURI(location.href);
		var query = url.split("order=")[1];
		
		if(typeof query != "undefined"){
			var text = "";
			
			if(query == "recent") text = "최신순";
			else if(query == "popular") text = "인기순";
			else if(query == "min_cost") text = "낮은 가격순";
			else if(query == "max_cost") text = "높은 가격순";
			
			$(".filter-bar-order-button_text").text(text);
		}
	});
	
	//Go to url
	$(document).on("click", ".panel-entry-list_item-order", function(){
		var url = decodeURI(location.href);
		
		var query = url.split("&");
		
		var string = "";
		for(var i=0;i<query.length;i++){
			if(query[i].startsWith("order=")) continue;
			
			if(i == 0) string = query[i];
			else string += "&" + query[i];
		}
		
		location.href = string + "&order=" + $(this).attr("data-type");
	});
</script>
<meta charset="UTF-8">
<title>위쇼핑 ! - 검색결과</title>
</head>
<body>
	<c:forEach var="product" items="${items}">
		<c:set var="is_brand" value="${product.isbrand}"/>
		<c:set var="brand" value="${product.brand}"/>
	</c:forEach>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="production-feed container">
			<div class="production-feed_header">
				<h1 class="production-feed_header-title">'${parameter}'에 대한 통합검색 결과
					<span class="production-feed_header-title_number">${count}개</span>
				</h1>
				<c:if test="${is_brand eq 1}">
				<p class="production-feed_header-brand-suggestion">
					<a class="brand-name" href="${pageContext.request.contextPath}/brands/home?query=${brand}">${brand}</a>
					브랜드가 궁금하세요?
				</p>
				</c:if>
			</div>
			<div class="sticky-container production-feed_filter-container" style="position:sticky; top:0px;">
				<div class="sticky-child production-feed_filter-wrap" style="position:relative;">
					<div class="filter production-feed-filter">
						<div class="filter-bar">
							<div class="filter-bar_control-list">
								<ul class="filter-bar_control-list_left">
									<li class="filter-bar_control-list_item">
										<div class="drop-down panel-drop-down filter-bar-control">
											<button class="button button-color-gray button-size-50 filter-bar-control_button <c:if test="${delivery_free ne null}">active</c:if> filter-bar-control_button_delivery">배송
												<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
													<path d="M6.069 6.72l4.123-3.783 1.216 1.326-5.32 4.881L.603 4.273l1.196-1.346z"></path>
												</svg>
											</button>
										</div>
									</li>
									<li class="filter-bar_control-list_item">
										<div class="drop-down panel-drop-down filter-bar-control">
											<button class="button button-color-gray button-size-50 filter-bar-control_button <c:if test="${!empty price}">active</c:if> filter-bar-control_button_price">가격
												<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
													<path d="M6.069 6.72l4.123-3.783 1.216 1.326-5.32 4.881L.603 4.273l1.196-1.346z"></path>
												</svg>
											</button>
										</div>
									</li>
								</ul>
								<ul class="filter-bar_control-list_right">
									<li class="filter-bar_control-list_item">
										<div class="drop-down panel-drop-down filter-bar-control filter-bar-control_order">
											<button class="filter-bar-order-button" type="button"><span class="filter-bar-order-button_text">인기순</span>
												<svg class="caret" width="8" height="8" viewBox="0 0 8 8" preserveAspectRatio="xMidYMid meet">
													<path fill="#BDBDBD" d="M0 2l4 4 4-4z"></path>
												</svg>
											</button>
										</div>
									</li>
								</ul>
							</div>
							<ul class="filter-bar_tag-list">
								<c:if test="${delivery_free ne null}">
								<li class="filter-bar_tag-list_item">
									<button class="button button-color-blue filter-bar_tag filter-bar_tag_delivery" type="button">무료배송
										<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
											<path d="M6 4.94L3.879 2.817l-1.061 1.06L4.939 6 2.818 8.121l1.06 1.061L6 7.061l2.121 2.121 1.061-1.06L7.061 6l2.121-2.121-1.06-1.061L6 4.939zM6 12A6 6 0 1 1 6 0a6 6 0 0 1 0 12z"></path>
										</svg>
									</button>
								</li>
								</c:if>
								<c:if test="${!empty price}">
								<li class="filter-bar_tag-list_item">
									<button class="button button-color-blue filter-bar_tag filter-bar_tag_price" type="button">${price}
										<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
											<path d="M6 4.94L3.879 2.817l-1.061 1.06L4.939 6 2.818 8.121l1.06 1.061L6 7.061l2.121 2.121 1.061-1.06L7.061 6l2.121-2.121-1.06-1.061L6 4.939zM6 12A6 6 0 1 1 6 0a6 6 0 0 1 0 12z"></path>
										</svg>
									</button>
								</li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<c:if test="${!empty items}">
				<div class="production-feed_content row">
					<c:forEach var="product" items="${items}">
						<div class="production-feed_item-wrap">
							<article class="production-item">
								<a href="${pageContext.request.contextPath}/productions/${product.pno}" class="production-item_overlay"></a>
								<div class="production-item-image">
									<img class="image" src="${pageContext.request.contextPath}${product.productthumurl}">
								</div>
								<div class="production-item-content">
									<h1 class="production-item_header">
										<span class="production-item_header__brand">${product.brand}</span>
										<span class="production-item_header__name">${product.pname}</span>
									</h1>
									<span class="production-item-price">
										<span class="production-item-price__price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/></span>
									</span>
								</div>
							</article>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${empty items}">
				<div class="production-feed_empty">
					<p>앗! 찾으시는 결과가 없어요!</p>
				</div>
			</c:if>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>