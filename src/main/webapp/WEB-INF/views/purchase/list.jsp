<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	//selectbox option selected setting when page entry
	$(document).ready(function(){
		var url = window.location.search.substring(1);
		var arr = url.split("&");
		
		if(arr.length == 1){
			var param =  arr[0].split("=")[0];
			var val = arr[0].split("=")[1];
			
			if(param == "before"){
				var select = $("#delivery_before option");
				
				$.each(select, function(){
					if($(this).val() == val){
						$(this).attr("selected","selected");
					}
				});
			}else if(param == "status"){
				var select = $("#delivery_status option");
				
				$.each(select, function(){
					if($(this).val() == val){
						$(this).attr("selected","selected");
					}
				});
			}
		}else{ // Before and status all select
			var before = $("#delivery_before option");
			var status = $("#delivery_status option");
			
			var before_val = arr[0].split("=")[1];
			var status_val = arr[1].split("=")[1];

			$.each(before, function(){
				if($(this).val() == before_val){
					$(this).attr("selected","selected");
				}
			});

			$.each(status, function(){
				if($(this).val() == status_val){
					$(this).attr("selected","selected");
				}
			});
		}
		
		$(".step").click(function(){
			var status = $(this).attr("data-status");
			var before = $("#delivery_before").val();
			
			if(before == 3){
				location.href = "/WiShopping/purchase/list?status="+status;
			}else{
				location.href = "/WiShopping/purchase/list?before="+before+"&status="+status;
			}
		});
	})
	
	
	$(document).ready(function(){
		//Regist review
		$(".write_comments").click(function(){
			$("body").css("overflow-y","hidden");

			var pno = $(this).parent().parent().siblings("a").attr("href");
			pno = pno.slice(pno.indexOf('=') + 1);
			
			var thumb = $(this).parent().parent().siblings("a").children().attr("style").replace("'","");
			var brand = $(this).parent().parent().siblings(".product_info").children(".product_title").children(".product_brand").text();
			var name = $(this).parent().parent().siblings(".product_info").children(".product_title").children(".product_name").text();
			var option = $(this).parent().parent().siblings(".product_info").children(".product_detail").children(".option_name").text();
			var ono = $(this).parent().parent().siblings(".product_info").children(".product_detail").children(".option_name").attr("data-number");
			
			
			var div = document.createElement("div");
			div.className = "popup new ui-popup ui-editing-popup";
			
			div.innerHTML = 
				"<div class='close_popup'>"+
				"<div class='pop_extra'>"+
				"<div class='pop_container'>"+
				"<div id='production_review_popup'>"+
				"<div class='title'>리뷰쓰기</div>"+
				"<form id='production_review_form' action='production_review' enctype='multipart/form-data' method='post'>"+
				"<input type='hidden' name='production_review[pno]' value='"+pno+"'>"+
				"<div class='select_production field'>"+
				"<div class='production_image' style='"+thumb+"'></div>"+
				"<div class='production_info'>"+
				"<div class='brand_name'>"+brand+"</div>"+
				"<div class='name'>"+name+"</div>"+
				"<div class='option' data-number='"+ono+"'>"+option+"</div>"+
				"</div>"+
				"</div>"+
				"<div class='select_img field'>"+
				"<div class='title'>사진을 등록해주세요. <span class='caption'>(선택)</span></div>"+
				"<div class='guide'><strong>상품과 관련이 없거나 부적합한 사진을 등록하는 경우, 사진이 삭제될 수 있습니다.</strong></div>"+
				"<div id='upload_panel'><img src=''><div id='delete_review_image'>사진 삭제하기</div></div>"+
				"<div id='add_review_image'>새로운 사진 업로드<input type='file' name='review_image' id='image_uploader'></div>"+
				"</div>"+
				"<div class='select_comment field'>"+
				"<div class='title'>리뷰를 작성해주세요.</div>"+
				"<div class='guide'>제품의 소감을 자세하게 작성하여주세요.</div>"+
				"<div class='counting'>최소 20자</div>"+
				"<textarea placeholder='이 제품을 사용하면서 느꼈던 장점과 단점을 솔직하게 알려주세요.' name='production_review[comment]' id='production_review_comment'></textarea>"+
				"<div class='refer'>*해당 상품과 무관한 내용이나 동일 문자의 반복 등 부적합한 내용은 삭제될 수 있습니다.</div>"+
				"</div>"+
				"<div class='actions'>"+
				"<input type='button' name='commit' value='등록하기' id='submit' class='submit'>"+
				"<div class='close_popup cancel'>취소하기</div>"+
				"</div>"+
				"</form>"+
				"</div>"+
				"</div>"+
				"</div>"+
				"</div>"+
				"</div>";
			
			$("body").append(div);
		});
		
		//Before and status reflect
		$("#delivery_before").change(function(){
			var status = $("#delivery_status").val();
			var before = $(this).val();
			
			if(status == -1){
				location.href = "/WiShopping/purchase/list?before="+before;
			}else{
				location.href = "/WiShopping/purchase/list?before="+before+"&status="+status;
			}
		});

		//status and before reflect
		$("#delivery_status").change(function(){
			var status = $(this).val();
			var before = $("#delivery_before").val();
			
			if(before == 3){
				location.href = "/WiShopping/purchase/list?status="+status;
			}else{
				location.href = "/WiShopping/purchase/list?before="+before+"&status="+status;
			}
		});
	});
	
	//Add review image
	$(document).on("click","#add_review_image",function(){
		$("#image_uploader").click();
	});
	
	//Modify review image file input
	$(document).on("change","#image_uploader",function(){
		if(this.files && this.files[0]){
			$("#upload_panel").css("display","block");
			var reader = new FileReader;
			reader.onload = function(data){
				$("#upload_panel img").attr("src", data.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
	
	//Delete review image file input
	$(document).on("click","#delete_review_image",function(){
		//Init
		$("#upload_panel img").attr("src", "");
		$("#upload_panel").css("display","none");
		
		$("#image_uploader").val("");
	});
	
	//Delete review layer pop-up when cancel btn click
	$(document).on("click",".cancel",function(){
		var var_confirm = confirm("작성중인 내용이 사라집니다.");
	
		if(var_confirm){
			$("body").css("overflow-y","scroll");
			$(".ui-editing-popup").remove();
		}
	});
	
	//Delete review layer pop-up when click outside review area
	$(document).ready(function(){
		$("html").click(function(e){
			if($(e.target).hasClass("pop_container")){
				var var_confirm = confirm("작성중인 내용이 사라집니다.");
				
				if(var_confirm){
					$("body").css("overflow-y","scroll");
					$(".ui-editing-popup").remove();
				}
			}
		});
	});
		
	//Regist review
	$(document).on("click",".submit",function(){
		var formData = new FormData($("#production_review_form")[0]);
		
		formData.append("pno",$("input:hidden[name='production_review[pno]']").val());
		formData.append("ono", $(".option").attr("data-number"));
		formData.append("content",$("#production_review_comment").val());
		formData.append("image",$("#image_uploader")[0].files[0]);
		
		if(formData.get("image") == "undefined"){
			formData.delete("image");
		}
		
		$.ajax({
			url : "/WiShopping/productions/review",
			type : "post",
			contentType: false,
			processData: false,
			data : formData,
			success : function(result){
				if(result == 0) location.href= "/WiShopping/auth/login";
				else if(result == 1){
					alert("리뷰가 정상 등록되었습니다.");
					
					//Init
					$("body").css("overflow-y","scroll");
					$(".ui-editing-popup").remove();
					
					location.reload();
				}
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>위쇼핑! - 마이쇼핑</title>
</head>
<body>
	<c:set var="count_0" value="0"/>
	<c:set var="count_1" value="0"/>
	<c:set var="count_2" value="0"/>
	<c:set var="count_3" value="0"/>
	<c:set var="count_4" value="0"/>
	<c:set var="count_5" value="0"/>
	<c:forEach var="status" items="${status}">
		<c:if test="${status.deliverystatus eq 0}">
			<c:set var="count_0" value="${count_0 + 1}"/>
		</c:if>
		<c:if test="${status.deliverystatus eq 1}">
			<c:set var="count_1" value="${count_1 + 1}"/>
		</c:if>
		<c:if test="${status.deliverystatus eq 2}">
			<c:set var="count_2" value="${count_2 + 1}"/>
		</c:if>
		<c:if test="${status.deliverystatus eq 3}">
			<c:set var="count_3" value="${count_3 + 1}"/>
		</c:if>
		<c:if test="${status.deliverystatus eq 4}">
			<c:set var="count_4" value="${count_4 + 1}"/>
		</c:if>
		<c:if test="${status.deliverystatus eq 5}">
			<c:set var="count_5" value="${count_5 + 1}"/>
		</c:if>
	</c:forEach>
	
	<div id="wrapper">
		<jsp:include page="../header.jsp"/>
		<div id="body" class="user_shopping_page order_list">
			<div class="my_mileage">
				<a class="slot" href="javascript:void(0);">
					<div class="coupon icon"></div>
            		<div class="inform">쿠폰</div>
            		<div class="count">0</div>
				</a>
				<a class="slot center" href="javascript:void(0);">
					<div class="mileage icon"></div>
					<div class="inform">포인트</div>
					<div class="count">0</div>
				</a>
				<div id="btn-popup-rating" class="slot">
	                <div class="icon icon icon-promotion-welcome"></div>
		            <div class="inform">구매등급</div>
		            <div class="count">WELCOME</div>
       			 </div>
			</div>
			<div class="order_status">
				<div class="step" data-status="0">
					<div class="title">입금대기</div>
					<div class="count">${count_0}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="1">
					<div class="title">결제완료</div>
					<div class="count">${count_1}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="2">
					<div class="title">배송준비</div>
					<div class="count">${count_2}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="3">
					<div class="title">배송중</div>
					<div class="count">${count_3}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="4">
					<div class="title">배송완료</div>
					<div class="count">${count_4}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="">
					<div class="title">리뷰쓰기</div>
					<div class="count">${count_5}</div>
				</div>
			</div>
			<div class="order_list_set">
				<div class="order_filter">
					<select id="delivery_before">
						<option value="1">1개월전</option>
						<option value="3" selected>3개월전</option>
						<option value="6">6개월전</option>
						<option value="12">1년전</option>
						<option value="24">2년전</option>
						<option value="36">3년전</option>
						<option value="-1">전체선택</option>
					</select>
					<select id="delivery_status">
						<option value="-1" selected>전체상태</option>
						<option value="0">입금대기</option>
						<option value="1">결제완료</option>
						<option value="2">배송준비</option>
						<option value="3">배송중</option>
						<option value="4">배송완료</option>
						<option value="5">구매확정</option>
						<option value="6">리뷰쓰기</option>
						<option value="7">취소</option>
						<option value="8">교환</option>
						<option value="9">환불</option>
					</select>
				</div>
				<c:if test="${empty ordernos}">
					<div class="not_have_result">
						주문 내역이 없습니다.
					</div>
				</c:if>
				<c:if test="${!empty ordernos}">
					<c:forEach var="orderno" items="${ordernos}">
					<div class="order_list">
						<div class="head">
							<div class="order_num">${orderno.orderno} | ${orderno.orderdate}</div>
							<a class="order-list_item_title_link" href="${pageContext.request.contextPath}/purchase/detail?orderno=${orderno.orderno}">
								<div>상세보기</div>
								<div class="image_arrow"></div>
							</a>
						</div>
						<c:forEach var="order" items="${orders}">
						<c:if test="${order.orderno eq orderno.orderno}">
						<div class="order">
							<a href="${pageContext.request.contextPath}/productions/view?pno=${order.pno}">
								<div class="image" style="background-image:url('${pageContext.request.contextPath}${order.productthumurl}');"></div>
							</a>
							<div class="product_info">
								<div class="product_title">
									<a class="product_brand" href="javascript:void(0);">${order.brand}</a>
									<a class="product_name" href="${pageContext.request.contextPath}/productions/view?pno=${order.pno}">${order.pname}</a>
								</div>
								<div class="product_detail">
									<div class="option_name" data-number="${order.ono}">${order.optioncolor}/${order.optionsize}</div>
									<div class="cost"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.price}"/>원</div>
									<div class="bar">|</div>
									<div class="count"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.inventory}"/>개</div>
									<div class="purchase_state" data-status="${order.deliverystatus}">
										<c:if test="${order.deliverystatus eq 0}">입금대기</c:if>
										<c:if test="${order.deliverystatus eq 1}">결제완료</c:if>
										<c:if test="${order.deliverystatus eq 2}">배송준비</c:if>
										<c:if test="${order.deliverystatus eq 3}">배송중</c:if>
										<c:if test="${order.deliverystatus eq 4}">배송완료</c:if>
										<c:if test="${order.deliverystatus eq 5}">구매확정</c:if>
										<span></span>
										<span class="purchase_state_text">| 택배배송</span>
									</div>
								</div>
							</div>
							<div class="product_button">
								<div class="button">
									<c:if test="${order.reviewstatus eq 0}">
										<button type="button" class="write_comments">리뷰쓰기</button>
									</c:if>
								</div>
							</div>
						</div>
						</c:if>
						</c:forEach>
					</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>