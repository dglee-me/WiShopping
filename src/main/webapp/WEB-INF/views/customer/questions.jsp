<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">


<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js" async></script>

<script type="text/javascript">
	$(document).ready(function(){
		//Output error msg. if title are not entered
		$("#question_title").blur(function(){
			var subject = $("input:text[name='question[title]']").val();

			if(subject.length < 5){
				$(".question-form-heade_title_subject .error").css("display", "block");
				$("input:text[name='question[title]']").css("border-color", "#F77");
			}else{
				$(".question-form-heade_title_subject .error").css("display", "none");
				$("input:text[name='question[title]']").css("border-color", "#dbdbdb");
			}
		});

		//Output error msg. if content are not entered
		$(".question-form-body_content-text").blur(function(){
			var content = $(".question-form-body_content-text").val();
			
			if(content.length < 1){
				$(".question-form-body_content_wrap .error").css("display", "block");
				$(".question-form-body_content-text").css("border-color", "#F77");
			}else{
				$(".question-form-body_content_wrap .error").css("display", "none");
				$(".question-form-body_content-text").css("border-color", "#dbdbdb");
			}
		});
	});
</script>
<script type="text/javascript"> //Image add script
	var count = 0;
	
	$(document).on("click", ".image-register", function(e){
		e.preventDefault();
		
		$(this).siblings("input:file[name='question[images_url]']").click();
	});
	
	$(document).on("change", ".question-register-image", function(){
		if(this.files && this.files[0]){
			if(checkImageFIle(this)){
				if($(this).siblings().hasClass("btn_add")){ // When adding a new
					if(count < 5){
						count++;
						
						$(".btn_add").remove(); //기존의 btn_add 삭제
						
						//새로운 btn_add div 생성
						var listParent = $(this).closest("ul");
						var listChildren = document.createElement("li");
						
						listChildren.innerHTML =
							"<div class='list-thumb-small image-small'>"
							+"<div class='info_box btn_add image-register'>등록"
							+"</div>"
							+"<input type='file' name='question[images_url]' class='question-register-image'>"
							+"</div>";
						
						listParent.append(listChildren);
						
						//기존의 btn_add 자리에 이미지 보여주는 div 생성
						listParent = $(this).closest("div");
						listChildren = document.createElement("div");
						listChildren.className = "list-thumb-small image-small image-register";
						
						var reader = new FileReader;
						reader.onload = function(data){
							listChildren.innerHTML = "<img src='"+data.target.result+"' class='question-register-image-tag'>";
							listParent.prepend(listChildren);
						}
						reader.readAsDataURL(this.files[0]);
					}else{
						alert("이미지는 최대 5개까지 첨부가 가능합니다.");
					}
				}else{	//When changing an existing image
					$(this).siblings().remove();
					
					//기존의 btn_add 자리에 이미지 보여주는 div 생성
					listParent = $(this).closest("div");
					listChildren = document.createElement("div");
					listChildren.className = "list-thumb-small image-small image-register";
					
					var reader = new FileReader;
					reader.onload = function(data){
						listChildren.innerHTML = "<img src='"+data.target.result+"' class='question-register-image-tag'>";
						listParent.prepend(listChildren);
					}
					reader.readAsDataURL(this.files[0]);
				}					
			}
		}
	});
	
	$(document).ready(function(){
		$(".question-form_submit").click(function(){
			/*
			var formData = new FormData($("#question-form")[0]);
			
			formData.append("subject", $("input:text[name='question[title]']").val());
			formData.append("content", $(".question-form-body_content-text").val());
			
			formData.append("images",$("input:file[name='question[images_url]']"));
			
			if(formData.get("images") == "undefined"){
				formData.delete("images");
			}
			*/
			
			document.question_form.submit();
		});
	});
</script>
<meta charset="UTF-8">
<title>질문하기 | 위쇼핑 !</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="main">
		<div class="question-form container">
			<form id="question-form" name="question_form" actions="questions" method="post" enctype="multipart/form-data">
				<header class="question-form-header">
					<h2 class="question-form-header_title">1:1 문의하기</h2>
					<div class="question-form-header_title_subject form-group">
        				<input placeholder="제목을 적어주세요." class="form-control" maxlength="61" size="1" type="text" name="subject" id="question_title">
        				<p class="error">제목을 5글자 이상 적어주세요.</p>
      				</div>
				</header>
				<section class="question-form-body">
					<div class="question-form-body_content">
						<div class="question-form-body_content_wrap form-group">
							<textarea name="content" placeholder="내용을 입력하세요" maxlength="1000" class="form-control question-form-body_content-text" style="height: 300px; font-size:15px;"></textarea>
							<p class="error">문의내용을 입력하여주세요.</p>
						</div>
					</div>
					<div class="question-form-body_picure">
						<div class="question-form-body_picure-thumbs thumbs">
							<ul class="extraImage">
								<li>
									<div class="list-thumb-small image-small">
										<div class="info_box btn_add image-register">등록</div>
										<input type="file" name="question[images_url]" class="question-register-image">
									</div>
								</li>
							</ul>
						</div>
					</div>
				</section>
				<footer class="question-form_footer">
			    	<div class="question-form_footer_submit row">
			        	<button type="button" class="col-6 question-form_submit">문의하기</button>
			      	</div>
			    </footer>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>