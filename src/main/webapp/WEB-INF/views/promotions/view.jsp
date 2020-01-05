<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js" async></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	//Change the comment creation time format
	$(document).ready(function(){
		$.each($(".comment-feed_item_footer_time"), function(){
			$(this).text(dateTimeToFormat($(this).text()));
		});
	});
	
	$(document).ready(function(){
		//Component when inputting the registration button disabled
		$("body").on("focus","[contenteditable]",function(){
			const $this = $(this);
			$this.data("before",$this.html());
		}).on("blur keyup paste input","[contenteditable]",function(){
			const $this = $(this);
			if ($this.data("before") !== $this.html()) {
		        $this.data("before", $this.html());
		        $this.trigger("change");
		        
		        $(".comment-feed_form_submit").attr("disabled",false);

				//Enable button disabled if nothing is entered.
		        if($this.text() == ""){
			        $(".comment-feed_form_submit").attr("disabled",true);
		        }
			}
		});
		
		//Comment regist
		$(".comment-feed_form_submit").click(function(){
			var url = decodeURI(location.href);
			
			var pno = url.slice(url.indexOf('=') + 1);
			var content = $("[contenteditable]").text();
			
			
			$.ajax({
				url : "/myapp/promotions/commentRegist",
				type : "post",
				data : {
					pno : pno,
					content : content
				},
				success : function(list){
					$(".comment-feed_list_item").remove(); //Delete an existing oul
					
					
					$.each(list, function(){
						var comment = document.createElement("li");

						comment.className = "comment-feed_list_item";
						comment.innerHTML = 
							"<article class='comment-feed_item'>"
							+"<p class='comment-feed_item_content'>"
							+"<a href='javascript:void(0);' class='comment-feed_item_content_author'>"
							+"<img src='/myapp/resources/image/none_user.png' class='comment-feed_item_content_author_image' alt='"+this.name+"'>"
							+"<span class='comment-feed_item_content_author_name'>"+this.name+"</span>"
							+"</a>"
							+"<span class='comment-feed_item_content_content'>"+this.content+"</span>"
							+"</p>"
							+"<footer class='comment-feed_item_footer'>"
							+"<time class='comment-feed_item_footer_time'>"+dateTimeToFormat(this.replytime)+"</time>"
							+"<button class='comment-feed_item_footer_report-btn' type='button'>신고</button>"
							+"</footer>"
							+"</article>";
							
						$(".comment-feed_list").append(comment);
					});
				}
			});
		});
		
		//Count comment
		$(".comment-feed_header_count").text($(".comment-feed_list_item").length);
	});
</script>
<meta charset="UTF-8">
<title>${promotion.subject} | 위쇼핑</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="promotion-page">
			<c:forEach var="image" items="${images}">
				<img src="${pageContext.request.contextPath}${image}" class="col-12 promotion-page_image">
			</c:forEach>
			<div class="promotion-page_comment">
				<section class="comment-feed">
					<h1 class="comment-feed_header">답글 <span class="comment-feed_header_count">0</span></h1>
					<form class="comment-feed_form">
						<div class="comment-feed_form_user">
							<img src="/myapp/resources/image/none_user.png">
						</div>
						<div class="comment-feed_form_input">
							<div class="comment-feed_form_content">
								<div class="comment-content-input">
									<div class="comment-content-input_text comment-feed_form_content_text" data-ph="댓글을 남겨 보세요." contenteditable="true"></div>
								</div>
							</div>
							<div class="comment-feed_form_action">
								<button type="button" class="comment-feed_form_submit" disabled="">등록</button>
							</div>
						</div>
					</form>
					<ul class="comment-feed_list">
						<c:forEach var="comment" items="${comments}">
							<li class="comment-feed_list_item">
								<article class="comment-feed_item">
									<p class="comment-feed_item_content">
										<a href="javascript:void(0);" class="comment-feed_item_content_author">
											<img src="/myapp/resources/image/none_user.png" class="comment-feed_item_content_author_image" alt="${comment.name}">
											<span class="comment-feed_item_content_author_name">${comment.name}</span>
										</a>
										<span class="comment-feed_item_content_content">${comment.content}</span>
									</p>
									<footer class="comment-feed_item_footer">
										<time class="comment-feed_item_footer_time">${comment.replytime}</time>
										<button class="comment-feed_item_footer_report-btn" type="button">신고</button>
									</footer>
								</article>
							</li>
						</c:forEach>
					</ul>
				</section>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>