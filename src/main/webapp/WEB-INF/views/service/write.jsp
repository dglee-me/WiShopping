<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.write_form{
		text-align:center
	}
</style>
<title>글쓰기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"/>
	<form action="write" method="POST">
		<div class="write_form">
			<input type="text" name="nickname" value="${member.name }" hidden>
			<div class="write_category_subject">
				<select name="category">
					<option value="공지사항" selected="selected">공지사항</option>
					<option value="자유게시판">자유게시판</option>
				</select>
				<input type="text" name="subject" size="100" maxlength="20" placeholder="제목을 입력하세요.">
			</div>
				<div class="wirte_textarea">
					<textarea maxlength="4000" cols="110" rows="20"required="required" placeholder="내용을 입력하세요." name="content">
					</textarea>
				</div>
			</div>
		<input type="submit" value="글쓰기">
	</form>
</body>	
</html>