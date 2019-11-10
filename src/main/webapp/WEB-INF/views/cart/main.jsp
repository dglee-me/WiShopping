<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>위쇼핑! - 장바구니</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="commerce-cart-empty">
		<div class="commerce-cart-empty_content">
			<img class="commerce-cart-empty_content_image" src="${pageContext.request.contextPath}/resources/image/cart-empty-placeholder.png" alt="장바구니가 비었습니다.">
			<a class="button button-color-blue commerce-cart-empty_content_button" href="${pageContext.request.contextPath}/category/group/fashion">상품 담으러 가기</a>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>