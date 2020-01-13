<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		$("input:button[name='commit']").click(function(){
			var checked = $("input:checkbox[name='confirm']");
			
			if(checked[0].checked == true){
				document.getElementById("withdrawal").submit();
			}else{
				alert("탈퇴 내용을 확인 후 체크하여주세요.");
			}
		});
		
		$(".withdrawal-cancel-button").click(function(){
			history.go(-1);
		});
	});
</script>
<meta charset="UTF-8">
<title>탈퇴신청 | 위쇼핑 !</title>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../header.jsp"/>
		<div id="body">
			<div id="content">
				<div class="title">회원탈퇴 신청</div>
				<form id="withdrawal" action="withdrawal" method="post">
					<div class="field">
						<div class="title">회원 탈퇴 신청에 앞서 아래 내용을 반드시 확인해 주세요.</div>
						<div class="box">
							<div class="title">회원탈퇴 시 처리 내용</div>
							<ul class="text">
								<li>가입된 정보의 내역이 모두 삭제됩니다.(탈퇴 시 가입 내역 기록 X)</li>
								<li>구매 정보가 삭제됩니다.</li>
							</ul>
							<div class="title">회원탈퇴 시 게시물 관리</div>
							<div class="text">회원탈퇴 후 게시물 및 댓글은 삭제되지 않으며, 회원정보 삭제로 인해 작성자 본인을 확인할 수 없어 편집 및 삭제 처리가 불가능합니다. 
							<br>게시물 삭제를 원하시는 경우에는 먼저 해당 게시물을 삭제 하신 후, 탈퇴를 신청하시기 바랍니다.
	              			</div>
						</div>
						<div class="confirm">
							<label class="round-checkbox-input_label">
								<input type="checkbox" class="round-checkbox-input_input" id="confirm" name="confirm">
								<span class="round-checkbox-input_icon">
									<svg class="check" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
										<path fill="#FFF" d="M9.9 14.6l7-7.3 1.5 1.4-8.4 8.7-5-4.6 1.4-1.5z"></path>
									</svg>
								</span>
								<span class="caption"></span>
							</label>
			                <label class="view_confirm" for="confirm">위 내용을 모두 확인하였습니다. <span class="alert">  필수</span></label>
			            </div>
					</div>
					<input type="button" name="commit" value="탈퇴하기" class="button">
					<a class="button withdrawal-cancel-button" href="javascript:void(0);">취소하기</a>
				</form>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>