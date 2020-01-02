<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"/>
	<h1 style="text-align:center;">HELLO!@@@!!!! IT'S ADMIN PAGE!!</h1><br>
	<div>
		<h2><a href="${pageContext.request.contextPath}/admin/write">공지사항 쓰기</a></h2>
		<h2><a href="${pageContext.request.contextPath}/productions/regist">상품 등록</a></h2>
		<h2><a href="${pageContext.request.contextPath}/promotions/regist">프로모션 등록</a></h2>
		<h2><a href="${pageContext.request.contextPath}/admin/banner/regist">배너 등록</a></h2>
		<h2><a href="${pageContext.request.contextPath}/admin/banner/management?status=all">배너 관리</a></h2>
	</div>
</body>
</html>