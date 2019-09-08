<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?after">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/login.js" async></script>
</head>
<body>
	<div class="member-wrapper member-wrapper-flex">
		<header class="member-header">
			<h1 class="member-logo">
				<a href="${pageContext.request.contextPath }/" class="member-logo_link">위쇼핑</a>
			</h1>
		</header>
		<div class="member-main">
			<div class="member-login">
				<form name="fr" class="_loginForm" method="post" action="${pageContext.request.contextPath }/auth/login" onsubmit="return check()">
					<div class="login_content login_content-input">
						<div class="member_field-wrap">
							<div class="member_input-field">
								<label class="member_input-wrap _loginEmailInputStatus" for="login-email-input">
									<span class="member_input-group member_input-group-icon-label">
										<i class="member_sprite member_sprite-email"></i>
									</span>
									<span class="member_input-group">
										<input type="email" class="member_input _loginEmailInput" maxlength="80" name="email" placeholder="이메일">
									</span>
								</label>
							</div>
							<div class="member_expand-field _loginEmailExpand">
								<div class="member_message-area-Email member_message-area-error"></div>
							</div>
						</div>
						<div class="member_field-wrap">
							<div class="member_input-field">
								<label class="member_input-wrap _loginPwInputStatus" for="login-pw-input">
									<span class="member_input-group member_input-group-icon-label">
										<i class="member_sprite member_sprite-pw"></i>
									</span>
									<span class="member_input-group">
										<input type="password" class="member_input _loginPwInput" maxlength="80" name="pw" placeholder="비밀번호(6~15자 이하)">
									</span>
								</label>
							</div>
							<div class="member_expand-field _loginpwExpand">
								<div class="member_message-area-Pw member_message-area-error">
									<c:if test="${msg == false }">
										이메일 또는 비밀번호를 다시 확인하세요. 
										위쇼핑에 등록되지 않은 이메일이거나, 이메일 또는 비밀번호를 잘못 입력하셨습니다.
									</c:if>
									<c:if test="${msg == true }">
										이메일 인증 완료 후 로그인을 시도해주세요!
									</c:if>
								</div>
							</div>
						</div>
					</div>
					<div class="login_content login_content-util">
						<label class="member_checkbox login_util_keep-state" for="login-keep-state">
							<input type="checkbox" class="member_checkbox_input member_sprite-checkbox _loginRememberInput" id="login-keep-state" name="useCookie">
							<span class="member_checkbox_label">자동로그인</span>
						</label>
						<a href="/auth/accountFind" class="login_link login_link-find-email-pw _loginFindEmailPwLink">
							이메일/비밀번호 찾기
							<i class="member_sprite member_sprite-right-arrow"></i>
						</a>
					</div>
					<div class="login_content login_content-trigger">
						<button type="submit" class="login_button login_button-submit _loginSubmitButton">로그인</button>
						<hr class="login_separtor">
						<a href="${pageContext.request.contextPath }/auth/join" class="login_button login_button-join _loginJoinLink">회원가입</a>
					</div>
				</form>
			</div>
		</div>
		<footer class="member-footer">©WiShopping. All rights reserved.</footer>
	</div>
</body>
</html>