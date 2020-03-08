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
<c:forEach var="product" items="${products}">
	<c:set var="brand" value="${product.brand}"/>
</c:forEach>
<meta charset="UTF-8">
<title>${brand} 홈 | 위쇼핑 !</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="brand-wrap container">
			<div class="brand row">
				<div class="brand_side-bar col-3">
					<article class="brand-profile">
						<div class="brand-profile_content">
							<h1 class="brand-profile_name">${brand}</h1>
						</div>
					</article>
					<div class="brand_side-bar_category">
						<section class="commerce-category-list">
							<c:if test="${empty sub_category}">
								<ul class="commerce-category-list_others">
									<c:forEach var="list" items="${category}">
										<li class="commerce-category-list_others_item">
											<a href="${pageContext.request.contextPath}/brands/home?query=${brand}&category1=${list.category1}">${list.cname}</a>
										</li>
									</c:forEach>
								</ul>
							</c:if>
							<c:if test="${!empty sub_category}">
								<c:forEach var="sub_category" items="${sub_category}">
									<c:set var="category_name" value="${sub_category.category}"/>
									<c:set var="category1" value="${sub_category.category1}"/>
								</c:forEach>
								<h2 class="commerce-category-list_title">
									<a href="${pageContext.request.contextPath}/brands/home?query=${brand}&category1=${category1}">${category_name}</a>
								</h2>
								<ul class="commerce-category-tree commerce-category-list_categories">
									<c:forEach var="sub" items="${sub_category}">
										<li class="commerce-category-tree__entry">
											<div class="commerce-category-tree_entry_header">
												<a class="commerce-category-tree_entry_title" href="${pageContext.request.contextPath}/brands/home?query=${brand}&category1=${sub.category1}&category2=${sub.category2}">${sub.cname}</a>
											</div>
										</li>
									</c:forEach>
								</ul>
								<ul class="commerce-category-list_others">
									<c:forEach var="other_category" items="${category}">
										<c:if test="${category_name ne other_category.cname}">
											<li class="commerce-category-list_others_item">
												<a href="${pageContext.request.contextPath}/brands/home?query=${brand}&category1=${other_category.category1}">${other_category.cname}</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
						</section>
					</div>
				</div>
				<div class="brand_content col-9">
					<c:if test="${empty category_name}">
						<section class="brand_section">
							<header class="brand_section_header">
								<h1 class="brand_section_header-title">브랜드 소개</h1>
							</header>	
							<div class="brand_introduce_section">
								${brandInfo}
							</div>
						</section>
					</c:if>
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
												<a class="link" href="${pageContext.request.contextPath}/brands/home?query=${brand}">${brand}</a>
											</li>
											<c:if test="${!empty category_name}">
												<li class="commerce-category-breadcrumb_entry">
													<a class="link sub_category" href="${pageContext.request.contextPath}/brands/home?query=${brand}&category1=${category1}">${category_name}</a>
												</li>
											</c:if>
											<c:if test="${selected_sub_category.cname ne null}">
												<li class="commerce-category-breadcrumb_entry">
													<a class="link sub_category2" href="${pageContext.request.contextPath}/brands/home?query=${brand}&category1=${category1}&category2=${selected_sub_category.category2}">${selected_sub_category.cname}</a>
												</li>
											</c:if>
										</ol>
									</nav>
								</div>
							</div>
							<div class="brand_production-section_filter-container">
								<div class="brand_production-section_filter-wrap">
									<div class="filter">
										<div class="filter-bar category-filter-bar">
											<div class="category-filter-bar_secondary">
												<p class="category-filter-bar_secondary_summary">전체 ${count}</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="brand_production-section_content row">
								<c:forEach var="product" items="${products}">
									<div class="brand_production-section_item-wrap col-mg-4">
										<article class="production-item">
											<a class="production-item_overlay" href="${pageContext.request.contextPath}/productions/${product.pno}"></a>
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