<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js" async></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	//주문한 상품의 업체가 겹칠 시 order_delivery의 노출여부 확인
	$(document).ready(function(){
		var delivery = $(".order_delivery");
		
		var isExist = false;
		var existDiv = false;
		var exist_div_text = false;
		
		$.each(delivery, function(){
			var thisObject = this;
			var text = $(thisObject).text();
			
			if(isExist == false){
				isExist = thisObject;
				exist_div_text = text;
			}else if(exist_div_text != text){
				isExist = thisObject;
				exist_div_text = text;
			}else{
				$(isExist).remove();
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>위쇼핑! - 주문 상세보기</title>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../header.jsp"/>
		<div id="body" class="orders show" style="padding-bottom:0px;">
			<div class="contents">
				<div class="title">주문상세정보</div>
				<div id="order_detail_info">
					<div class="subtitle">주문번호 : ${order.orderno} | 주문날짜 : ${order.orderdate}</div>
					<div class="table">
						<c:forEach var="purchase" items="${purchase}">
						<c:set var="total_delivery" value="${total_delivery + purchase.shippingfee}"/>
						<div class="order_list">
							<div class="product_image">
								<div class="image" style="background-image:url('${pageContext.request.contextPath}${purchase.productthumurl}')"></div>
							</div>
							<div class="product_detail">
								<a class="name" href="${pageContext.request.contextPath}/productions/${purchase.pno}">[${purchase.brand}] ${purchase.pname}</a>
								<div class="option">컬러: ${purchase.optioncolor} / 사이즈: ${purchase.optionsize}</div>
								<div class="cost"><fmt:formatNumber type="number" maxFractionDigits="3" value="${purchase.price}"/>원</div>
								<div class="count">| ${purchase.inventory}개</div>
								<div class="status">
									<c:if test="${purchase.deliverystatus eq 0}">입금대기</c:if>
									<c:if test="${purchase.deliverystatus eq 1}">결제완료</c:if>
									<c:if test="${purchase.deliverystatus eq 2}">배송준비중</c:if>
									<c:if test="${purchase.deliverystatus eq 3}">배송중</c:if>
									<c:if test="${purchase.deliverystatus eq 4}">배송완료</c:if>
									<c:if test="${purchase.deliverystatus eq 5}">리뷰작성</c:if>
									<span class="status_divider"></span>
									택배배송
								</div>
							</div>
							<div class="button_set">
								<div class="buttons">
									<a class="button" href="javascript:void(0);">주문취소</a>
								</div>
							</div>
						</div>
						<div class="order_delivery">
							<div class="method">
								<c:if test="${purchase.shippingfee eq 0}">무료배송</c:if>
								<c:if test="${purchase.shippingfee ne 0}">선불 ${purchase.shippingfee}원</c:if>
							</div>
							<span class="brand">${purchase.brand} 배송</span>
						</div>
						</c:forEach>
					</div>
				</div>
				<div id="payment_info">
					<div class="subtitle">결제정보</div>
					<div class="wrap_panel divide one">
						<div class="field">
							<div class="title">상품금액</div>
							<div class="content"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.amount - total_delivery}"/>원</div>
						</div>
						<div class="field">
							<div class="title">할인금액</div>
							<div class="content">(-) 0원</div>
						</div>
						<div class="field">
							<div class="title">배송비</div>
							<div class="content">(+) <fmt:formatNumber type="number" maxFractionDigits="3" value="${total_delivery}"/>원</div>
						</div>
						<div class="field">
							<div class="title">사용 포인트</div>
							<div class="content">(-) 0 P</div>
						</div>
						<div class="field">
							<div class="title">결제금액</div>
							<div class="content"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.amount}"/>원</div>
						</div>
						<div class="field">
							<div class="title">결제방법</div>
							<div class="content">신용카드 결제</div>
						</div>
					</div>
					<div class="wrap_panel divide two">
						<div class="field">
							<div class="title">주문자</div>
							<div class="content">${order.payername}</div>
						</div>
						<div class="field">
							<div class="title">연락처</div>
							<div class="content">${order.payerphone}</div>
						</div>
						<div class="field">
							<div class="title">이메일</div>
							<div class="content">${order.payeremail}</div>
						</div>
					</div>
				</div>
				<div id="delivery_info">
					<div class="subtitle">배송지 정보</div>
					<div class="wrap_panel">
						<div class="field">
							<div class="title">수령인</div>
							<div class="content">${order.orderrec}</div>
						</div>
						<div class="field">
							<div class="title">연락처</div>
							<div class="content">${order.receivedphone}</div>
						</div>
						<div class="field">
							<div class="title">주소</div>
							<div class="content">(${order.zipcode})${order.receivedat}${order.receivedatdetail}</div>
						</div>
						<div class="field">
							<div class="title">배송메모</div>
							<div class="content">${order.deliverymessage}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>