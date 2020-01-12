<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?after">
	
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	var pwJ = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	$(document).ready(function(){
		var url = location.href;
		var token = url.slice(url.indexOf('=') + 1);
		
		$("input:hidden[name='token']").val(token);
	});
	
	$(document).ready(function(){
		$("#new_password-submit").click(function(){
			var pwJ = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
			
			var password = $("input:password[name='user[password]']").val();
			var confirm = $("input:password[name='user[password_confirm]']").val();

			if(password != "" && confirm != ""){
				if(password == confirm){
					if(pwJ.test(password)) document.getElementById("new_password").submit();
					else alert("비밀번호는 6~15자 이내로 영문 숫자 특수문자를 포함해야 합니다.");
				}else{
					alert("비밀번호가 일치하지않습니다.\n확인 후 다시 시도해주세요.");
				}
			}
		});
				
		//Validate Password
		$("input:password[name='user[password]']").blur(function(){
			var password = $(this).val();
			
			if(password == ""){
				$(".password-form_password-error").text("비밀번호를 입력하여주세요.");
				$(".password-form_password-error").css("color","red");
			}else{
				$(".password-form_password-error").text("");
			}
		});
				
		//Validate Password-confirm
		$("input:password[name='user[password_confirm]']").blur(function(){
			var confirm = $(this).val();
			var password = $("input:password[name='user[password]']").val();
			
			if(confirm == ""){
				$(".password-form_password_confirm-error").text("비밀번호를 입력하여주세요.");
				$(".password-form_password_confirm-error").css("color","red");
			}else if(confirm != password){
				$(".password-form_password_confirm-error").text("비밀번호가 일치하지 않습니다. :(");
				$(".password-form_password_confirm-error").css("color","red");
			}else{
				$(".password-form_password_confirm-error").text("");
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>비밀번호 재설정 | 위쇼핑 ! </title>
</head>
<body>
	<header id="password-form_logo">
		<div class="container password-form_logo_container">
			<a href="${pageContext.request.contextPath}" class="password-form_logo_link">
				<span class="icon icon_logo"></span>
			</a>
		</div>
	</header>
	<div id="password-form">
		<div class="password-form_title">비밀번호 변경</div>
		<form id="new_password" action="modify" method="post">
			<input type="hidden" name="token" value="">
			<input autofocus="autofocus" placeholder="새 비밀번호" type="password" name="user[password]" id="user_password">
			<div class="password-form_password-error"></div>
			<input placeholder="새 비밀번호 확인" type="password" name="user[password_confirm]" id="user_password_confirmation">
			<div class="password-form_password_confirm-error"></div>
			<input type="button" name="commit" value="비밀번호 변경" id="new_password-submit">
		</form>
	</div>
</body>
</html>