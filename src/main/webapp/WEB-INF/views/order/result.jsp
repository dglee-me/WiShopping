<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>위쇼핑! - 주문완료</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="body" class="orders order_result" style="padding-bottom:0px;">
		<div id="order_result">
			<div class="image success"></div>
			<a href="${pageContext.request.contextPath}/">
				<div class="icon">주문현황보기</div>
			</a>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>