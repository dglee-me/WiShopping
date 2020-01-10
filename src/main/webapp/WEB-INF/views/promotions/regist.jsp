<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	var detail_image_count = 0;

	//Click image regist button
	$(document).on("click",".btn_add",function(e){
		e.preventDefault();
		
		if($(this).parent().attr("class") == "promotions-item_image-thumbnail"){//if you click div is thumbnail image case
			$("input:file[name='promotions[thumbnail_url]']").click();
		}else{//if you click div is detail image case
			$(this).parent().children("input:file[class='promotions-register-image']").click();
		}
	});
	//Thumbnail image change function
	$(document).on("change",".promotions-register-thumb",function(){
		if(this.files && this.files[0]){
	        document.getElementById("thumb_info_box").style.display = "none";
	        document.getElementById("thumb_info_box-exist").style.display = "block";
			
			var reader = new FileReader;
			reader.onload = function(data){
				$(".thumb_info_box-exist img").attr("src", data.target.result).width(552);
				$(".thumb_info_box-exist img").height(157);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
	
	
	//Detail image change function
	$(document).on("change",".promotions-register-image",function(){
		if(detail_image_count < 5){// 이미지를 5장이하까지만 이미지 등록 가능
			detail_image_count += 1;

			$("#promotions-register_image-count").text(detail_image_count);
			
			if(this.files && this.files[0]){
				$(".info_box").remove(); //기존의 btn_add 삭제
				
				//새로운 btn_add div 생성
				var listParent = $(this).closest("ul");
				var listChildren = document.createElement("li");
				listChildren.className = "promotions-register-addimage-sortable";	

				listChildren.innerHTML =
					"<div class='list-thumb-small image-small'>"
					+"<div class='info_box btn_add'>등록"
					+"</div>"
					+"<input type='file' name='promotions[images_url]' class='promotions-register-image'>"
					+"</div>";
				
				listParent.append(listChildren);

				//기존의 btn_add 자리에 이미지 보여주는 div 생성
				listParent = $(this).closest("div");
				listChildren = document.createElement("div");
				listChildren.className = "list-thumb-small image-small border";
				
				var reader = new FileReader;
				reader.onload = function(data){
					listChildren.innerHTML = "<img src='"+data.target.result+"' class='promotions-register-add-image-tag'>";
					listParent.prepend(listChildren);
				}
				reader.readAsDataURL(this.files[0]);	
			}
		}else{
			if(this.files && this.files[0]){
				alert("5장까지만 추가할 수 있습니다.");
			}
		}
	});
	
	$(document).ready(function(){
		$(".btn_save").click(function(){
			var subject= $("input:text[name='subject']").val();
			var startdate= $("input:text[name='startdate']").val();
			var enddate= $("input:text[name='enddate']").val();
			var thumbnail = $("input:file[name='promotions[thumbnail_url]']").val();
			var images = $("input:file[name='promotions[images_url]']").val();

			if(subject == "" || startdate == "" || enddate == "" || thumbnail == "" || images == ""){
				alert("이미지 외 입력값을 확인해주세요 ! ")
			}else{
				document.getElementById("frm").submit();
			}
		});
	});
</script>
<meta charset="UTF-8">
<title>위쇼핑 ! - 프로모션 등록</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
		<div class="promotions-feed_regist">
			<h2 class="promotions-feed-regist_title">프로모션 등록</h2>
			<div class="container">
				<div class="row promotions-feed-register">
					<form id="frm" name="frm" enctype="multipart/form-data" action="regist" method="post">
						<section class="admin-promotions-area">
							<div class="table-block">
								<table>
									<tbody>
										<tr>
											<th>프로모션 이름</th>
											<td class="subject">
												<input type="text" name="subject" placeholder="프로모션 이름을 입력해주세요.">
											</td>
											<th>프로모션 기간</th>
											<td class="date">
												<div class="tbl_row">
													<div class="date">
														<input type="text" name="startdate" placeholder="ex) 2020-01-01" class="hasDatepicker">
														~
														<input type="text" name="enddate" placeholder="ex) 2020-12-31" class="hasDatepicker">
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th>썸네일</th>
											<td class="thumbnail" colspan="3">
												<div class="promotions-item_image-thumbnail">
													<div class="btn_add thumb_info_box" id="thumb_info_box">등록</div>
													<div class="thumb_info_box-exist" id="thumb_info_box-exist">
														<img id="thumbnail-regist-image_exist" src="">
													</div>
													<input type="file" name="promotions[thumbnail_url]" class="promotions-register-thumb" id="promotions-register-thumb">
												</div>
											</td>
										</tr>
										<tr>
											<th>상세 이미지</th>
											<td class="image" colspan="3">
												<span class="txt_strong" style="margin-left:10px;">이미지</span>
												<span class="txt_byte">[<strong id="promotions-register_image-count">0</strong>/5]</span>
												<div class="thumbs">
													<ul class="extraImage">
														<li class="promotions-register-addimage-sortable">
															<div class="list-thumb-small image-small">
																<div class="info_box btn_add">등록</div>
																<input type="file" name="promotions[images_url]" class="promotions-register-image" id="promotions-register-image">
															</div>
														</li>
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