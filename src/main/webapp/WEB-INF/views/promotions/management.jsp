<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		//If status is use , checked checkbox
		var url = location.href;
		var status = url.slice(url.indexOf('=') + 1);

		if(status == "use"){
			$("input:checkbox[name='is_use']").prop("checked",true);
		}

		//Show only promotion in use if checkbox is selected
		$("input:checkbox[name='is_use']").click(function(){
			var checkbox = $(this);
			if($("input:checkbox[name='is_use']").prop("checked")){
				$.ajax({
					url : "/WiShopping/promotions/management?status=use",
					type : "get",
					success : function(){
						location.href="/WiShopping/promotions/management?status=use";
					}
				});
			}else{
				$.ajax({
					url : "/WiShopping/promotions/management?status=all",
					type : "get",
					success : function(){
						location.href="/WiShopping/promotions/management?status=all";
					}
				});
			}
		});
		
		//Promotion status change to 'yes'
		$(".yes").click(function(){
			var confirm_val = confirm("프로모션을 진행하시겠습니까?");
			
			if(confirm_val){
				var item = $(this);
			
				var pno = $(this).closest("li").children("em").attr("promotion-number");
				var status = 1;
			
				$.ajax({
					url : "/WiShopping/promotions/updateStatus",
					type : "post",
					data : {
						pno : pno,
						status : status		
					},
					success : function(result){
						if(result == 1){
							item.siblings(".no").removeClass("active");
							item.addClass("active");
						}else{
							alert("오류가 발생하였습니다. 다시 시도해주세요.");
							location.href="/WiShopping";
						}
					}
				});
			}
		});

		//Banner status change to 'no'
		$(".no").click(function(){
			var confirm_val = confirm("프로모션을 중지하시겠습니까?");

			if(confirm_val){
				var item = $(this);
				
				var pno = $(this).closest("li").children("em").attr("promotion-number");
				var status = 0;
				
				$.ajax({
					url : "/WiShopping/promotions/updateStatus",
					type : "post",
					data : {
						pno : pno,
						status : status		
					},
					success : function(result){
						if(result == 1){
							item.siblings(".yes").removeClass("active");
							item.addClass("active");
						}else{
							alert("오류가 발생하였습니다. 다시 시도해주세요.");
							location.href="/WiShopping";
						}
					}
				});
			}
		});
		
		//Banner delete button click event
		$(".delete_btn").click(function(){
			var isUse = $(this).parent().siblings(".promotion-list_context").children().children("button.yes");
			
			if(isUse.hasClass("active") == true){
				alert("진행 중이지 않은 프로모션만 삭제 가능합니다.");
			}else{
				var confirm_val = confirm("프로모션을 삭제하시겠습니까?\n프로모션의 모든 정보가 삭제됩니다.");
				if(confirm_val){
					var pno = $(this).parent().siblings("em").attr("promotion-number");
					
					alert("선택한 프로모션이 삭제되었습니다.");
					
					location.href = "/WiShopping/promotions/delete?pno="+pno;
				}
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>프로모션 관리 - 위쇼핑 !</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="promotion-management">
			<h2 class="promotions-management_title">프로모션 관리</h2>
			<div class="container">
				<section class="promotion-list_section">
					<div class="promotion-list_wrap">
						<div class="promotion-list_header">
							<h3>프로모션 목록</h3>
							<div class="promotion-list_sort">
								<select name="order" class="form-control">
									<option value="desc">최근 등록순</option>
								</select>
								<span class="select-input_icon">
									<svg class="icon" width="10" height="10" style="fill:currentColor" preserveAspectRatio="xMidYMid meet">
										<path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path>
									</svg>
								</span>
								<label>
									<input type="checkbox" name="is_use" class="round-checkbox-input_input" value="F">
									<span class="round-checkbox-input_icon">
										<svg class="check" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet">
											<path fill="#FFF" d="M9.9 14.6l7-7.3 1.5 1.4-8.4 8.7-5-4.6 1.4-1.5z"></path>
										</svg>
									</span>
									진행 중인 프로모션만 보기
								</label>
							</div>
							<div class="promotion_btns">
								<a href="${pageContext.request.contextPath}/promotions/regist" class="regist_btn bbtn add">
									프로모션 추가
								</a>
							</div>
						</div>
						<div class="promotion-list">
							<ul>
								<c:forEach var="promotion" items="${promotions}" varStatus="status">
								<li>
									<em class="no" promotion-number="${promotion.pno}">${status.count}</em>
									<div class="promotion-list_image">
										<a href="${pageContext.request.contextPath}/promotions/view?pno=${promotion.pno}">
											<img src="${pageContext.request.contextPath}/${promotion.thumbnailurl}">
										</a>
									</div>
									<div class="promotion-list_context">
										<div class="promotion-list_use">
											<button type="button" class="yes<c:if test="${promotion.status eq 1}"> active</c:if>">진행중</button>
											<button type="button" class="no<c:if test="${promotion.status eq 0}"> active</c:if>">종료</button> 
										</div>
										<dl>
											<dt>제목</dt>
											<dd>${promotion.subject}</dd>
											<dt>기획기간</dt>
											<dd>${promotion.startdate} ~ ${promotion.enddate}</dd>
											<dt>댓글 수</dt>
											<dd class="promotion-comment_count">${promotion.commentcount}</dd>
										</dl>
									</div>
									<div class="promotion-list_admin">
										<a href="${pageContext.request.contextPath}/promotions/modify?pno=${promotion.pno}" class="bbtn">수정하기</a>
										<a href="javascript:void(0);" class="bbtn delete_btn">삭제하기</a>
									</div>
								</li>
								</c:forEach>
							</ul>
							<c:if test="${empty promotions}">
								<div class="promotion-list_no-data">등록된 프로모션이 없습니다.</div>
							</c:if>
						</div>
					</div>
				</section>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
</body>
</html>