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
				url : "/WiShopping/promotions/commentRegist",
				type : "post",
				data : {
					pno : pno,
					content : content
				},
				success : function(result){
					if(result == 1){
						location.reload();

						var href = $("#promotion-page_comment_href").offset();
						href.top -= 40;
						
						$("html, body").animate({scrollTop : href.top},300);
					}else if(result == 0){
						alert("로그인 후 이용 가능합니다.");
						
						location.href = "/WiShopping/auth/login";
					}
				},error : function(){
					location.href = "/WiShopping/error";
				}
			});
		});
		
		//Prev button click event
		$(".list-paginator_prev").click(function(){
			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			var page = parseInt($(".list-paginator_page.selected").text(),10) - 1;
			var prev_page = $(".list-paginator_page.selected").parent().prev().children();
			
			if(page > 0){
				if(page >= 9){
					var ul = $(".list-paginator li:first-child");
					
					var li = document.createElement("li");
					li.innerHTML = "<button class='list-paginator_page'>" + (parseInt(page,10) - 8) + "</button>";

					$(".selected").parent().remove();
					ul.after(li);
				}
				
				$.ajax({
					url : "/WiShopping/promotions/commentListUpdate",
					type : "post",
					data : {
						page : page,
						pno : pno	
					},success : function(comments){
						$(".comment-feed_list_item").remove(); //Delete an existing oul
						
						$.each(comments, function(){
							var comment = document.createElement("li");

							comment.className = "comment-feed_list_item";
							comment.innerHTML = 
								"<article class='comment-feed_item'>"
								+"<p class='comment-feed_item_content'>"
								+"<a href='javascript:void(0);' class='comment-feed_item_content_author' user-number='"+this.mno+"'>"
								+"<img src='/WiShopping/resources/image/none_user.png' class='comment-feed_item_content_author_image' alt='"+this.name+"'>"
								+"<span class='comment-feed_item_content_author_name'>"+this.name+"</span>"
								+"</a>"
								+"<span class='comment-feed_item_content_content'>"+this.content+"</span>"
								+"</p>"
								+"<footer class='comment-feed_item_footer' data-number='"+this.rno+"'>"
								+"<time class='comment-feed_item_footer_time'>"+dateTimeToFormat(this.replytime)+"</time>"
								+"<button class='comment-feed_item_footer_report-btn' type='button'>신고</button>"
								+"<button class='comment-feed_item_footer_delete-btn' type='button'>삭제</button>"
								+"</footer>"
								+"</article>";
								
							$(".comment-feed_list").append(comment);
							
							$(".selected").removeClass("selected");
							prev_page.addClass("selected");
						});
					}
				});
			}
		});
		
		//Next button click event
		$(".list-paginator_next").click(function(){
			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			var page = parseInt($(".list-paginator_page.selected").text(),10) + 1;
			
			$.ajax({
				url : "/WiShopping/promotions/commentListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					var page_nav = parseInt(count / 5,10) + 1;
					
					//Only run when the next page is less than or equal to the navigator
					if(page <= page_nav){
						//Create page button
						if(page > 9){
							$(".list-paginator li:first-child").next().remove();
							
							var ul = $(".list-paginator li:last-child");
							
							var li = document.createElement("li");
							li.innerHTML = "<button class='list-paginator_page'>" + page + "</button>";
								
							ul.before(li);
						}

						var next_page = $(".list-paginator_page.selected").parent().next().children();
						
						$.ajax({
							url : "/WiShopping/promotions/commentListUpdate",
							type : "post",
							async: false,
							data : {
								page : page,
								pno : pno	
							},success : function(comments){
								$(".comment-feed_list_item").remove(); //Delete an existing oul
								
								$.each(comments, function(){
									var comment = document.createElement("li");
			
									comment.className = "comment-feed_list_item";
									comment.innerHTML = 
										"<article class='comment-feed_item'>"
										+"<p class='comment-feed_item_content'>"
										+"<a href='javascript:void(0);' class='comment-feed_item_content_author' user-number='"+this.mno+"'>"
										+"<img src='/WiShopping/resources/image/none_user.png' class='comment-feed_item_content_author_image' alt='"+this.name+"'>"
										+"<span class='comment-feed_item_content_author_name'>"+this.name+"</span>"
										+"</a>"
										+"<span class='comment-feed_item_content_content'>"+this.content+"</span>"
										+"</p>"
										+"<footer class='comment-feed_item_footer' data-number='"+this.rno+"'>"
										+"<time class='comment-feed_item_footer_time'>"+dateTimeToFormat(this.replytime)+"</time>"
										+"<button class='comment-feed_item_footer_report-btn' type='button'>신고</button>"
										+"<button class='comment-feed_item_footer_delete-btn' type='button'>삭제</button>"
										+"</footer>"
										+"</article>";
										
									$(".comment-feed_list").append(comment);
									
									$(".selected").removeClass("selected");
									next_page.addClass("selected");
								});
							}
						});
					}
				}
			});
		});
		
		//Reflect when selecting comment page
		$(document).on("click",".list-paginator_page",function(){
			var page = $(this).text();
			var idx = $(".list-paginator_page");

			$(".selected").removeClass("selected");

			var url = decodeURI(location.href);
			var pno = url.slice(url.indexOf('=') + 1);
			
			//ajax to know page list count
			$.ajax({
				url : "/WiShopping/promotions/commentListCount",
				type : "post",
				data : {pno : pno},
				success : function(count){
					var max = parseInt((count/5),10) + 1;
					var min = page - 4;
					
					if(min <= 0){
						min = 1;

						$.each(idx, function(){
							$(this).text(min++);

							if($(this).text() == page){
								$(this).addClass("selected");
							}
						});
					}else{
						if((max - page) <= 4){
							var min = max - 8;
						}
						
						$.each(idx, function(){
							$(this).text(min++);

							if($(this).text() == page){
								$(this).addClass("selected");
							}
						});
					}
					
					//Reflect composition to match selected page
					$.ajax({
						url : "/WiShopping/promotions/commentListUpdate",
						type : "post",
						async: false,
						data : {
							page : page,
							pno : pno	
						},success : function(comments){
							$(".comment-feed_list_item").remove(); //Delete an existing oul
							
							$.each(comments, function(){
								var comment = document.createElement("li");
		
								comment.className = "comment-feed_list_item";
								comment.innerHTML = 
									"<article class='comment-feed_item'>"
									+"<p class='comment-feed_item_content'>"
									+"<a href='javascript:void(0);' class='comment-feed_item_content_author' user-number='"+this.mno+"'>"
									+"<img src='/WiShopping/resources/image/none_user.png' class='comment-feed_item_content_author_image' alt='"+this.name+"'>"
									+"<span class='comment-feed_item_content_author_name'>"+this.name+"</span>"
									+"</a>"
									+"<span class='comment-feed_item_content_content'>"+this.content+"</span>"
									+"</p>"
									+"<footer class='comment-feed_item_footer' data-number='"+this.rno+"'>"
									+"<time class='comment-feed_item_footer_time'>"+dateTimeToFormat(this.replytime)+"</time>"
									+"<button class='comment-feed_item_footer_report-btn' type='button'>신고</button>"
									+"<button class='comment-feed_item_footer_delete-btn' type='button'>삭제</button>"
									+"</footer>"
									+"</article>";
									
								$(".comment-feed_list").append(comment);
							});
						}
					});
				}
			});
		});
	});
	
	$(document).on("click",".comment-feed_item_footer_delete-btn",function(){
		var var_confirm = confirm("정말로 삭제하시겠습니까?");
		
		if(var_confirm){
			var url = decodeURI(location.href);
			
			var pno = url.slice(url.indexOf('=') + 1);
			var data_number = $(this).parent().attr("data-number");
			
			$.ajax({
				url : "/WiShopping/promotions/commentDelete",
				type : "post",
				data : {
					pno : pno,
					data_number : data_number
				},success : function(result){
					if(result == 1){
						location.reload();

						var href = $("#promotion-page_comment_href").offset();
						href.top -= 40;
						
						$("html, body").animate({scrollTop : href.top},300);
					}
					else if(result == 0){
						alert("로그인 후 이용 가능합니다.");
						
						location.href = "/WiShopping/auth/login";
					}
				}
			});
		}
	});
