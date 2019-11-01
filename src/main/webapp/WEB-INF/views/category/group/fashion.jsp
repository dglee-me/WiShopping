<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/category.css?after">

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
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
									<li><a href="${pageContext.request.contextPath}/category/group/1">패션</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="content_main">
						<div class="category_lnb">
							<h3 class="lnb_title">패션</h3>
							<div class="lnb_wrap">
								<div class="category_list">
									<ul class="group">
										<li>
											<a href="#">
												<span class="category_title">아우터</span>
											</a>
										</li>
										<li>
											<a href="#">
												<span class="category_title">상의</span>
											</a>
										</li>
										<li>
											<a href="#">
												<span class="category_title">하의</span>
											</a>
										</li>
										<li>
											<a href="#">
												<span class="category_title">신발</span>
											</a>
										</li>
										<li>
											<a href="#">
												<span class="category_title">가방</span>
											</a>
										</li>
										<li>
											<a href="#">
												<span class="category_title">잡화</span>
											</a>
										</li>
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
												<a href="/production/view?pno=${product.pno}" class="product-item_overlay"></a>
												<div class="product-item-image">
													<img class="image" src="${pageContext.request.contextPath}/${product.product_thumurl}">
												</div>
												<div class="product-item-content">
													<h1 class="product-item_header">
														<span class="product-item_header__brand">${product.brand }</span>
														<span class="product-item_header__name">${product.pname }</span>
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
</body>
</html>