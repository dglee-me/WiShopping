<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".btn_save").click(function(){
			var subject = $("input:text[name='subject']").val();
			var content = $(".notice-content-body_textarea").val();
			
			if(subject.length < 5 || content == ""){
				alert("입력사항을 모두 입력하여주세요.");
			}else{
				document.frm.submit();
			}
			
		});
		
		$(".btn_cancel").click(function(){
			var confirm_val = confirm("작성 내용을 취소하시겠습니까?");
			
			if(confirm_val){
				history.go(-1);
			}
		});
		
		$(".notice-info").blur(function(){
			var content = $(this).val().length;
			
			if($(this).hasClass("notice-content-header_name-input")){
				if(content < 5){
					$("input:text[name='subject']").css("border-color","F77");
					$(".notice-content-header .error").css("display", "block");
				}else{
					$("input:text[name='subject']").css("border-color","ededed");
					$(".notice-content-header .error").css("display", "none");
				}
			}else if($(this).hasClass("notice-content-body_textarea")){
				if(content < 1){
					$(".notice-content-body_textarea").css("border-color","F77");
					$(".notice-content-body .error").css("display", "block");
				}else{
					$(".notice-content-body_textarea").css("border-color","ededed");
					$(".notice-content-body .error").css("display", "none");
				}
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>글 작성하기 | 위쇼핑 !</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"/>
	<div class="main">
		<article id="page" class="container page-col" style="width:768px;">
			<form id="frm" class="notice-content-form" name="frm" method="post" actions="write">
				<section id="notice_content" class="page-col_content">
					<header class="notice-content-header page-col_content_header">
						<div class="notice-content-header_top">
					    	<a class="notice-content-header_top_board" href="${pageContext.request.contextPath}/customer/notice/">공지사항</a>
					    </div>
						<h1 id="notice-name" class="notice-content-header_name"><input type="text" class="notice-content-header_name-input notice-info" name="subject" value="" placeholder="제목을 입력하세요."></h1>
						<p class="error">제목을 5글자 이상 입력하여주세요.</p>
					</header>
					<section class="notice-content-body">
						<textarea class="notice-content-body_textarea form-control notice-info" name="content" placeholder="내용을 입력하세요." style="height:300px;"></textarea>
						<p class="error">내용을 입력하여주세요.</p>
					</section>
					<div class="notice-content-footer_view_button">
						<div class="btns">
							<button type="button" class="btn_save">저장</button>
							<button type="button" class="btn_cancel">취소</button>
						</div>
					</div>
				</section>
			</form>
		</article>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
</body>
</html>