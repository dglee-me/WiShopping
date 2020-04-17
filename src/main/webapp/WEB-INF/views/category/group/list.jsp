<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/category.css?after">

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위쇼핑 !</title>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/header.jsp" flush="true"/>
		<div class="container">
			<h2 class="hide">컨텐츠 영역</h2>
			<div class="container_inner">
				<div class="contents_wrap">
					<div class="content_category">
						<div class="category_nav">
							<div class="inner">
								<div class="nav">
									<ul>
										<li><a href="${pageContext.request.contextPath}/">홈</a></li>
										<c:forEach var="select" items="${categories}">
											<c:if test="${select.isselect eq 1}">
												<li><a href="${pageContext.request.contextPath}/category/group/list?category1=${select.classify}">${select.cname}</a></li>
											</c:if>
										</c:forEach>
										<c:if test="${sub_category2.cname ne null}">
											<li><a href="${pageContext.request.contextPath}/category/group/list?category1=${sub_category2.cref}&category2=${sub_category2.classify}">${sub_category2.cname}</a></li>
										</c:if>
									</ul>
								</div>
							</div>
						</div>
						<div class="content_main">
							<div class="category_lnb">
								<c:forEach var="select" items="${categories}">
									<c:if test="${select.isselect eq 1}">
										<h3 class="lnb_title">${select.cname}</h3>
									</c:if>
								</c:forEach>
								<div class="lnb_wrap">
									<div class="category_list">
										<ul class="group">
											<li>
												<c:forEach var="select" items="${categories}">
													<c:if test="${select.isselect eq 1}">
														<a href="${pageContext.request.contextPath}/category/group/list?category1=${select.classify}">
															<span class="category_title">전체</span>
														</a>
													</c:if>
												</c:forEach>
											</li>
											<c:forEach var="sub" items="${sub_categories}">
											<li>
												<a href="${pageContext.request.contextPath}/category/group/list?category1=${sub.cref}&category2=${sub.classify}">
													<span class="category_title">${sub.cname}</span>
												</a>
											</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
							<div class="category_wrap">
								<div class="box_listwrap">
									<div class="box_imagedeal">
										<c:forEach items="${list}" var="product">
											<div class="col-md-3 product-item-wrap">
												<article class="product-item">
													<a href="${pageContext.request.contextPath}/productions/${product.pno}" class="product-item_overlay"></a>
													<div class="product-item-image-wrap">
														<div class="product-item-image">
															<img class="image" src="${pageContext.request.contextPath}${product.productthumurl}">
														</div>
													</div>
													<div class="product-item-content">
														<h1 class="product-item_header">
															<span class="product-item_header__brand">${product.brand}</span>
															<span class="product-item_header__name">${product.pname}</span>
														</h1>
														<span class="product-item-price">
															<span class="product-item-price__price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/></span>
														</span>
													</div>
												</article>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
</body>
</html>