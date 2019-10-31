<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
									<div class="col-md-3 product-item-wrap">
										<article class="product-item">
											<a href="#" class="product-item_overlay"></a>
											<div class="product-item-image">
												<img class="image" alt src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-157164394038733839.jpg/360/360?quality=0.8">
											</div>
											<div class="product-item-content">
												<h1 class="product-item_header">
													<span class="product-item_header__brand">벨레</span>
													<span class="product-item_header__name">[오늘의딜] 멜로우 Mellow 우드 블루투스 스피커 테이블 W501T + 핸드폰거치대 증정(선착순)</span>
												</h1>
												<span class="product-item-price">
													<span class="product-item-price__price">329,000</span>
												</span>
											</div>
										</article>
									</div>
									<div class="col-md-3 product-item-wrap">
										<article class="product-item">
											<a href="#" class="product-item_overlay"></a>
											<div class="product-item-image">
												<img class="image" alt src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-156592962755439189.jpg/360/360?quality=0.8">
											</div>
											<div class="product-item-content">
												<h1 class="product-item_header">
													<span class="product-item_header__brand">순백수</span>
													<span class="product-item_header__name">순백수 히노키 스프레이(편백살균탈취제)</span>
												</h1>
												<span class="product-item-price">
													<span class="product-item-price__price">14,900</span>
												</span>
											</div>
										</article>
									</div>
									<div class="col-md-3 product-item-wrap">
										<article class="product-item">
											<a href="#" class="product-item_overlay"></a>
											<div class="product-item-image">
												<img class="image" alt src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-157231348069986458.jpg/360/360?quality=0.8">
											</div>
											<div class="product-item-content">
												<h1 class="product-item_header">
													<span class="product-item_header__brand">카카오프렌즈</span>
													<span class="product-item_header__name">[오늘의딜] 카카오미니C AI 블루투스스피커</span>
												</h1>
												<span class="product-item-price">
													<span class="product-item-price__price">49,000</span>
												</span>
											</div>
										</article>
									</div>
									<div class="col-md-3 product-item-wrap">
										<article class="product-item">
											<a href="#" class="product-item_overlay"></a>
											<div class="product-item-image">
												<img class="image" alt src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-157129780659988666.jpg/360/360?quality=0.8">
											</div>
											<div class="product-item-content">
												<h1 class="product-item_header">
													<span class="product-item_header__brand">타카타카</span>
													<span class="product-item_header__name">간편교체, 위생적인 순면화이바/극세사 베개커버 택1</span>
												</h1>
												<span class="product-item-price">
													<span class="product-item-price__price">4,100</span>
												</span>
											</div>
										</article>
									</div>
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