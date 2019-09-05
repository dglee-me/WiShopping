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
	<form action="update" method="post">
		<table align="center">
			<tr>
				<th>회원 번호</th>
				<th>ID</th>
				<th>pw</th>
				<th>이름</th>
				<th>전화 번호</th>
				<th>생성 날짜</th>
				<th>회원 등급</th>
			</tr>
			<tr align="center">
				<td><input type="text" name="mno" value="${member.mno }" readonly></td>
				<td><input type="text" name="id" value="${member.id }" readonly></td>
				<td><input type="password" name="pw"></td>
				<td><input type="text" name="name" value="${member.name }" readonly></td>
				<td><input type="text" name="tel" value="${member.tel }"></td>
				<td>${member.createddate }</td>
				<c:choose>
					<c:when test="${member.mlevel eq 0 }"><td>일반회원</td></c:when>
					<c:when test="${member.mlevel eq 1 }"><td>관리자</td></c:when>
				</c:choose>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
		
		
</body>
</html>