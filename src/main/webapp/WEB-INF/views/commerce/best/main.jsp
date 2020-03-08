<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	//Your select category highlight
	$(document).ready(function(){
		var url = location.href;
		var category = url.slice((url.indexOf('=') + 1));

		var li = $(".best-category-filter_item");
		
		if(category == "all" || category.length > 3){
			li.removeClass("best-category-filter_item-active");
			$(li[0]).addClass("best-category-filter_item-active");
		}else if(category == "1"){
			li.removeClass("best-category-filter_item-active");
			$(li[1]).addClass("best-category-filter_item-active");
		}else if(category == "2"){
			li.removeClass("best-category-filter_item-active");
			$(li[2]).addClass("best-category-filter_item-active");
		}else if(category == "3"){
			li.removeClass("best-category-filter_item-active");
			$(li[3]).addClass("best-category-filter_item-active");
		}else if(category == "4"){
			li.removeClass("best-category-filter_item-active");
			$(li[4]).addClass("best-category-filter_item-active");
		}
	});
</script>
<meta charset="UTF-8">
<title>위쇼핑 ! - 베스트</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="best-feed">
			<div class="best-feed_title">베스트</div>
			<div class="sticky-container best-feed_header" style="position:sticky; top:0; z-index:10;">
				<div class="sticky-child best-feed_header-child">
					<div class="best-category-filter">
						<ul class="best-category-filter_wrap">
							<li class="best-category-filter_item">
								<a href="${pageContext.request.contextPath}/commerce/best/main?category=all">전체</a>
							</li>
							<li class="best-category-filter_item"><a href="${pageContext.request.contextPath}/commerce/best/main?category=1">패션</a></li>
							<li class="best-category-filter_item"><a href="${pageContext.request.contextPath}/commerce/best/main?category=2">잡화</a></li>
							<li class="best-category-filter_item"><a href="${pageContext.request.contextPath}/commerce/best/main?category=3">인테리어</a></li>
							<li class="best-category-filter_item"><a href="${pageContext.request.contextPath}/commerce/best/main?category=4">가전·디지털</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row best-feed_content">
					<c:forEach var="best" items="${best}">
						<div class="best-feed_item-wrap">
							<div class="best-production-item_wrap">
								<a href="${pageContext.request.contextPath}/productions/${best.pno}" class="best-production-item_link"></a>
								<div class="best-production-item_img-wrap">
									<div class="production-item_image">
										<img class="image" src="${pageContext.request.contextPath}/${best.productthumurl}">
									</div>
								</div>
								<div class="best-production-item_content">
									<h1 class="best-production-item_header">
										<span class="best-production-item_header-brand">${best.brand}</span>
										<span class="best-production-item_header-name">${best.pname}</span>
									</h1>
									<div class="best-production-item_price">
										<span class="production-item-price">
											<span class="production-item-price_price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${best.price}"/></span>
										</span>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
</body>
</html>