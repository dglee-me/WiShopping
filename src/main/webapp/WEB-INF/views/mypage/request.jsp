<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?after">
	
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		$("#mypage-request-form_submit").click(function(){
			var email = $("input:text[name='user[email]']").val();
			var pw = $("input:password[name='user[password]']").val();
			
			if(pw == ""){// Password validation
				$(".mypage-request-form_password-error").text("비밀번호를 입력하세요.");
				$(".mypage-request-form_password-error").css("color","red");
			}else{
				$.ajax({
					url : "/WiShopping/mypage/request",
					type : "post",
					data : { 
						email : email,
						pw : pw
					},success : function(result){
						if(result == 1){ // If correct email and pw
							location.href="/WiShopping/mypage/modify";
						}else if(result == 2){ // If pw is wrong
							$(".mypage-request-form_password-error").text("비밀번호가 정확하지 않습니다.");
							$(".mypage-request-form_password-error").css("color","red");
						}else{
							location.href="/WiShopping/auth/login";
						}
					}
				});
			}
		});
		
		$("input:password[name='user[password]']").focus(function(){
			$(".mypage-request-form_password-error").text("");
		});
		
		$("input:password").keyup(function(e){
			if(e.keyCode == 13){
				var email = $("input:text[name='user[email]']").val();
				var pw = $("input:password[name='user[password]']").val();
				
				if(pw == ""){// Password validation
					$(".mypage-request-form_password-error").text("비밀번호를 입력하세요.");
					$(".mypage-request-form_password-error").css("color","red");
				}else{
					$.ajax({
						url : "/WiShopping/mypage/request",
						type : "post",
						data : { 
							email : email,
							pw : pw
						},success : function(result){
							if(result == 1){ // If correct email and pw
								location.href="/WiShopping/mypage/modify";
							}else if(result == 2){ // If pw is wrong
								$(".mypage-request-form_password-error").text("비밀번호가 정확하지 않습니다.");
								$(".mypage-request-form_password-error").css("color","red");
							}else{
								location.href="/WiShopping/auth/login";
							}
						}
					});
				}
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>마이페이지 | 위쇼핑 ! </title>
</head>
<body>
	<header id="mypage-request_logo">
		<div class="container mypage-request_container">
			<a href="${pageContext.request.contextPath}" class="mypage-request_logo_link">
				<span class="mypage-request_icon mypage-request_icon_logo"></span>
			</a>
		</div>
	</header>
	<div id="mypage-request-form">
		<div class="mypage-request-form_title">비밀번호 확인
			<p class="mypage-request-form_label">회원님의 정보를 보호하기 위해 <br> 비밀번호를 다시 한번 확인합니다.</p>
		</div>
		<form id="frm" action="request" method="post">
			<input type="text" name="user[email]" id="mypage-request-user_email" value="${member.email}" readonly="readonly">
			<input placeholder="새 비밀번호 확인" autofocus="autofocus" type="password" name="user[password]">
			<div class="mypage-request-form_password-error"></div>
			<input type="button" name="commit" value="비밀번호 변경" id="mypage-request-form_submit">
		</form>
	</div>
</body>
</html>