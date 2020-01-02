<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>위쇼핑 ! - 기획전</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="promotions-feed container">
			<ul class="row promotions-feed_list">
				<c:forEach var="promotion" items="${promotions}">
					<li class="col-6">
						<a class="promotions-item" href="${pageContext.request.contextPath}/promotions/view?pno=${promotion.pno}">
							<div class="promotions-item_image-wrap">
								<img class="promotions-item_image" src="${pageContext.request.contextPath}${promotion.thumbnailurl}">
							</div>
							<div class="promotions-item_footer">
								<div class="promotions-item_footer_date">${promotion.startdate} ~ ${promotion.enddate}</div>
								<c:if test="${promotion.status eq 1}">
									<div class="promotions-item_footer_state promotions-item_footer_state-doing">진행중</div>
								</c:if>
								<c:if test="${promotion.status eq 0}">
									<div class="promotions-item_footer_state">종료</div>
								</c:if>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
</body>
</html>