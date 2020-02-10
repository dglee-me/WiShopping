<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".admin-category-list_title").click(function(){
			$(".list_show").addClass("list_hide").removeClass("list_show");
			
			$(this).siblings().addClass("list_show").removeClass("list_hide");
		});
	});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="admin-feed-container">
			<h2 class="admin-feed_title">관리자 페이지</h2>
			<div class="category-feed-wrap container">
				<div class="category-feed row">
					<div class="category-feed_side-bar">
						<section class="admin-category-list">
							<h2 class="admin-category-list_title">고객센터	</h2>
							<ul class="admin-category-tree admin-category-list_categories list_show">
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="${pageContext.request.contextPath}/admin/write">공지사항 쓰기</a>
									</div>
								</li>
							</ul>
						</section>
						<section class="admin-category-list">
							<h2 class="admin-category-list_title">회원 관리</h2>
							<ul class="admin-category-tree admin-category-list_categories list_hide">
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="javascript:void(0);">회원 목록</a>
									</div>
								</li>
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="javascript:void(0);">신고 목록</a>
									</div>
								</li>
							</ul>
						</section>
						<section class="admin-category-list">
							<h2 class="admin-category-list_title">상품 관리</h2>
							<ul class="admin-category-tree admin-category-list_categories list_hide">
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="${pageContext.request.contextPath}/productions/regist">상품 등록</a>
									</div>
								</li>
							</ul>
						</section>
						<section class="admin-category-list">
							<h2 class="admin-category-list_title">기획전</h2>
							<ul class="admin-category-tree admin-category-list_categories list_hide">
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="${pageContext.request.contextPath}/promotions/regist">프로모션 등록</a>
									</div>
								</li>
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="${pageContext.request.contextPath}/promotions/management">프로모션 관리</a>
									</div>
								</li>
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="${pageContext.request.contextPath}/admin/banner/regist">배너 등록</a>
									</div>
								</li>
								<li class="admin-category-tree_entry">
									<div class="admin-category-tree_entry_header">
										<a class="admin-category-tree_entry_title" href="${pageContext.request.contextPath}/admin/banner/management?status=all">배너 관리</a>
									</div>
								</li>
							</ul>
						</section>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>