</script>
<script>
	/*
		Report clicked event
	*/
	$(document).on("click", ".comment-feed_item_footer_report-btn", function(){
		$("body").css("overflow-y","scroll");
		
		var report = document.createElement("div");
		report.id = "create_report";
		report.className = "popup ui-popup";
		
		report.innerHTML = 
			"<div class='create_report'>"+
				"<div class='title'>신고사유를 선택해주세요.</div>"+
				"<div class='contents'>"+
					"<form class='new_report' id='new_report' action='report' method='post'>"+
						"<input type='hidden' name='report[user]' value='"+$(this).parent().siblings().children("a").attr("user-number")+"'>"+
						"<input type='hidden' name='report[number]' value='" + $(this).parent().attr("data-number") + "'>"+
						"<div class='radio ui-checked ui-checked-right-left-text'>"+
							"<input type='radio' value='0' name='report[report_type]' id='report_report_type_0'>"+
							"<label for='report_report_type_0'>주제와 맞지 않음</label>"+
							"<div class='image'></div>"+
						"</div>"+
						"<div class='radio ui-checked ui-checked-right-left-text'>"+
							"<input type='radio' value='1' name='report[report_type]' id='report_report_type_1'>"+
							"<label for='report_report_type_1'>정보가 부정확함</label>"+
							"<div class='image'></div>"+
						"</div>"+
						"<div class='radio ui-checked ui-checked-right-left-text'>"+
							"<input type='radio' value='2' name='report[report_type]' id='report_report_type_2'>"+
							"<label for='report_report_type_2'>광고성 댓글</label>"+
							"<div class='image'></div>"+
						"</div>"+
						"<div class='radio ui-checked ui-checked-right-left-text'>"+
							"<input type='radio' value='3' name='report[report_type]' id='report_report_type_3'>"+
							"<label for='report_report_type_3'>도배 및 중복성 댓글</label>"+
							"<div class='image'></div>"+
						"</div>"+
						"<div class='radio ui-checked ui-checked-right-left-text'>"+
							"<input type='radio' value='4' name='report[report_type]' id='report_report_type_4'>"+
							"<label for='report_report_type_4'>지나친 욕설</label>"+
							"<div class='image'></div>"+
						"</div>"+
					"</form>"+
				"<button name='button' type='submit' class='submit close_popup'>신고하기</button>"
				
		$("body").append(report);
	});

	//Delete layer pop-up when click outside popup area
	$(document).on("click","html",function(e){
		if($(e.target).hasClass("ui-popup")){ //Modal popup exit
			$("body").css("overflow-y","scroll");
			$("#create_report").remove();
		}
	});
	
	$(document).on("click", ".close_popup", function(){
		var cause = $("input:radio[name='report[report_type]']:checked").val();
		var cno = $("input[name='report[number]']").val();
		var rmno = $("input[name='report[user]']").val();
		
		if(typeof cause != "undefined"){
			console.log(cause);
			console.log(cno);
			console.log(rmno);
			
			$.ajax({
				url : "/WiShopping/promotions/report",
				type : "post",
				data : {
					cause : cause,
					cno : cno,
					rmno : rmno
				},success : function(result){
					if(result == 0) location.href = "/WiShopping/auth/login";
					else if(result == 1) alert("신고 완료되었습니다.");
				}
			});
		}
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
			<a id="promotion-page_comment_href"></a>
			<div class="promotion-page_comment">
				<section class="comment-feed">
					<h1 class="comment-feed_header">답글 <span class="comment-feed_header_count">${comment_count}</span></h1>
					<form class="comment-feed_form">
						<div class="comment-feed_form_user">
							<img src="/WiShopping/resources/image/none_user.png">
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
										<a href="javascript:void(0);" class="comment-feed_item_content_author" user-number="${comment.mno}">
											<img src="/WiShopping/resources/image/none_user.png" class="comment-feed_item_content_author_image" alt="${comment.name}">
											<span class="comment-feed_item_content_author_name">${comment.name}</span>
										</a>
										<span class="comment-feed_item_content_content">${comment.content}</span>
									</p>
									<footer class="comment-feed_item_footer" data-number="${comment.rno}">
										<time class="comment-feed_item_footer_time">${comment.replytime}</time>
										<c:if test="${comment.name ne login.name}">
											<button class="comment-feed_item_footer_report-btn" type="button">신고</button>
										</c:if>
										<c:if test="${comment.name eq login.name}">
											<button class='comment-feed_item_footer_delete-btn' type='button'>삭제</button>
										</c:if>
									</footer>
								</article>
							</li>
						</c:forEach>
					</ul>
					<c:if test="${!empty comments}">
					<ul class="list-paginator">
						<li>
							<button class="list-paginator_prev" type="button">
								<svg width="26" height="26" viewBox="0 0 26 26" preserveAspectRatio="xMidYMid meet">
									<g fill="none" fill-rule="evenodd">
										<rect width="25" height="25" x=".5" y=".5" stroke="#DCDCDC" rx="4"></rect>
									<g stroke="#424242" stroke-linecap="square" stroke-width="2">
									<path d="M14.75 8.263L10.25 13M10.25 13l4.5 4.737"></path></g></g>
								</svg>
							</button>
						</li>
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li>
								<c:if test="${idx eq 1}">
									<button class="list-paginator_page selected">${idx}</button>
								</c:if>
								<c:if test="${idx ne 1}">
									<button class="list-paginator_page">${idx}</button>
								</c:if>
							</li>
						</c:forEach>
						<li>
							<button class="list-paginator_next" type="button">
								<svg width="26" height="26" viewBox="0 0 26 26" preserveAspectRatio="xMidYMid meet">
									<g fill="none" fill-rule="evenodd" transform="matrix(-1 0 0 1 26 0)">
										<rect width="25" height="25" x=".5" y=".5" stroke="#DCDCDC" rx="4"></rect>
									<g stroke="#424242" stroke-linecap="square" stroke-width="2">
									<path d="M14.75 8.263L10.25 13M10.25 13l4.5 4.737"></path></g></g>
								</svg>
							</button>
						</li>
					</ul>
					</c:if>
				</section>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>