<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>땡땡땡 홈 | 위쇼핑 !</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="brand-wrap container">
			<div class="brand row">
				<div class="brand_side-bar col-3">
					<article class="brand-profile">
						<div class="brand-profile_content">
							<h1 class="brand-profile_name">메종키츠네</h1>
						</div>
					</article>
					<div class="brand_side-bar_category">
						<section class="commerce-category-list">
							<ul class="commerce-category-list_others">
								<c:forEach var="list" items="${category}">
									<li class="commerce-category-list_others_item">
										<a href="javascript:void(0);">${list}</a>
									</li>
								</c:forEach>
							</ul>
						</section>
					</div>
				</div>
				<div class="brand_content col-9">
					<section class="brand_section">
						<header class="brand_section_header">
							<h1 class="brand_section_header-title">모든 상품</h1>
						</header>
						<section class="brand_production-section">
							<div class="commerce-category-header">
								<div class="commerce-category-header_breadcrumb-wrap">
									<nav class="commerce-category-breadcrumb-wrap commerce-category-header_breadcrumb">
										<ol class="commerce-category-breadcrumb">
											<li class="commerce-category-breadcrumb_entry">
												<a class="link" href="javascript:void(0);">메종키츠네</a>
											</li>
										</ol>
									</nav>
								</div>
							</div>
							<div class="brand_production-section_content row">
								<c:forEach var="product" items="${products}">
									<div class="brand_production-section_item-wrap col-mg-4">
										<article class="production-item">
											<a class="production-item_overlay" href="${pageContext.request.contextPath}/productions/view?pno=${product.pno}"></a>
											<div class="production-item-image production-item_image">
												<img class="image" src="${pageContext.request.contextPath}${product.productthumurl}">
											</div>
											<div class="production-item_content">
												<h1 class="production-item_header">
													<span class="production-item_header_brand">${product.brand} </span>
													<span class="production-item_header_name">${product.pname}</span>
												</h1>
												<span class="production-item-price">
													<span class="production-item-price_price">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/>
													</span>
												</span>
											</div>
										</article>
									</div>
								</c:forEach>
							</div>
						</section>
					</section>
				</div>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>