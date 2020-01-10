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
	var detail_image_count = 0;

	$(document).ready(function(){
		//count detail images
		$("#promotions-register_image-count").text($(".promotions-register-addimage-sortable").length);		
		
		//Thumbnail change when image div click
		$(".thumb_info_box").click(function(e){
			e.preventDefault();
			
			$(".promotions-register-thumb").click();
		});
		$(".promotions-register-thumb").change(function(){
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
		
		//When detail images modify btn clicked
		$(".txt_image_modify").click(function(){
			var var_confirm = confirm("기존 이미지 삭제 후 변경이 가능합니다.\n변경하시겠습니까?");
			
			if(var_confirm){
				$("#promotions-register_image-count").text(0);
						
				$(".promotions-register-addimage-sortable").remove();
				
				var li = document.createElement("li");
				li.className="promotions-register-addimage-sortable";

				li.innerHTML = 
					"<div class='mthumb list-thumb-small image-small'>"
					+"<div class='info_box btn_add'>등록</div>"
					+"<div class='thumb' style='display:none;'>"
					+"<input type='file' name='promotions[images_url]' class='promotion-modify_add-image'>"
					+"</div>"
					+"</div>"

				$(".extraImage").append(li);
			}
		});
		
		//When save btn clicked
		$(".btn_save").click(function(){
			document.getElementById("frm").submit();
		});
		
		//When cancel btn clicked
		$(".btn_cancel").click(function(){
			var var_confirm = confirm("프로모션 수정을 취소하시겠습니까?");
			
			if(var_confirm) history.go(-01);
		});
	});
	
	$(document).on("click",".info_box",function(e){
		e.preventDefault();
		
		$(this).siblings().children("input:file[name='promotions[images_url]']").click();
	});
	$(document).on("change","input:file[name='promotions[images_url]']",function(){
		var is_exist = $(this).siblings().length;
		
		if(is_exist == 0){
			if(detail_image_count < 5){
				detail_image_count += 1;
				$("#promotions-register_image-count").text(detail_image_count);
				
				if(this.files && this.files[0]){
					$(".info_box").remove();
					$(this).parent().css("display","block");
					
					var parent_div = $(this).parent();
					
					var reader = new FileReader;
					reader.onload = function(data){
						var img = document.createElement("img");
						img.setAttribute("src",data.target.result);
						img.setAttribute("class","promotion-modify_add-image-tag");
						
						parent_div.prepend(img);
					}
					reader.readAsDataURL(this.files[0]);
					
					//Setting btns
					var buttons = document.createElement("div");
					buttons.className = "buttons";
					
					buttons.innerHTML = 
						"<button type='button' class='btn-edit'>"
						+"<span class='ico_edit'></span>변경"
						+"</button>"
						+"<button type='button' class='btn-delete'>"
						+"<span class='ico_delete'></span>삭제"
						+"</button>";
					
					parent_div.parent().append(buttons);
					
					//Add next image add btn
					var li = document.createElement("li");
					li.className="promotions-register-addimage-sortable";

					li.innerHTML = 
						"<div class='mthumb list-thumb-small image-small'>"
						+"<div class='info_box btn_add'>등록</div>"
						+"<div class='thumb' style='display:none;'>"
						+"<input type='file' name='promotions[images_url]' class='promotion-modify_add-image'>"
						+"</div>"
						+"</div>"

					$(".extraImage").append(li);
				}
			}else{
				if(this.files && this.files[0]){
					alert("5장까지만 추가할 수 있습니다.");
				}
			}
		}else{
			if(this.files && this.files[0]){
				var reader = new FileReader;
				
				var img = $(this).siblings();
				
				reader.onload = function(data){
					img.attr("src",data.target.result);
				}
				
				reader.readAsDataURL(this.files[0]);
			}
		}
	});
	
	//If change image btn clicked
	$(document).on("click",".btn-edit",function(){
		$(this).parent().siblings().children("input:file[name='promotions[images_url]']").click();
	});
	
	//If delete image btn clicked
	$(document).on("click",".btn-delete",function(){
		$(this).closest("li").remove();
		
		detail_image_count -= 1;
		$("#promotions-register_image-count").text($(".promotion-modify_add-image-tag").length);
	})
</script>
<meta charset="UTF-8">
<title>프로모션 수정 | 위쇼핑 !</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="promotions-feed_regist">
			<h2 class="promotions-feed-regist_title">프로모션 수정</h2>
			<div class="container">
				<div class="row promotions-feed-register">
					<form id="frm" name="frm" enctype="multipart/form-data" action="modify" method="post">
						<input type="hidden" name="pno" value="${promotion.pno}">
						<section class="admin-promotions-area">
							<div class="table-block">
								<table>
									<tbody>
										<tr>
											<th>프로모션 이름</th>
											<td class="subject">
												<input type="text" name="subject" placeholder="프로모션 이름을 입력해주세요." value="${promotion.subject}">
											</td>
											<th>프로모션 기간</th>
											<td class="date">
												<div class="tbl_row">
													<div class="date">
														<input type="text" name="startdate" placeholder="ex) 2020-01-01" class="hasDatepicker" value="${promotion.startdate}">
														~
														<input type="text" name="enddate" placeholder="ex) 2020-12-31" class="hasDatepicker" value="${promotion.enddate}">
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th>진행 여부</th>
											<td class="isuse" colspan="3">
												<label>
													<input type="radio" name="status" value="1"<c:if test="${promotion.status eq 1 }"> checked=""</c:if>><span>진행</span>
												</label>
												<label>
													<input type="radio" name="status" value="0"<c:if test="${promotion.status eq 0 }"> checked=""</c:if>><span>종료</span>
												</label>
											</td>
										</tr>
										<tr>
											<th>썸네일</th>
											<td class="thumbnail image" colspan="3">
												<div class="promotions-item_image-thumbnail">
													<div class="thumb_info_box img_exist" style="background-image:url('${pageContext.request.contextPath}/${promotion.thumbnailurl}');"></div>
													<div class="thumb_info_box img_modify" style="display:none;"></div>
													<input type="file" name="promotions[thumbnail_url]" class="promotions-register-thumb" id="promotions-register-thumb">
												</div>
											</td>
										</tr>
										<tr>
											<th>상세 이미지</th>
											<td class="image" colspan="3">
												<span class="txt_strong" style="margin-left:10px;">이미지</span>
												<span class="txt_byte">[<strong id="promotions-register_image-count">0</strong>/5]</span>
												<span class="txt_image_modify">변경</span>
												<div class="thumbs">
													<ul class="extraImage">
														<c:forEach var="image" items="${images}">
															<li class="promotions-register-addimage-sortable">
																<div class="mthumb list-thumb-small image-small">
																	<div class="thumb">
																		<img src="${pageContext.request.contextPath}/${image}" class="promotion-modify_add-image-tag">
																		<input type="file" name="promotions[images_url]" class="promotion-modify_add-image" style="display:none;">
																	</div>
																</div>
															</li>
														</c:forEach>
													</ul>
												</div>
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