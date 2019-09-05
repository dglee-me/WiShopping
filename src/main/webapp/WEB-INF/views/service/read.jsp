<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${board.subject }</title>
<style type="text/css">
	.read_form{
		padding:0px;
		margin:0px;
		text-align:center;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"/>
	<div class="read_form">
		<div class="read_form_subject">
			<div class="read_form_subject_bno">${board.bno }</div>
			<div class="read_form_subject_category">${board.category }</div>
		</div>
	</div>
</body>
</html>