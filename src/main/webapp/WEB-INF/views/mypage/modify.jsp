<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	var pwJ = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	$(document).ready(function(){
		var tel = "${member.tel}";
		
		if(tel.length == 9){
			var tel_code = tel[0]+tel[1]+tel[2];
			var tel_1 = tel[3]+tel[4]+tel[5];
			var tel_2= tel[6]+tel[7]+tel[8];
		}else{
			var tel_code = tel[0]+tel[1]+tel[2];
			var tel_1 = tel[3]+tel[4]+tel[5]+tel[6];
			var tel_2= tel[7]+tel[8]+tel[9]+tel[10];
		}

		$("#tel_code").val(tel_code);
		$("#tel_1").val(tel_1);
		$("#tel_2").val(tel_2);
	});
	
	$(document).ready(function(){
		$(".edit-user-info_submit").click(function(){
			var email = $("input:text[name='email']").val();

			var password = $("input:password[name='pw']").val();
			var confirm = $("input:password[name='confirm']").val();

			if(password != "" && confirm != ""){
				if(password == confirm){
					if(pwJ.test(password)) document.getElementById("frm").submit();
					else alert("비밀번호는 6~15자 이내로 영문 숫자 특수문자를 포함해야 합니다.");
				}else{
					alert("비밀번호를 다시 확인해주세요.");
				}
			}

			if(password == "" && confirm == ""){
				document.getElementById("frm").submit();
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>회원 정보 수정 | 위쇼핑 ! </title>
</head>
<body>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="mypage-layout">
			<div class="edit-user-info">
				<div class="edit-user-info_wrap container">
					<div class="edit-user-info_header">
						<h1 class="edit-user-info_header_title">회원정보수정</h1>
						<a class="edit-user-info_header_withdrawal" href="${pageContext.request.contextPath}/mypage/withdrawal">탈퇴하기</a>
					</div>
					<form id="frm" action="modify" method="post">
						<div class="edit-user-info_form-item">
							<div class="edit-user-info_form-item_title">이메일
								<div class="edit-user-info_form-item_title_require"> * 필수항목</div>
							</div>
							<div class="form-group edit-user-info_form-item_group">
								<div class="form-group_content">
									<div class="form-group_input">
										<div class="edit-user-info_form-item_field">
											<div class="input-group email-input">
												<span class="email-input_local">
													<input type="text" name="email" class="form-control" value="${member.email}" placeholder="이메일" readonly="readonly">
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="edit-user-info_form-item">
							<div class="edit-user-info_form-item_title">비밀번호</div>
							<div class="form-group edit-user-info_form-item_group">
								<div class="form-group_content">
									<div class="form-group_input">
										<div class="edit-user-info_form-item_field">
											<div class="edit-user-info_input">
												<input type="password" value="" class="form-control" name="pw" placeholder="비밀번호 변경">
											</div>
											<div class="edit-user-info_input" style="padding-top:20px;">
												<input type="password" value="" class="form-control" name="confirm" placeholder="비밀번호 확인">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="edit-user-info_form-item">
							<div class="edit-user-info_form-item_title">이름
								<div class="edit-user-info_form-item_title_require"> * 필수항목</div>
							</div>
							<div class="form-group edit-user-info_form-item_group">
								<div class="form-group_content">
									<div class="form-group_input">
										<div class="edit-user-info_form-item_field">
											<div class="edit-user-info_input">
												<input value="${member.name}" class="form-control" name="name" readonly="readonly">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="edit-user-info_form-item">
							<div class="edit-user-info_form-item_title">전화번호
								<div class="edit-user-info_form-item_title_require"> * 필수항목</div>
							</div>
							<div class="form-group edit-user-info_form-item_group">
								<div class="form-group_content">
									<div class="form-group_input">
										<div class="edit-user-info_form-item_field">
											<div class="edit-user-info_input">
												<span class="edit-user-info_input">
													<input class="form-control" name="user[tel_code]" id="tel_code" value="">
												</span>
												<span class="email-input_separator">-</span>
												<span class="edit-user-info_input">
													<input class="form-control" name="user[tel_1]" id="tel_1" value="">
												</span>
												<span class="email-input_separator">-</span>
												<span class="edit-user-info_input">
													<input class="form-control" name="user[tel_2]" id="tel_2" value="">
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<button class="button-color-blue button-size-50 button-shape-4 edit-user-info_submit" type="button">회원 정보 수정</button>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>