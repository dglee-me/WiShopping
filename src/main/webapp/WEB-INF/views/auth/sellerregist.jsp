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
	$(document).ready(function(){
		$(".form-control").focus(function(){
			$(this).addClass("focus-visible");
		});

		$(".form-control").focusout(function(){
			$(this).removeClass("focus-visible");
		});
		
		$(".category_checkbox").click(function(){
			var checkbox = $(this);
			var value = "";

			var length = $(".category_checkbox:checked");
			$.each(length,function(){
				value += $(this).attr("value")+";";
			});
			
			$("#sales-production-category").val(value);
		});
		
		$(".btn-submit").click(function(){
			var input = $("input");
			var flag = false;
			
			$.each(input,function(){
				if($(this).val() == ""){
					flag = false;
					$(this).focus();
				}else{
					flag = true;
				}
			});
			
			
			if($("#sales-about-product").val().length == 0){
				flag = false;
			}

			if($("#sales-production-category").val() == ""){
				flag = false;
			}
			
			if(flag == true){
				alert("판매자로 등록되었습니다. 이제부터 상품을 등록할 수 있습니다.");
				document.sales_frm.submit();
			}else{
				alert("필수항목을 모두 입력해주세요.");
			}
		});
	}
);
</script>
<meta charset="UTF-8">
<title>위쇼핑 ! - 판매자 등록</title>
</head>
<body>
	<div class="layout">
		<header id="sales-gnb">
			<span class="logo-page-sales"></span>
		</header>
		<div class="seller-layout">
			<div class="container">
				<div class="row seller-layout_header">
					<h1 class="seller-layout_header_title">입점신청</h1>					
				</div>
				<div class="row justify-center seller-layout_divider">
					<hr class="col-10 seller-layout_hr">
				</div>
			</div>
			<div class="container seller-layout_body">
				<form id="sales-form" class="sales-form" name="sales_frm" action="${pageContext.request.contextPath}/auth/seller_regist" method="post">
					<div class="slase-form_section">
						<div class="row">
							<div class="offset-1 col-10">
								<p class="sales-form_section_title">회사 정보</p>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									회사 이름
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<div class="sales-form_form-control-wrap">
									<input type="text" id="sales_company" name="company" class="form-control" placeholder="회사명">
								</div>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									사업자 번호
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<div class="sales-form_form-control-wrap">
									<input type="tel" id="sales_license1" name="license1" class="form-control" placeholder="000">
									<span class="sales-form_divider">-</span>
									<input type="tel" id="sales_license2" name="license2" class="form-control" placeholder="123">
									<span class="sales-form_divider">-</span>
									<input type="tel" id="sales_license3" name="license3" class="form-control" placeholder="456">
								</div>
							</div>
						</div>
					</div>
					<div class="row justify-center seller-layout_divider">
						<hr class="col-10 seller-layout_hr">
					</div>
					<div class="slase-form_section">
						<div class="row">
							<div class="offset-1 col-10">
								<p class="sales-form_section_title">담당자 정보</p>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									이름
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<div class="sales-form_form-control-wrap">
									<input type="text" id="sales_company" name="salesname" class="form-control" placeholder="홍길동">
								</div>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									전화번호
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<div class="sales-form_form-control-wrap">
									<input type="tel" id="sales-phone1" name="salesphone1" class="form-control" placeholder="010">
									<span class="sales-form_divider">-</span>
									<input type="tel" id="sales-phone1" name="salesphone2" class="form-control" placeholder="1234">
									<span class="sales-form_divider">-</span>
									<input type="tel" id="sales-phone1" name="salesphone3" class="form-control" placeholder="5678">
								</div>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									이메일
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<div class="sales-form_form-control-wrap">
									<input type="text" id="sales-email" name="salesemail" class="form-control" placeholder="wishopping@gamil.com" value="${login.email}">
								</div>
							</div>
						</div>
					</div>
					<div class="row justify-center seller-layout_divider">
						<hr class="col-10 seller-layout_hr">
					</div>
					<div class="slase-form_section">
						<div class="row">
							<div class="offset-1 col-10">
								<p class="sales-form_section_title">브랜드 정보</p>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									브랜드 이름
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<div class="sales-form_form-control-wrap">
									<input type="text" id="sales_company" name="brand" class="form-control" placeholder="이케아">
								</div>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									취급 카테고리
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<input type="hidden" id="sales-production-category" name="category" value="">
								<div class="form-check sales-form_form-check">
									<label class="form-check-label">
										<input type="checkbox" id="sales_category-1" name="category1" class="form-check category_checkbox" value="1">
										<span class="check-img"></span>패션
									</label>
								</div>
								<div class="form-check sales-form_form-check">
									<label class="form-check-label">
										<input type="checkbox" id="sales_category-2" name="category2" class="form-check category_checkbox" value="2">
										<span class="check-img"></span>잡화
									</label>
								</div>
								<div class="form-check sales-form_form-check">
									<label class="form-check-label">
										<input type="checkbox" id="sales_category-3" name="category3" class="form-check category_checkbox" value="3">
										<span class="check-img"></span>인테리어
									</label>
								</div>
								<div class="form-check sales-form_form-check">
									<label class="form-check-label">
										<input type="checkbox" id="sales_category-4" name="category4" class="form-check category_checkbox" value="4">
										<span class="check-img"></span>가전·디지털
									</label>
								</div>
							</div>
						</div>
						<div class="row sales-form_form-group">
							<div class="offset-1 col-2">
								<label class="form-label sales-form_form-label">
									상품 소개
									<span class="sales-form_form-group_required">*</span>
								</label>
							</div>
							<div class="col-8">
								<textarea id="sales-about-product" name="aboutproduct" class="form-control" placeholder="판매하시는 상품에 대해 간략히 설명해주세요."></textarea>
							</div>
						</div>
					</div>
					<div class="row justify-center seller-layout_divider">
						<hr class="col-10 seller-layout_hr">
					</div>
					<div class="sales-form_btn-apply">
						<button class="btn-submit" type="button">입점신청 완료</button>
					</div>
				</form>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>