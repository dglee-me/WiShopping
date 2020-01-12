<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?after">
	
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".sign-in-form_form_submit").click(function(){
			var email = $("input:text[name='user[email]']").val();

			document.getElementById("new_password").submit();
		});
	});
</script>
<meta charset="UTF-8">
<title>비밀번호 재설정 | 위쇼핑 ! </title>
</head>
<body>
	<div class="sign-in-form-wrap">
		<div class="sign-in-form">
			<h1 class="sign-in-form_header">
				<a href="${pageContext.request.contextPath}" class="sign-in-form_header_link">
					<span class="icon-page_link"></span>
				</a>
			</h1>
			<form id="new_password" action="new" method="post" class="sigin-in-form_form">
				<input type="text" name="user[email]" id="user[email]" autofocus="autofocus" class="sign-in-form_form_input form-control" placeholder="이메일">
				<input type="button" name="commit" value="이메일로 비밀번호 찾기" class="sign-in-form_form_submit">
			</form>
		</div>
	</div>
</body>
</html>