<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>고객센터</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"/>
	<div class="main">
		<article id="page" class="container page-col" style="width:768px;">
			<section id="notice_content" class="page-col_content">
				<header class="notice-content-header page-col_content_header">
					<div class="notice-content-header_top">
				    	<a class="notice-content-header_top_board" href="${pageContext.request.contextPath}/customer/notice/">공지사항</a>
				    </div>
					<h1 id="notice-name" class="notice-content-header_name">${board.subject}</h1>
				</header>
				<section class="notice-content-body">
					${board.content}
				</section>
				<footer class="notice-content-footer">
					<div class="notice-content-footer_meta text-caption">
						<time class="notice-content-footer_date"><fmt:formatDate value="${board.writedate}" pattern="yyyy년 MM월 dd일 HH시 mm분"/></time>
						<span class="notice-content-footer_views">조회 <span class="notice-content-footer_view_counts">${board.readcount}</span></span>
					</div>
				</footer>
				<div class="notice-content-footer_view_button">
					<p class="notice-content-footer_view_left">
						<c:if test="${board.prevbno ne 0 }">
						<span class="btn_default btn_prev">
							<a href="${pageContext.request.contextPath}/customer/notice/${board.prevbno}">
								<button type="button" class="btn_button">이전글</button>
							</a>
						</span>
						</c:if>
						<c:if test="${board.nextbno ne 0 }">
						<span class="btn_default btn_next">
							<a href="${pageContext.request.contextPath}/customer/notice/${board.nextbno}">
								<button type="button" class="btn_button">다음글</button>
							</a>
						</span>
						</c:if>
					</p>
					<p class="notice-content-footer_view_right">
						<c:if test="${board.author eq login.name}">
							<span class="btn_default btn_delete">
								<a href="${pageContext.request.contextPath}/customer/notice/delete/${board.bno}">
									<button type="button" class="btn_button">삭제</button>
								</a>
							</span>
							<span class="btn_default btn_default_modify">
								<a href="${pageContext.request.contextPath}/customer/notice/modify/${board.bno}">
									<button type="button" class="btn_button">수정</button>
								</a>
							</span>
						</c:if>
						<span class="btn_default btn_list">
							<a href="${pageContext.request.contextPath}/customer/notice/">
								<button type="button" class="btn_button">목록보기</button>
							</a>
						</span>
					</p>
				</div>
			</section>
		</article>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
</body>
</html>