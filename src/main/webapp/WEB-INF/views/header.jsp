<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js" async></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".btn_search").click(function(){
			var query = $(".ui_input_text").val();
			
			if(query != ""){
				header_search($(".ui_input_text"));
			}
		});
		
		$(".ui_input_text").keyup(function(e){
			var query = $(".ui_input_text").val();
			
			if(query != ""){
				if(e.keyCode == 13){
					header_search($(".ui_input_text"));
				}
			}
		});
	});
	
	//Carousel rolling banner (header banner)
	$(document).ready(function(){
		var header_banner = $(".list_ad");
		var header_banner_item = header_banner.children();
		var header_banner_length = header_banner_item.length;
		
		var header_count = 0;
		
		var header_rollingId;
		
		header_auto();
		
		//Header_banner mouse over event
		header_banner.mouseover(function(){
			clearInterval(header_rollingId);
		});
		
		//Header_banner mouse out event
		header_banner.mouseout(function(){
			header_auto();
		});

		$(".prev").mouseover(function(){
			clearInterval(header_rollingId);
		});
		
		$(".prev").mouseout(function(){
			header_auto();
		});

		$(".next").mouseover(function(){
			clearInterval(header_rollingId);
		});
		
		$(".next").mouseout(function(){
			header_auto();
		});
		
		//Prev banner show
		$(".prev").click(function(){
			var header_li = $(".list_ad_show");
			var header_li_alt = header_li.children().children().attr("alt");
			
			//Calculate the count to be shown next
			for(var i=0;i<header_banner_length;i++){
				var header_alt = $(header_banner_item[i]).children().children().attr("alt");
				
				if(header_li_alt == header_alt){
					header_count = i-1;
					
					if(header_count < 0){
						header_count = header_banner_length-1;
					}
					break;
				}
			}

			//Setting banner
			header_li.removeClass("list_ad_show").addClass("list_ad_hide");
			$(header_banner_item[header_count]).removeClass("list_ad_hide").addClass("list_ad_show");
		});
		
		//Next banner show
		$(".next").click(function(){
			var header_li = $(".list_ad_show");
			var header_li_alt = header_li.children().children().attr("alt");

			//Calculate the count to be shown next
			for(var i=0;i<header_banner_length;i++){
				var header_alt = $(header_banner_item[i]).children().children().attr("alt");

				if(header_li_alt == header_alt){
					header_count = i+1;
					
					if(header_count > (header_banner_length - 1)){
						header_count = 0;
					}
					break;
				}
			}

			//Setting banner
			header_li.removeClass("list_ad_show").addClass("list_ad_hide");
			$(header_banner_item[header_count]).removeClass("list_ad_hide").addClass("list_ad_show");
		});
		
		function header_auto(){
			//Call start event 2sec
			header_rollingId = setInterval(function(){
				start();
			}, 3000);
		};

		function start(header_count){
			var header_li = $(".list_ad_show");
			var header_li_alt = header_li.children().children().attr("alt");
			var header_count = 0;

			//Calculate the count to be shown next
			for(var i=0;i<header_banner_length;i++){
				var header_alt = $(header_banner_item[i]).children().children().attr("alt");
				
				if(header_li_alt == header_alt){
					header_count = i+1;
					
					if(header_count >= header_banner_length){
						header_count = 0;
					}
				}
			} 
			
			//Setting banner
			header_li.removeClass("list_ad_show").addClass("list_ad_hide");
			$(header_banner_item[header_count]).removeClass("list_ad_hide").addClass("list_ad_show");
		};
	});
</script>

<div class="header">
	<div class="inner_top_wrap">
		<div class="mix_inner top_bar">
			<h2 class="hide">유틸메뉴</h2>
			<ul class="top_bar_util">
				<li><a href="javascript:void(0);" onclick="bookmarksite(); return false;">즐겨찾기</a></li>
				<li><a href="${pageContext.request.contextPath}/promotions/main">기획전</a></li>
			</ul>
			<h2 class="hide">로그인메뉴</h2>
			<ul class="top_bar_login">
				<c:if test="${login.name eq null}">
					<li><a href="${pageContext.request.contextPath}/auth/login">로그인</a></li>
					<li><a href="${pageContext.request.contextPath}/auth/join">회원가입</a></li>
					<li><a href="${pageContext.request.contextPath}/customer/notice">고객센터</a></li>
				</c:if>
				<c:if test="${login.name ne null }">
					<li><a href="${pageContext.request.contextPath}/mypage/request"><c:out value="${login.name}"/></a>님, <a href="<%=request.getContextPath() %>/auth/logout">로그아웃</a></li>
					<li><a href="${pageContext.request.contextPath }/customer/notice">고객센터</a></li>
				</c:if>
			</ul>
		</div>
		<div class="mix_inner mix_search_wrap">
				<h1 class="logo"><a href="${pageContext.request.contextPath}/">위쇼핑</a></h1>
				<div class="search_form">
					<form id="header_search_bar" name="header_search_bar" action="${pageContext.request.contextPath}/search/index" method="GET" onsubmit="return false;">
						<div class="search_bar">
							<input type="text" name="query" class="ui_input_text" maxlength="50" title="검색어 입력" placeholder="찾고 싶은 상품을 검색해보세요!">
						</div>
						<span class="btn_search">
							<button type="button" id="_searchBtn">검색</button>
						</span>
					</form>	
				</div>
				<div class="mix_banner">
					<div class="wrap_ad">
						<ul class="list_ad">
							<c:forEach var="banner" items="${headerBanners}" varStatus="status">
							<c:if test="${status.count eq 1}">
								<li class="list_ad_show">
							</c:if>
							<c:if test="${status.count ne 1}">
								<li class="list_ad_hide">
							</c:if>
									<a href="${banner.bannerlink}"><img src="${pageContext.request.contextPath}${banner.bannerurl}" alt="${banner.banneralt}"></a>	
								</li>
							</c:forEach>
						</ul>
						<div class="btn_page spr_mix">
							<button type="button" class="prev" data-wrapper="prev">이전보기</button>
							<button type="button" class="next" data-wrapper="next">다음보기</button>
						</div>
					</div>
				</div>				
				<ul class="icon-menus">
				<li class="my-shopping-more">
					<a href="${pageContext.request.contextPath}/purchase/list">
						<span class="my-shopping-icon">&nbsp;</span>
						<span class="my-shopping-title">마이쇼핑</span>
					</a>
				</li>
				<li class="cart-more">
					<a href="${pageContext.request.contextPath}/cart/main">
						<span class="cart-icon">&nbsp;</span>
						<span class="cart-title">장바구니</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
	<div class="gnb_wrap">
		<div class="inner">
			<div class="category_inner">
				<div class="gnb">
					<ul>
						<li><a href="${pageContext.request.contextPath}/commerce/best/main" class="t_bold">베스트</a></li>
					</ul>
				</div>
				<div class="all_category_wrap">
					<a href="javascript:void(0)" class="all_category_open">
						<span>전체 카테고리</span>
					</a>
					<div class="category_list_wrap">
						<ul>
							<c:forEach var="category" items="${categories}">
								<li class="m_category">
									<a href="${pageContext.request.contextPath}/category/group/list?category1=${category.classify}">
										<strong class="category_title">
											<span class="thum category_${category.classify}"></span>
											<span class="m_title">${category.cname}</span>
										</strong>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
