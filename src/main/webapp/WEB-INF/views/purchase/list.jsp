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
	$(document).ready(function(){
		var a = $(".purchase_state");
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
	<c:forEach var="order" items="${orders}">
		<c:if test="${order.deliverystatus eq 0}">
			<c:set var="count_0" value="${count_0 + 1}"/>
		</c:if>
		<c:if test="${order.deliverystatus eq 1}">
			<c:set var="count_1" value="${count_1 + 1}"/>
		</c:if>
		<c:if test="${order.deliverystatus eq 2}">
			<c:set var="count_2" value="${count_2 + 1}"/>
		</c:if>
		<c:if test="${order.deliverystatus eq 3}">
			<c:set var="count_3" value="${count_3 + 1}"/>
		</c:if>
		<c:if test="${order.deliverystatus eq 4}">
			<c:set var="count_4" value="${count_4 + 1}"/>
		</c:if>
		<c:if test="${order.deliverystatus eq 5}">
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
				<div class="step" data-status="">
					<div class="title">입금대기</div>
					<div class="count">${count_0}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="">
					<div class="title">결제완료</div>
					<div class="count">${count_1}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="">
					<div class="title">배송준비</div>
					<div class="count">${count_2}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="">
					<div class="title">배송중</div>
					<div class="count">${count_3}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="">
					<div class="title">배송완료</div>
					<div class="count">${count_4}</div>
				</div>
				<div class="image_arrow"></div>
				<div class="step" data-status="">
					<div class="title">리뷰작성</div>
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
							<a href="javascript:void(0);">
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
									<div class="option_name">${order.optioncolor}/${order.optionsize}</div>
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
									<a class="write_comments" href="javascript:void(0);">리뷰쓰기</a>
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