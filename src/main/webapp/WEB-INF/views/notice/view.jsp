<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeView.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">

<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>고객센터</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="container_inner">
		<div class="contents">
			<div class="content-main">
				<div class="board">
					<h3 class="title_notice">공지사항</h3>
					<div class="wrap_tbl wrap_view">
						<table class="view">
							<colgroup>
								<col width="122">
								<col width="592">
								<col width="211">
							</colgroup>
							<thead>
								<tr>
									<th>
										번호
										<span class="num">${view.bno }</span>
									</th>
									<th class="fst">${view.subject }</th>
									<th class="timeAndread">
										날짜
										<span class="num">${view.writedate }</span>
										<span class="txt_bar">|</span>
										조회수
										<span class="num">${view.readcount}</span>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="3">
										<div class="tbody">${view.content}</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="view_button">
					<p class="view_left">
						<span class="btn btn_prev">
							<a href="#">
								<button type="button" class="btn_button">이전글</button>
							</a>
						</span>
						<span class="btn btn_next">
							<a href="#">
								<button type="button" class="btn_button">다음글</button>
							</a>
						</span>
					</p>
					<p class="view_right">
						<span class="btn btn_modify">
							<a href="${pageContext.request.contextPath }/notice/modify?bno=${view.bno}">
								<button type="button" class="btn_button">수정하기</button>
							</a>
						</span>
						<span class="btn btn_list">
							<a href="${pageContext.request.contextPath }/notice/list">
								<button type="button" class="btn_button">목록보기</button>
							</a>
						</span>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>