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
	//Add and remove active class
	$(document).ready(function(){
		var url = decodeURI(location.href);
		var status = url.split("order=")[1];
		
		if(typeof status == "undefined"){
			$(".customer-center_faq-nav-item-active").removeClass("customer-center_faq-nav-item-active");
			$($(".customer-center_faq-nav-list li")[0]).addClass("customer-center_faq-nav-item-active");
		}else if(status == "payment"){
			$(".customer-center_faq-nav-item-active").removeClass("customer-center_faq-nav-item-active");
			$($(".customer-center_faq-nav-list li")[1]).addClass("customer-center_faq-nav-item-active");
		}else if(status == "shipping"){
			$(".customer-center_faq-nav-item-active").removeClass("customer-center_faq-nav-item-active");
			$($(".customer-center_faq-nav-list li")[2]).addClass("customer-center_faq-nav-item-active");
		}else if(status == "cancel"){
			$(".customer-center_faq-nav-item-active").removeClass("customer-center_faq-nav-item-active");
			$($(".customer-center_faq-nav-list li")[3]).addClass("customer-center_faq-nav-item-active");
		}else if(status == "exchange"){
			$(".customer-center_faq-nav-item-active").removeClass("customer-center_faq-nav-item-active");
			$($(".customer-center_faq-nav-list li")[4]).addClass("customer-center_faq-nav-item-active");
		}else if(status == "etc"){
			$(".customer-center_faq-nav-item-active").removeClass("customer-center_faq-nav-item-active");
			$($(".customer-center_faq-nav-list li")[5]).addClass("customer-center_faq-nav-item-active");
		}
	});
	
	$(document).ready(function(){
		$(".customer-center_faq-item_question").click(function(){
			var answer = $(this).siblings();
			var status = answer.css("opacity") == 0 ? true : false;
			
			if(status){
				answer.removeAttr("style");
			}else{
				answer.css("max-height", "0px");
				answer.css("opacity", "0");
				answer.css("padding-top", "0px");
			}
		});
		
		$(".customer-center_faq-nav-item").click(function(){
			console.log($(this).text());
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
									<li class="customer-category-filter_item">
										<a href="${pageContext.request.contextPath}/customer/notice">공지사항</a>
									</li>
									<li class="customer-category-filter_item customer-category-filter_item-active">
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
						<h3 class="customer-center_faq-title">자주 묻는 질문</h3>
						<div class="customer-center_faq-list">
							<article id="faq" class="faq">
								<nav class="customer-center_faq-nav">
									<ul class="customer-center_faq-nav-list">
										<li class="customer-center_faq-nav-item customer-center_faq-nav-item-active"><a href="${pageContext.request.contextPath}/customer/faq">전체</a></li>
										<li class="customer-center_faq-nav-item"><a href="${pageContext.request.contextPath}/customer/faq?order=payment">주문/결제</a></li>
										<li class="customer-center_faq-nav-item"><a href="${pageContext.request.contextPath}/customer/faq?order=shipping">배송</a></li>
										<li class="customer-center_faq-nav-item"><a href="${pageContext.request.contextPath}/customer/faq?order=cancel">취소/환불</a></li>
										<li class="customer-center_faq-nav-item"><a href="${pageContext.request.contextPath}/customer/faq?order=exchange">반품/교환</a></li>
										<li class="customer-center_faq-nav-item"><a href="${pageContext.request.contextPath}/customer/faq?order=etc">서비스/기타</a></li>
									</ul>
								</nav>
								<article class="customer-cetner_faq-contents">
									<section class="customer-center_faq-content_group">
										<c:forEach var="list" items="${list}">
											<section class="customer-center_faq-item">
												<div class="customer-center_faq-item_question">${list.question}
													<span class="icon--page-mypage" style="position: absolute; right: 0px; top: 50%; transition: transform 0.2s ease 0s; transform: translateY(-50%); background-position: -120px -160px; width: 12px; height: 12px;"></span>
												</div>
												<div class="customer-center_faq-item_answer" style="max-height: 0px; opacity: 0; padding-top: 0px;">
													<p>${list.answer}</p>
												</div>
											</section>
										</c:forEach>
									</section>
								</article>
							</article>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
</body>
</html>