<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/header_js.js" async></script>

<div class="header">
	<div class="inner_top_wrap">
		<div class="mix_inner top_bar">
			<h2 class="hide">유틸메뉴</h2>
			<ul class="top_bar_util">
				<li><a href="javascript:void(0);" onclick="bookmarksite(); return false;">즐겨찾기</a></li>
				<li><a href="/myapp/promotions/main">기획전</a></li>
			</ul>
			<h2 class="hide">로그인메뉴</h2>
			<ul class="top_bar_login">
				<c:if test="${login.name eq null}">
					<li><a href="${pageContext.request.contextPath }/auth/login">로그인</a></li>
					<li><a href="${pageContext.request.contextPath }/auth/join">회원가입</a></li>
					<li><a href="${pageContext.request.contextPath }/notice/list">고객센터</a></li>
				</c:if>
				<c:if test="${login.name ne null }">
					<li><c:out value="${login.name }"/>님, <a href="<%=request.getContextPath() %>/auth/logout">로그아웃</a></li>
					<li><a href="${pageContext.request.contextPath }/notice/list">고객센터</a></li>
				</c:if>
			</ul>
		</div>
		<div class="mix_inner mix_search_wrap">
				<h1 class="logo"><a href="${pageContext.request.contextPath}/">위쇼핑</a></h1>
				<div class="search_form">
					<form>
						<div class="search_bar">
							<input type="text" class="ui_input_text" maxlength="50" title="검색어 입력" placeholder="찾고 싶은 상품을 검색해보세요!">
						</div>
						<span class="btn_search">
							<button type="button" id="_searchBtn" onclick="location.href='#'">검색</button>
						</span>
					</form>	
				</div>
				<div class="mix_banner">
					<div class="wrap_ad">
						<ul class="list_ad">
							<li><a href="#"><img src="/myapp/resources/image/mix_banner_no_interest.png"></a></li>
						</ul>
						<div class="btn_page spr_mix">
							<button type="button" class="prev" data-wrapper="prev">이전보기</button>
							<button type="button" class="next" data-wrapper="next">다음보기</button>
						</div>
					</div>
				</div>				
				<ul class="icon-menus">
				<li class="my-shopping-more">
					<a href="./purchase/list">
						<span class="my-shopping-icon">&nbsp;</span>
						<span class="my-shopping-title">마이쇼핑</span>
					</a>
				</li>
				<li class="cart-more">
					<a href="#">
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
						<li><a href="#" class="t_bold">베스트</a></li>
						<li><a href="#" class="t_bold">특가</a></li>
					</ul>
				</div>
				<div class="all_category_wrap">
					<a href="javascript:void(0)" class="all_category_open">
						<span>전체 카테고리</span>
					</a>
					<div class="category_list_wrap">
						<ul>
							<li class="m_category">
								<a href="${pageContext.request.contextPath }/category/group/fashion">
									<strong class="category_title">
										<span class="thum">
											<img src="${pageContext.request.contextPath }/resources/image/fashion.png" alt="패션">
										</span>
										<span class="m_title">패션</span>
									</strong>
								</a>
							</li>
							<li class="m_category">
								<a href="${pageContext.request.contextPath }/category/group/2">
									<strong class="category_title">
										<span class="thum">
											<img src="${pageContext.request.contextPath }/resources/image/accessories.png" alt="잡화">
										</span>
										<span class="m_title">잡화</span>
									</strong>
								</a>
							</li>
							<li class="m_category">
								<a href="${pageContext.request.contextPath }/category/group/3">
									<strong class="category_title">
										<span class="thum">
											<img src="${pageContext.request.contextPath }/resources/image/interior.png" alt="인테리어">
										</span>
										<span class="m_title">인테리어</span>
									</strong>
								</a>
							</li>
							<li class="m_category">
								<a href="${pageContext.request.contextPath }/category/group/4">
									<strong class="category_title">
										<span class="thum">
											<img src="${pageContext.request.contextPath }/resources/image/appliances.png" alt="가전·디지털">
										</span>
										<span class="m_title">가전·디지털</span>
									</strong>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
