<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">

<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>고객센터</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="container">
		<div class="contents">
			<h2 class="title_main">고객센터</h2>
			<ul class="tab_cs">
				<li class="notice_li">
					<a class="tab1 on" href="${pageContext.request.contextPath}/notice/list">공지사항</a>
				</li>
				<li class="faq_li">
					<a class="tab2" href="${pageContext.request.contextPath }/service/faq">자주 묻는 질문</a>
				</li>
				<li class="proposal_li">
					<a class="tab3" href="${pageContext.request.contextPath }/service/proposal">제안하기</a>
				</li>
				<li class="inquiry">
					<a class="tab4" href="${pageContext.request.contextPath }/service/qna">1:1문의</a>
				</li>
			</ul>
			<div id="board">
				<h3 class="title_notice">공지사항</h3>
				<div class="wrap_tbl notice_list">
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
								<tr class="on">
									<td>${notice.bno}</td>
									<td><a href="${pageContext.request.contextPath }/notice/view?bno=${notice.bno}">${notice.subject}</a></td>
									<td>${notice.writedate}</td>
									<td>${notice.readcount}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="write_btn">
					<div class="fr">
						<c:if test="${login.mlevel eq 1}">
							<a href="${pageContext.request.contextPath }/admin/write" class="btn_type1 post_write">글쓰기</a>
						</c:if>
						<c:if test="${login.mlevel ne 1}">
						</c:if>
					</div>
				</div>
				<div class="notice_paging">
				    <ul class="inner_paging">
				       <li><a href="${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
				  
				      <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				       <li><a href="${pageMaker.makeQuery(idx)}">${idx}</a></li>
				      </c:forEach>
				  
				       <li><a href="${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
				    </ul>
		  		</div>
			</div>
		</div>
				
	</div>
</body>
</html>