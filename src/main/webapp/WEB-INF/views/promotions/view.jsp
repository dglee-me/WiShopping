<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
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
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>