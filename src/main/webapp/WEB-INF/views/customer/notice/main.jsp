<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function(){
		//Paging prev button click event
		$(".list-paginator_prev").click(function(){
			var page = parseInt($(".notice-list-paginator_page.selected").text(),10) - 1;
			var prev_page = $(".notice-list-paginator_page.selected").parent().prev().children();
			
			$.ajax({
				url : "/WiShopping/customer/noticeListCount",
				type : "post",
				success : function(count){
					if(count%10 == 0) var nav = parseInt(count/10, 10);
					else var nav = parseInt(count/10, 10) + 1;
					
					if(page > 0){
						if(page >= 9){
							var ul = $(".notice-list_paginator li:first-child");
							
							var li = document.createElement("li");
							li.innerHTML = "<button class='list-paginator_page notice-list-paginator_page'>" + page-8 + "</button>";

							$(".notice-list-paginator_page.selected").parent().remove();
							ul.after(li);
						}
						
						$.ajax({
							url : "/WiShopping/customer/noticeListUpdate",
							type : "post",
							data : {page : page},
							success : function(list){
								$(".list tbody tr").remove();
								
								$.each(list, function(){
									//date fomrat init
									var date = new Date(this.writedate);
									
									var year = date.getFullYear();
									var month = (1 + date.getMonth());
									month = month >= 10 ? month : "0" + month;
									var day = date.getDate();
									day = day >= 10 ? day : "0" + day;
									
									date = year + "-" + month + "-" +day;
									
									var tr = document.createElement("tr");
									tr.innerHTML = 
										"<td>"+this.bno+"</td>"+
										"<td><a href='/WiShopping/customer/notice/'"+this.bno+">"+this.subject+"</a></td>"+
										"<td>"+date+"</td>"+
										"<td>"+this.readcount+"</td>";
										
									$(".list tbody").append(tr);
									$(".notice-list-paginator_page.selected").removeClass("selected");
									prev_page.addClass("selected");
								});
							}
						});
					}
				}
			});
		});
		
		//Paging next button click event
		$(".list-paginator_next").click(function(){
			var page = parseInt($(".notice-list-paginator_page.selected").text(),10) + 1;
			
			$.ajax({
				url : "/WiShopping/customer/noticeListCount",
				type : "post",
				success : function(count){
					if(count%10 == 0) var nav = parseInt(count/10, 10);
					else var nav = parseInt(count/10, 10) + 1;

					//Only run when the next page is less than or equal to the navigator
					if(page <= nav){
						//Create page button
						if(page > 9){
							$(".notice-list_paginator li:first-child").next().remove();
							
							var ul = $(".notice-list_paginator li:last-child");
							
							var li = document.createElement("li");
							li.innerHTML = "<button class='list-paginator_page notice-list-paginator_page'>" + page + "</button>";
							
							ul.before(li);
						}

						var next_page = $(".notice-list-paginator_page.selected").parent().next().children();
						
						$.ajax({
							url : "/WiShopping/customer/noticeListUpdate",
							type : "post",
							data : {page : page},
							success : function(list){
								$(".list tbody tr").remove();
								
								$.each(list, function(){
									//date fomrat init
									var date = new Date(this.writedate);
									
									var year = date.getFullYear();
									var month = (1 + date.getMonth());
									month = month >= 10 ? month : "0" + month;
									var day = date.getDate();
									day = day >= 10 ? day : "0" + day;
									
									date = year + "-" + month + "-" +day;
									
									var tr = document.createElement("tr");
									tr.innerHTML = 
										"<td>"+this.bno+"</td>"+
										"<td><a href='/WiShopping/customer/notice/'"+this.bno+">"+this.subject+"</a></td>"+
										"<td>"+date+"</td>"+
										"<td>"+this.readcount+"</td>";
										
									$(".list tbody").append(tr);
									$(".notice-list-paginator_page.selected").removeClass("selected");
									next_page.addClass("selected");
								});
							}
						});
					}
				}
			});
		});

		//Reflect when selecting notice page
		$(".notice-list-paginator_page").click(function(){
			var curPage = $(this);
			var page = $(this).text();
			
			var idx = $(".notice-list-paginator_page");
			
			$.ajax({
				url : "/WiShopping/customer/noticeListCount",
				type : "post",
				success : function(count){
					if(count%10 == 0) var max = parseInt(count/10, 10);
					else var max = parseInt(count/10, 10) + 1;
					
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
							if(min == 0) min = 1;
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
						url : "/WiShopping/customer/noticeListUpdate",
						type : "post",
						data : {page : page},
						success : function(list){
							$(".list tbody tr").remove();
							
							$.each(list, function(){
								//date fomrat init
								var date = new Date(this.writedate);
								
								var year = date.getFullYear();
								var month = (1 + date.getMonth());
								month = month >= 10 ? month : "0" + month;
								var day = date.getDate();
								day = day >= 10 ? day : "0" + day;
								
								date = year + "-" + month + "-" +day;
								
								var tr = document.createElement("tr");
								tr.innerHTML = 
									"<td>"+this.bno+"</td>"+
									"<td><a href='/WiShopping/customer/notice/"+this.bno+"'>"+this.subject+"</a></td>"+
									"<td>"+date+"</td>"+
									"<td>"+this.readcount+"</td>";
									
								$(".list tbody").append(tr);
								$(".notice-list-paginator_page.selected").removeClass("selected");
								curPage.addClass("selected");
							});
						}
					});
				}
			});
		});
	});
