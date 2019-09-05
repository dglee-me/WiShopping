<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
</style>
<title>회원 관리</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"/>
	<table align="center">
		<tr>
			<th>회원 번호</th>
			<th>ID</th>
			<th>이름</th>
			<th>전화 번호</th>
			<th>생성 날짜</th>
			<th>회원 등급</th>
			<th>비고</th>
		</tr>
		<c:forEach var="members" items="${members }">
			<tr align="center">
				<td>${members.mno }</td>
				<td>${members.id }</td>
				<td>${members.name }</td>
				<td>${members.tel }</td>
				<td>${members.createddate }</td>
				<c:choose>
					<c:when test="${members.mlevel eq 0 }"><td>일반회원</td></c:when>
					<c:when test="${members.mlevel eq 1 }"><td>관리자</td></c:when>
				</c:choose>
				<td><a href="./read?mno=${members.mno }">[상세보기]</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>