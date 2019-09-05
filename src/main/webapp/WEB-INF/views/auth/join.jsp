<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css?after">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/join.js" async></script>
<title>회원가입</title>
</head>
<body>
	<form action="join" method="POST" id="frm">
	<input type="hidden" name="auth" value="IMSI">
	<div class="member-wrapper member-wrapper-flex">
		<header class="member-header">
			<h1 class="member-logo">
				<a href="${pageContext.request.contextPath }/" class="member-logo_link">L O G O</a>
			</h1>
		</header>	
		<div class="member-main">
			<div class="member-join">
				<div class="join-content">
					<div class="member_field-wrap">
						<div class="member_input-field">
							<label class="member_input-wrap _joinEmailInputStatus" for="join-email-input">
								<span class="member_input-group member_input-group-icon-label">
									<i class="join_sprite join_sprite_email"></i>
								</span>
								<span class="member_input-group">
									<input type="email" id="join_email" class="member_input _JoinEmailInput" name="email" maxlength="80" placeholder="이메일을 입력하세요.">
								</span>
							</label> 
						</div>
						<div class="member_expand-field _joinEmailExpand">
							<div class="member_message-area-Email member_message-area-error"></div>
						</div>
					</div>
					<div class="member_field-wrap">
						<div class="member_input-field member_input_password">
							<label class="member_input-wrap" for="join-password-input">
								<span class="member_input-group member_input-group-icon-label">
									<i class="join_sprite join_sprite_password"></i>
								</span>
								<span class="member_input-group">
									<input type="password" id="join_pw" class="member_input _JoinPasswordInput" name="pw" maxlength="15" placeholder="비밀번호(영문 숫자 특수문자 포함 6~15자 이내)">
								</span>
							</label> 
						</div>
						<div class="member_expand-field _joinPasswordExpand">
							<div class="member_message-area-Pw member_message-area-error"></div>
						</div>
					</div>
					<div class="member_field-wrap">
						<div class="member_input-field">
							<label class="member_input-wrap _joinPasswordAgain" for="join-password-again-input">
								<span class="member_input-group member_input-group-icon-label">
									<i class="join_sprite join_sprite_password"></i>
								</span>
								<span class="member_input-group">
									<input type="password" id="join_pw_again" class="member_input _JoinPasswordInput" name="pwagain" maxlength="15" placeholder="비밀번호 확인">
								</span>
							</label> 
						</div>
						<div class="member_expand-field _joinPasswordExpand">
							<div class="member_message-area-Pw-again member_message-area-error"></div>
						</div>
					</div>
					<div class="member_field-wrap">
						<div class="member_input-field">
							<label class="member_input-wrap _joinNameInput" for="join-name-input">
								<span class="member_input-group member_input-group-icon-label">
									<i class="join_sprite join_sprite_name"></i>
								</span>
								<span class="member_input-group">
									<input type="text" id="join_name" class="member_input _JoinNameInput" name="name" maxlength="40" placeholder="이름">
								</span>
							</label> 
						</div>
						<div class="member_expand-field _joinNameExpand">
							<div class="member_message-area-name member_message-area-error"></div>
						</div>
					</div>
					<div class="member_field-wrap">
						<div class="member_input-field">
							<label class="member_input-wrap _joinPhoneInput" for="join-phone-input">
								<span class="member_input-group member_input-group-icon-label">
									<i class="join_sprite join_sprite_phone"></i>
								</span>
								<span class="member_input-group">
									<input type="hidden" value="82" class="phone-country-select _phoneCoutnryCode">
									<input type="tel" id="join_tel" class="member_input _JoinPhoneInput _phoneNumber" name="tel" placeholder="전화번호">
								</span>
							</label> 
						</div>
						<div class="member_expand-field _joinPhoneExpand">
							<div class="member_message-area-tel member_message-area-error"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="join_footer _joinTriggerRoot">
				<button type="submit" class="join_button join_button-skyblue-large-block _joinTrigger">동의하고 가입하기</button>
			</div>
			<footer class="member-footer">©WiShopping. All rights reserved.</footer>
		</div>
	</div>
	</form>
</body>
</html>