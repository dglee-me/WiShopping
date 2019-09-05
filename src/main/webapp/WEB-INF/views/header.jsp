<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="header">
	<div class="top_bar">
		<h2 class="hide">유틸메뉴</h2>
		<ul class="top_bar_util">
			<li><a href="javascript:void(0);" onclick="bookmarksite('내쇼핑몰','localhost:8081/myapp'); return false;">즐겨찾기</a></li>
			<li><a href="/myapp/promotions/main">기획전</a></li>
		</ul>
		
		<h2 class="hide">로그인메뉴</h2>
		<ul class="top_bar_login">
			<c:if test="${member.name eq null}">
				<li><a href="/myapp/auth/login">로그인</a></li>
				<li><a href="/myapp/auth/join">회원가입</a></li>
				<li><a href="/myapp/service/cs-center">고객센터</a></li>
			</c:if>
			<c:if test="${member.name ne null }">
				<li><c:out value="${member.name }"/>님, <a href="<%=request.getContextPath() %>/auth/logout">로그아웃</a></li>
				<li><a href="/myapp/service/cs-center">고객센터</a></li>
			</c:if>
		</ul>
	</div>
	
	<div class="header_fix">
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
					<em id="cartIconCount">0</em>
				</a>
			</li>
		</ul>
	</div>
</div>