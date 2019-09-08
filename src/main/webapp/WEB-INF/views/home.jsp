<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<html lang="ko">
<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/header_js.js" async></script>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css?after">
</head>
<body>
	<jsp:include page="header.jsp"/>
	
	<footer class="home-footer">©WiShopping<a href="${pageContext.request.contextPath }/admin/main">.</a> All rights reserved.</footer>
</body>
</html>