<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/regist.css?after">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/regist.js" async></script>
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/write.js" async></script>

<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>글쓰기</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="product_selling">
		<form method="post" id="frm" action="regist" enctype="multipart/form-data">
			<input type="hidden" name="brand" value="${login.name }">
			<div class="container">
				<h2 class="hide">컨텐츠 영역</h2>
				<nav class="product_selling_category">
					<ul>
						<li class="commerce-category-list">
							<select class="category" name="category1">
								<option value="">대분류</option>
								<option value="패션">패션</option>
								<option value="잡화">잡화</option>
								<option value="인테리어">인테리어</option>
								<option value="가전·디지털">가전·디지털</option>
							</select>
						</li>
						<li class="commerce-category-list">
							<select class="category" name="category2">
								<option value="">중분류</option>
								<option value="아우터">아우터</option>
								<option value="상의">상의</option>
								<option value="하의">하의</option>
								<option value="신발">신발</option>
								<option value="가방">가방</option>
								<option value="잡화">잡화</option>
							</select>
						</li>
					</ul>
				</nav>
				<div class="container_inner">
					<div class="contents_wrap">
						<div class="content_main">
							<div class="title_box">
								<input type="text" name="pname" placeholder="제품 명을 입력하세요.">
							</div>
							<div class="info_box">
								<div class="info_thumnail">
									<div>
										<div class="info_img_wrap">
											<img src="" style="display:block;">
										</div>
										<input type="file" id="inputImg" name="productthumurl">
									</div>
								</div>
								<div class="info_description">
									<div class="info_product">
										<div class="price">
											<div class="sale_box">
												<input type="text" name="price" placeholder="가격"><strong class="sale_price">원</strong>
												<input type="text" name="inventory" placeholder="수량"><strong class="sale_price">개</strong>
											</div>
										</div>
										<div class="info_price_wrap">
											<dl class="info_price shipping">
												<dt class="ico">배송</dt>
												<dd>
													<p class="shipping_select">
														<select name="shipping">
															<option value="">배송비</option>
															<option value="2500">2500원</option>
															<option value="3000">3000원</option>
															<option value="0">무료배송</option>
														</select>
													</p>
													<p class="today">
														<span class="color_blue">상품별배송</span>
														<span class="line">ㅣ</span>
														<span class="post">택배배송<span class="line">ㅣ</span>
														<select name="date">
															<option value="1">1</option>
															<option value="2" selected>2</option>
															<option value="3">3</option>
															<option value="4">4</option>
															<option value="5">5</option>
														</select>일 이내 출고</span>
														<span class="text_etc">(주말, 공휴일 제외)</span>
													</p>
												</dd>
											</dl>
										</div>
										<div class="box_optarea">
											
										</div>
									</div>
									<div class="info_product wrap_button">
										<div class="button_box">
											<a href="javascript:void(0);" class="btn_sys red_big_xb bui" onclick="document.getElementById('frm').submit()"><span>등록하기</span></a>
										</div>
									</div>
								</div>
							</div>
							<div class="info_itemdetail">
								<div class="item_desc">
									<div class="prd_detail cut view">
										<div id="productdetails" class="tab_conts">
											<div class="deal_detailimg">
												<label>상세 이미지 업로드 란 (가로사이즈는 758px 을 넘지 않게 유의해주세요.)</label>
												<p>
													<img src="">
												</p>
												<input type="file" id="inputDetails" name="producturl">
											</div>
										</div>
									</div>
									<textarea name="product_desc"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>