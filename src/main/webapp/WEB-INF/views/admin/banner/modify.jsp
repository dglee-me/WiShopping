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
		//If you select option, reflect that width and height
		$(".form-control").change(function(){
			var option = $(this).val();
			
			if(option == 0){
				$("input[name='banner_size_width']").val("1084");
				$("input[name='banner_size_height']").val("430");
			}else if(option == 1){
				$("input[name='banner_size_width']").val("190");
				$("input[name='banner_size_height']").val("79");
			}
		});
		
		//If image div click, files regist window open
		$(".img_exist").click(function(e){
			e.preventDefault();
			
			$(".banner_main_input").click();
		});
		
		$(".banner_main_input").change(function(){
			if(this.files && this.files[0]){
				$(".img_exist").css("display","none");
				$(".img_modify").css("display","block");
				
				var reader = new FileReader;
				reader.onload = function(data){
					$(".img_modify").css("background-image","url('"+data.target.result+"')");
				}
				reader.readAsDataURL(this.files[0]);
			}
		});
		
		$(".btn_save").click(function(){
			var formData = new FormData($("#frm")[0]);

			formData.append("bno",$(".admin-banner-area").attr("banner-number"));
			formData.append("area",$(".form-control option:checked").text());
			formData.append("bannerlink",$("input:text[name='banner[link]']").val());
			formData.append("file",$(".banner_main_input")[0].files[0]);
			formData.append("banneralt",$("input:text[name='banner[alt]']").val());
			
			if(formData.get("file") == "undefined"){
				formData.delete("file");
			}

			$.ajax({
				url : "/WiShopping/admin/banner/modify",
				type : "post",
				contentType: false,
				processData: false,
				data : formData,
				success : function(result){
					if(result == 1){
						location.href="/WiShopping/admin/banner/management?status=all";
					}else{
						location.href="/WiShopping/error";
					}
				}
			});
		});
		
		$(".btn_cancel").click(function(){
			var confirm_val = confirm("수정 내용을 취소하시겠습니까?");
			
			if(confirm_val){
				history.go(-1);
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>위쇼핑 ! 관리자 - 배너 수정</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="banner-regist">
			<h2 class="banner-regist_title">배너 수정</h2>
			<div class="container">
				<div class="row banner-register">
					<form id="frm" name="frm" enctype="multipart/form-data" action="modify" method="post">
						<section class="admin-banner-area" banner-number = "${banner.bno}">
							<div class="table-block">
								<table>
									<tbody>
										<tr>
											<th>영역명</th>
											<td class="area">
												<select class="form-control" name="banner[area]">
													<option value="0" <c:if test="${banner.area eq '메인상단'}">selected</c:if>>메인상단</option>
													<option value="1" <c:if test="${banner.area eq '헤더'}">selected</c:if>>헤더</option>
												</select>
											</td>
											<th>배너 크기</th>
											<td class="size">
												<c:if test="${banner.area eq '메인상단'}">
													<input type="number" name="banner_size_width" value="1084" readonly="readonly">
													<span>x</span> 
													<input type="number" name="banner_size_height" value="430" readonly="readonly">
													<p class="msg">배너 이미지의 크기입니다.</p>
												</c:if>
												<c:if test="${banner.area eq '헤더'}">
													<input type="number" name="banner_size_width" value="190" readonly="readonly">
													<span>x</span> 
													<input type="number" name="banner_size_height" value="79" readonly="readonly">
													<p class="msg">배너 이미지의 크기입니다.</p>
												</c:if>
											</td>
										</tr>
										<tr>
											<th>사용여부</th>
											<td class="isuse" colspan="3">
												<label>
													<input type="radio" name="bannerstatus" value="1"<c:if test="${banner.bannerstatus eq 1 }"> checked=""</c:if>><span>사용함</span>
												</label>
												<label>
													<input type="radio" name="bannerstatus" value="0"<c:if test="${banner.bannerstatus eq 0 }"> checked=""</c:if>><span>사용안함</span>
												</label>
											</td>
										</tr>
										<tr>
											<th>이미지 등록</th>
											<td class="image" colspan="3">
												<div class="img_exist" style="display:block; background-image:url('${pageContext.request.contextPath}${banner.bannerurl}')"></div>
												<div class="img_modify" style="display:none;"></div>
												<input type="file" name="banner[url]" class="banner_main_input">
											</td>
										</tr>
										<tr>
											<th>배너 이미지 설명</th>
											<td class="alt" colspan="3">
												<input type="text" name="banner[alt]" value="${banner.banneralt}" placeholder="배너에 대한 설명을 간단하게 적어주세요. ex)패션위크">
											</td>
										</tr>
										<tr>
											<th>배너 링크 URL</th>
											<td class="link" colspan="3">
												<input type="text" name="banner[link]" value="${banner.bannerlink}" placeholder="http://가 포함된 URL을 입력해주세요.">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="btns">
								<button type="button" class="btn_save">저장</button>
								<button type="button" class="btn_cancel">취소</button>
							</div>
						</section>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
</body>
</html>