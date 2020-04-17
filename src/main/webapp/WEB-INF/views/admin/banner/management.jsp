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
		
		//Show only banner in use if checkbox is selected
		$("input:checkbox[name='is_use']").click(function(){
			var checkbox = $(this);
			if($("input:checkbox[name='is_use']").prop("checked")){
				$.ajax({
					url : "/WiShopping/admin/banner/management?status=use",
					type : "get",
					success : function(){
						location.href="/WiShopping/admin/banner/management?status=use";
					}
				});
			}else{
				$.ajax({
					url : "/WiShopping/admin/banner/management?status=all",
					type : "get",
					success : function(){
						location.href="/WiShopping/admin/banner/management?status=all";
					}
				});
			}
		});
		
		//Banner status change to 'yes'
		$(".yes").click(function(){
			var confirm_val = confirm("배너를 사용하시겠습니까?");
			
			if(confirm_val){
				var item = $(this);
			
				var bno = $(this).closest("li").children("em").attr("banner-number");
				var bannerstatus = 1;
			
				$.ajax({
					url : "/WiShopping/admin/banner/updateStatus",
					type : "post",
					data : {
						bno : bno,
						bannerstatus : bannerstatus		
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
			var confirm_val = confirm("배너 사용을 중지하시겠습니까?");

			if(confirm_val){
				var item = $(this);
				
				var bno = $(this).closest("li").children("em").attr("banner-number");
				var bannerstatus = 0;
				
				$.ajax({
					url : "/WiShopping/admin/banner/updateStatus",
					type : "post",
					data : {
						bno : bno,
						bannerstatus : bannerstatus		
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
			var isUse = $(this).parent().siblings(".banner-list_context").children().children("button.yes");
			
			if(isUse.hasClass("active") == true){
				alert("사용이 중지된 배너만 삭제 가능합니다.");
			}else{
				var confirm_val = confirm("배너를 삭제하시겠습니까?\n배너의 모든 정보가 삭제됩니다.");
				if(confirm_val){
					var bno = $(this).parent().siblings("em").attr("banner-number");
					
					alert("선택한 배너가 삭제되었습니다.");
					
					location.href = "/WiShopping/admin/banner/delete?bno="+bno;
				}
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>위쇼핑 ! - 배너 관리</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="banner-management">
			<h2 class="banner-management_title">배너 관리</h2>
			<div class="container">
				<section class="banner-list_section">
					<div class="banner-list_wrap">
						<div class="banner-list_header">
							<h3>배너 목록</h3>
							<div class="banner-list_sort">
								<select name="order" class="form-control">
									<option value="desc">최근 등록순</option>
									<option value="">최근 등록순</option>
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
									사용 중인 배너만 보기
								</label>
							</div>
							<div class="banner_btns">
								<a href="${pageContext.request.contextPath}/admin/banner/regist" class="regist_btn bbtn add">
									배너 추가
								</a>
							</div>
						</div>
						<div class="banner-list">
							<ul>
								<c:forEach var="banner" items="${banners}" varStatus="status">
								<li>
									<em class="no" banner-number="${banner.bno}">${status.count}</em>
									<div class="banner-list_image">
										<a href="${banner.bannerlink}">
											<img src="${pageContext.request.contextPath}/${banner.bannerurl}" alt="${banner.banneralt}">
										</a>
									</div>
									<div class="banner-list_context">
										<div class="banner-list_use">
											<button type="button" class="yes<c:if test="${banner.bannerstatus eq 1}"> active</c:if>">사용</button>
											<button type="button" class="no<c:if test="${banner.bannerstatus eq 0}"> active</c:if>">종료</button> 
										</div>
										<dl>
											<dt>배너영역</dt>
											<dd>${banner.area}<span> [1/1]</span></dd>
											<dt>배너크기</dt>
											<dd>
												<c:if test="${banner.area eq '메인상단'}">1084 x 460</c:if>
												<c:if test="${banner.area eq '헤더'}">190 x 79</c:if>
											</dd>
											<dt>링크주소</dt>
											<dd><a href="${banner.bannerlink}">${banner.bannerlink}</a></dd>
											<dt>배너설명</dt>
											<dd>${banner.banneralt}</dd>
										</dl>
									</div>
									<div class="banner-list_admin">
										<a href="${pageContext.request.contextPath}/admin/banner/modify?bno=${banner.bno}" class="bbtn">수정하기</a>
										<a href="javascript:void(0);" class="bbtn delete_btn">삭제하기</a>
									</div>
								</li>
								</c:forEach>
							</ul>
							<c:if test="${empty banners}">
								<div class="banner-list_no-data">등록된 배너가 없습니다.</div>
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