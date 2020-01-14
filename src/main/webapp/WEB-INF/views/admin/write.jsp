<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css?after">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js" async></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/write.js" async></script>

<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".btn_write").click(function(){
			var category = $(".category").val();
			var subject = $("#subject").val();
			var content = $("#content").val();

			if(category == "" || subject == "" || content == ""){
				alert("입력값을 확인해주세요 ! ");
			}else{
				document.getElementById("boardRegistForm").submit();
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="container">
		<div class="content_register">
			<form name="fr" id="boardRegistForm" method="post" action="write">
			<input type="hidden" value="${login.name}" name="author">
				<div class="regist_edit">
					<h2 class="title_main">글쓰기</h2>
					<ul class="subject">
						<li>
							<label class="item" for="boardCategory">게시판</label>
							<div>
								<select class="category" name="category">
									<option value="">게시판 선택</option>
									<option value="공지사항">공지사항</option>
								</select>
							</div>
						</li>
						<li>
							<label class="item" for="boardCategory">제목</label>
							<div>
								<input type="text" name="subject" placeholder="게시글 제목을 입력하세요." id="subject" class="box_input">
							</div>
						</li>
					</ul>
					<div class="content">
						<textarea id="content" name="content" cols="126" rows="23" placeholder="게시글 내용을 입력하세요."></textarea>
					</div>
				</div>
				<div class="warning_message">  저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시글은 이용약관 및 관련법률에 의해 제재를 받으실 수 있습니다.</div>
				<div class="btn_post">
					<button type="button" class="btn_write"><strong>확인</strong></button>
				</div>
			</form>
		</div>
	</div>	
</body>
</html>