</script>
<meta charset="UTF-8">
<title>고객센터 | 위쇼핑 !</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"/>
	<div class="main">
		<div class="contact_us-center">
			<div id="contact_us">
				<div class="customer-center_header">
					<div class="customer-center_header-title">고객센터</div>
					<div class="customer-center_header-category">
						<div class="customer-center_header-category-child">
							<div class="customer-category-filter">
								<ul class="customer-category-filter_wrap">
									<li class="customer-category-filter_item customer-category-filter_item-active">
										<a href="${pageContext.request.contextPath}/customer/notice">공지사항</a>
									</li>
									<li class="customer-category-filter_item">
										<a href="${pageContext.request.contextPath}/customer/faq">자주묻는 질문</a>
									</li>
									<li class="customer-category-filter_item">
										<a href="${pageContext.request.contextPath}/customer/questions">1:1 문의하기</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="container">
					<div id="board">
						<h3 class="customer-center_notice-title">공지사항</h3>
						<div class="customer-center_notice-list">
							<table class="list">
								<colgroup>
									<col width="122">
									<col width="592">
									<col width="106">
									<col width="117">
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>날짜</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="notice" items="${noticeList}">
										<tr>
											<td>${notice.bno}</td>
											<td><a href="${pageContext.request.contextPath}/customer/notice/${notice.bno}">${notice.subject}</a></td>
											<td>${notice.writedate}</td>
											<td>${notice.readcount}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="customer-center_notice-write-btn">
							<div class="customer-center_notice-write-btn_fr">
								<a href="${pageContext.request.contextPath}/customer/notice/write" class="btn_type1 post_write">글쓰기</a>
							</div>
						</div>
						<c:if test="${!empty noticeList}">
							<ul class="list-paginator notice-list_paginator">
								<li>
									<button class="list-paginator_prev notice-list-paginator_prev" type="button">
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
											<button class="list-paginator_page notice-list-paginator_page selected">${idx}</button>
										</c:if>
										<c:if test="${idx ne 1}">
											<button class="list-paginator_page notice-list-paginator_page">${idx}</button>
										</c:if>
									</li>
								</c:forEach>
								<li>
									<button class="list-paginator_next notice-list-pagenator_next" type="button">
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
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
</body>
</html>