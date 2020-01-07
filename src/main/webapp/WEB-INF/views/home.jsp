<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<html lang="ko">
<head>
<script type="text/javascript">
	$(document).ready(function(){
		//Change best category
		$(".production-best-feed_category_item").click(function(){
			$(".active").removeClass("active");
			$(this).addClass("active");
			
			var data = $(this).text();
			
			$.ajax({
				url : "/WiShopping/",
				type : "post",
				data : {data : data},
				success : function(best){
					
					var count = 0;
					
					if(best.length != 0){
						$.each(best, function(){
							var item = $(".production-best-feed_item")[count++];
							
							//Product reflect for selected tab
							$(item).children().children().attr("href","${pageContext.request.contextPath}/productions/view?pno="+this.pno);
							$(item).children().children().children().children().attr("src","/WiShopping"+this.productthumurl);
							$(item).children().children().children(".info").children(".product-name").text(this.pname);
							$(item).children().children().children(".info").children(".price").children(".selling-price").text(comma(this.price));
						});
					}else{
						console.log("해당 항목이 비어있습니다.");
					}
				}
			});
		});
	});
	
	//Carousel rolling banner
	$(document).ready(function(){
		var banner = $(".carousel_content");
		var banner_item = banner.children();
		var banner_length = banner.children().length;
		
		var count = 0;
		
		var rollingId;
		
		auto();
		
		//Banner mouse over event
		banner.mouseover(function(){
			clearInterval(rollingId);
		});
		
		//Banner mouse out event
		banner.mouseout(function(){
			auto();
		});

		$(".left").mouseover(function(){
			clearInterval(rollingId);
		});
		
		$(".left").mouseout(function(){
			auto();
		});

		$(".right").mouseover(function(){
			clearInterval(rollingId);
		});
		
		$(".right").mouseout(function(){
			auto();
		});
		
		//Prev banner show
		$(".left").click(function(){
			var li = $(".banner_show");
			var li_alt = li.children().children().children().attr("alt");
			
			//Calculate the count to be shown next
			for(var i=0;i<banner_length;i++){
				var alt = $(banner_item[i]).children().children().children().attr("alt");
				
				if(li_alt == alt){
					count = i-1;
					
					if(count < 0){
						count = banner_length-1;
					}
					break;
				}
			}

			//Setting banner
			li.removeClass("banner_show").addClass("banner_hide");
			$(banner_item[count]).removeClass("banner_hide").addClass("banner_show");
		});
		
		//Next banner show
		$(".right").click(function(){
			var li = $(".banner_show");
			var li_alt = li.children().children().children().attr("alt");

			//Calculate the count to be shown next
			for(var i=0;i<banner_length;i++){
				var alt = $(banner_item[i]).children().children().children().attr("alt");

				if(li_alt == alt){
					count = i+1;
					
					if(count > (banner_length - 1)){
						count = 0;
					}
					break;
				}
			}

			//Setting banner
			li.removeClass("banner_show").addClass("banner_hide");
			$(banner_item[count]).removeClass("banner_hide").addClass("banner_show");
		});
		
		function auto(){
			//Call start event 2sec
			rollingId = setInterval(function(){
				start();
			}, 3000);
		};

		function start(count){
			var li = $(".banner_show");
			var li_alt = li.children().children().children().attr("alt");
			var count = 0;

			//Calculate the count to be shown next
			for(var i=0;i<banner_length;i++){
				var alt = $(banner_item[i]).children().children().children().attr("alt");
				
				if(li_alt == alt){
					count = i+1;
					
					if(count >= banner_length){
						count = 0;
					}
				}
			} 
			
			//Setting banner
			li.removeClass("banner_show").addClass("banner_hide");
			$(banner_item[count]).removeClass("banner_hide").addClass("banner_show");
		};
		
	});
</script>
<title>Home</title>
<meta charset="UTF-8">
</head>
<body>
	<div class="layout">
		<jsp:include page="header.jsp"/>
		<div class="home">
			<div class="container home-header" style="width:100%;">
				<div class="carousel full main_banner">
					<div class="page_info full left big">
						<button type="button">
							<span class="hide">이전 배너 보기</span>
						</button>
					</div>
					<ul class="carousel_content">
						<c:forEach var="banner" items="${mainBanners}" varStatus="status">
							<c:if test="${status.count eq 1}">
								<li class="banner_show">
							</c:if>
							<c:if test="${status.count ne 1}">
								<li class="banner_hide">
							</c:if>
								<div class="banner_inner">
									<a href="${banner.bannerlink}"><img src="${pageContext.request.contextPath}${banner.bannerurl}" alt="${banner.banneralt}"></a>
								</div>
							</li>
						</c:forEach>
					</ul>
					<div class="page_info full right big">
						<button type="button">
							<span class="hide">다음 배너 보기</span>
						</button>
					</div>
				</div>
			</div>
			<section class="container home-section home-best">
				<header class="row home-section_header">
					<h2 class="col home-section_header_content"><a href="${pageContext.request.contextPath}/commerce/best/main?category=all">베스트</a></h2>
				</header>
				<div class="production-best-feed">
					<ul class="production-best-feed_category">
						<li class="production-best-feed_category_item active">전체</li>
						<li class="production-best-feed_category_item">패션</li>
						<li class="production-best-feed_category_item">잡화</li>
						<li class="production-best-feed_category_item">인테리어</li>
						<li class="production-best-feed_category_item">디지털·가전</li>
					</ul>
					<div class="row production-best-feed_group">
						<div class="col production-best-feed_list-wrap">
							<ul class="row production-best-feed_list">
								<c:forEach var="best" items="${allBest}">
									<div class="col-4 production-best-feed_item">
										<div class="home-production-item">
											<a href="${pageContext.request.contextPath}/productions/view?pno=${best.pno}">
												<div class="img-wrap square home-production-item_wrapper">
													<img class="home-production-item_image" src="${pageContext.request.contextPath}/${best.productthumurl}">
												</div>
												<div class="info">
													<p class="product-name">${best.pname}</p>
													<p class="price">
														<strong class="selling-price text-black"><fmt:formatNumber type="number" maxFractionDigits="3" value="${best.price}"/></strong>
													</p>
												</div>
											</a>
										</div>
									</div>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>