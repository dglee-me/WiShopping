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
		$(".btn_submit").click(function(){
			document.frm.submit();
		});
	});
</script>
<meta charset="UTF-8">
<title>글 수정하기 | 위쇼핑 !</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"/>
	<div class="main">
		<article id="page" class="container page-col" style="width:768px;">
			<form id="frm" class="notice-content-form" name="frm" method="post" actions="modify">
				<section id="notice_content" class="page-col_content">
					<header class="notice-content-header page-col_content_header">
						<div class="notice-content-header_top">
					    	<a class="notice-content-header_top_board" href="${pageContext.request.contextPath}/customer/notice/">공지사항</a>
					    </div>
						<h1 id="notice-name" class="notice-content-header_name"><input type="text" class="notice-content-header_name-input" name="subject" value="${board.subject}"></h1>
					</header>
					<section class="notice-content-body">
						<textarea class="notice-content-body_textarea form-control" name="content" style="height:300px;">${board.content}</textarea>
					</section>
					<footer class="notice-content-footer">
						<div class="notice-content-footer_meta text-caption">
							<time class="notice-content-footer_date"><fmt:formatDate value="${board.writedate}" pattern="yyyy년 MM월 dd일 HH시 MM분"/></time>
							<span class="notice-content-footer_views">조회 <span class="notice-content-footer_view_counts">${board.readcount}</span></span>
						</div>
					</footer>
					<div class="notice-content-footer_view_button">
						<p class="notice-content-footer_view_right">
							<c:if test="${board.author eq login.name}">
								<span class="btn_default btn_delete">
									<a href="javascript:void(0);">
										<button type="button" class="btn_button btn_submit">수정하기</button>
									</a>
								</span>
								<span class="btn_default btn_default_modify">
									<a href="${pageContext.request.contextPath}/customer/notice/">
										<button type="button" class="btn_button">취소하기</button>
									</a>
								</span>
							</c:if>
						</p>
					</div>
				</section>
			</form>
		</article>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
</body>
</html>