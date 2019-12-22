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
		$(".production-best-feed_category_item").click(function(){
			$(".active").removeClass("active");
			$(this).addClass("active");
			
			var data = $(this).text();
			
			$.ajax({
				url : "/myapp/",
				type : "post",
				data : {data : data},
				success : function(best){
					var count = 0;
					$.each(best, function(){
						var item = $(".production-best-feed_item")[count++];
						
						//Product reflect for selected tab
						$(item).children().children().attr("href","${pageContext.request.contextPath}/productions/view?pno="+this.pno);
						$(item).children().children().children().children().attr("src","/myapp"+this.productthumurl);
						$(item).children().children().children(".info").children(".product-name").text(this.pname);
						$(item).children().children().children(".info").children(".price").children(".selling-price").text(comma(this.price));
					});
				}
			});
		});
	});
	
</script>
<title>Home</title>
<meta charset="UTF-8">
</head>
<body>
	<div class="layout">
		<jsp:include page="header.jsp"/>
		<div class="home">
			<div class="container home-header">
				<div class="row">
					<div class="home-header_banner-large">
						<article class="large-entry">
							<a class="large-entry-link" href="javascript:void(0);">
								<div class="large-entry_image-wrap">
									<div class="large-entry_image" style="background-image:url('https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-projects-cover_images-157649599922720846.jpg/850/none'); 
										background-size:cover; background-repeat:no-repeat;"></div>
								</div>
								<div class="large-entry_content-wrap">
									<div class="large-entry_content">
										<div class="large-entry_content_title">테스트용입니다.</div>
										<div class="large-entry_content_profile">
											<span class="large-entry_content_profile_name">이동근</span>
										</div>
									</div>
									<div class="home-header_large_more">보러가기</div>
								</div>
							</a>
						</article>
					</div>
					<div class="home-header_banner-small">
						<div class="home-header_banner-wrap">
							<div class="home-header_banner-container">
								<div class="list-wrap home-header_banner">
									<div class="list home-header_banner_list" style="transform:translateX(0%); transition;">
										<div class="list_entry home-header_banner_item" style="width:100%;">
											<a href="javascript:void(0);" class="home-header_banner_item_link">
												<div class="banner" style="background-image:url('https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-contests-pc_banner-157594094666018677.png/320/none'); background-size:cover; background-repeat:no-repeat;"></div>
											</a>
										</div>
									</div>
								</div>
								<div class="home-header_banner-control">
									<div class="home-header_banner-control_icon">
										<svg class="home-header_banner-control_icon_arrow home-header_banner-control_icon_arrow-left" width="10" height="18" viewBox="0 0 10 18" preserveAspectRatio="xMidYMid meet">
											<path fill="#FFF" fill-rule="evenodd" d="M9.89 9l.137-.137L1.343.18l-1.37 1.37L7.424 9l-7.451 7.451 1.37 1.37 8.684-8.684L9.89 9z"></path>
										</svg>
									</div>
									<div class="home-header_banner-control_icon right">
										<svg class="home-header__banner-control_icon_arrow home-header_banner-control_icon_arrow-right" width="10" height="18" viewBox="0 0 10 18" preserveAspectRatio="xMidYMid meet">
											<path fill="#FFF" fill-rule="evenodd" d="M9.89 9l.137-.137L1.343.18l-1.37 1.37L7.424 9l-7.451 7.451 1.37 1.37 8.684-8.684L9.89 9z"></path>
										</svg>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<section class="container home-section home-best">
				<header class="row home-section_header">
					<h2 class="col home-section_header_content"><a href="javascript:void(0);">베스트</a></h2>
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