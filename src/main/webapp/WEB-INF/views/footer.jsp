<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer class="home-footer">
	<div class="layout-footer_content">
		<ul class="layout-footer_shortcut">
			<c:if test="${login.mlevel ne 1}">
				<li><a class="layout-footer_shorcut-item" href="${pageContext.request.contextPath}/auth/seller_regist">판매자 등록</a></li>
			</c:if>
		</ul>
		<c:if test="${login.mlevel eq 1}">
			<p class="layout-footer_copyright">©WiShopping<a href="${pageContext.request.contextPath}/admin/main">.</a> All rights reserved.</p>
		</c:if>
		<c:if test="${login.mlevel ne 1}">
			<p class="layout-footer_copyright">©WiShopping. All rights reserved.</p>
		</c:if>
	</div>
</footer>