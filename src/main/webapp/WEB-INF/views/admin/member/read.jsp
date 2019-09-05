<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function deleteUser(mno){
		if(confirm("해당 유저의 정보를 삭제합니다.") == true){
			location.href="delete?mno="+${member.mno};
		}else{
			return false;
		}
	}
</script>
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
		</tr>
		<tr align="center">
			<td>${member.mno }</td>
			<td>${member.id }</td>
			<td>${member.name }</td>
			<td>${member.tel }</td>
			<td>${member.createddate }</td>
			<c:choose>
				<c:when test="${member.mlevel eq 0 }"><td>일반회원</td></c:when>
				<c:when test="${member.mlevel eq 1 }"><td>관리자</td></c:when>
			</c:choose>
		</tr>
	</table>
		<button type="button" onclick="location.href='./list'">목록으로 돌아가기</button>
		<button type="button" onclick="location.href='./update?mno=${member.mno}'">수정</button>
		<button type="button" onclick="deleteUser(${member.mno});">삭제</button>
</body>
</html>