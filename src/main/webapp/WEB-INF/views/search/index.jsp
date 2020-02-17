<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
/*
	$(document).ready(function(){
		var url = decodeURI(location.href);
		var query = url.slice(url.indexOf('=') + 1);
		
		$(".production-feed_header-title").text("'"+query+"'에 대한 스토어 검색 결과");
	});
	*/
</script>

<meta charset="UTF-8">
<title>위쇼핑 ! - 검색결과</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="production-feed container">
			<div class="production-feed_header">
				<h1 class="production-feed_header-title">'${parameter}'에 대한 통합검색 결과
					<span class="production-feed_header-title_number">${count}개</span>
				</h1>
				<c:if test="${!empty brand}">
				<p class="production-feed_header-brand-suggestion">
					<a class="brand-name" href="${pageContext.request.contextPath}/brands/home?query=${brand}">${brand}</a>
					브랜드가 궁금하세요?
				</p>
				</c:if>
			</div>
			<div class="sticky-container production-feed_filter-container" style="position:sticky; top:0px;">
				<div class="sticky-child production-feed_filter-wrap" style="position:relative;">
					<div class="filter production-feed-filter">
						<div class="filter-bar">
							<div class="filter-bar_control-list">
								<ul class="filter-bar_control-list_left">
									<li class="filter-bar_control-list_item">
										<div class="drop-down panel-drop-down filter-bar-control">
											<button class="button button-color-gray button-size-50 filter-bar-control_button">카테고리
												<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
													<path d="M6.069 6.72l4.123-3.783 1.216 1.326-5.32 4.881L.603 4.273l1.196-1.346z"></path>
												</svg>
											</button>
										</div>
									</li>
									<li class="filter-bar_control-list_item">
										<div class="drop-down panel-drop-down filter-bar-control">
											<button class="button button-color-gray button-size-50 filter-bar-control_button">배송
												<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
													<path d="M6.069 6.72l4.123-3.783 1.216 1.326-5.32 4.881L.603 4.273l1.196-1.346z"></path>
												</svg>
											</button>
										</div>
									</li>
									<li class="filter-bar_control-list_item">
										<div class="drop-down panel-drop-down filter-bar-control">
											<button class="button button-color-gray button-size-50 filter-bar-control_button">가격
												<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet">
													<path d="M6.069 6.72l4.123-3.783 1.216 1.326-5.32 4.881L.603 4.273l1.196-1.346z"></path>
												</svg>
											</button>
										</div>
									</li>
								</ul>
								<ul class="filter-bar_control-list_right">
									<li class="filter-bar_control-list_item">
										<div class="drop-down panel-drop-down filter-bar-control">
											<button class="filter-bar-order-button" type="button">인기순
												<svg class="caret" width="8" height="8" viewBox="0 0 8 8" preserveAspectRatio="xMidYMid meet">
													<path fill="#BDBDBD" d="M0 2l4 4 4-4z"></path>
												</svg>
											</button>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<c:if test="${!empty items}">
				<div class="production-feed_content row">
					<c:forEach var="product" items="${items}">
						<div class="production-feed_item-wrap">
							<article class="production-item">
								<a href="${pageContext.request.contextPath}/productions/${product.pno}" class="production-item_overlay"></a>
								<div class="production-item-image">
									<img class="image" src="${pageContext.request.contextPath}${product.productthumurl}">
								</div>
								<div class="production-item-content">
									<h1 class="production-item_header">
										<span class="production-item_header__brand">${product.brand}</span>
										<span class="production-item_header__name">${product.pname}</span>
									</h1>
									<span class="production-item-price">
										<span class="production-item-price__price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/></span>
									</span>
								</div>
							</article>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${empty items}">
				<div class="production-feed_empty">
					<p>앗! 찾으시는 결과가 없어요!</p>
				</div>
			</c:if>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>