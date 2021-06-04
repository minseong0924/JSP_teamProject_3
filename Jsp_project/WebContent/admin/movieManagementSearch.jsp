<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%	
	Object list = request.getAttribute("List");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 관리</title>
<link rel="stylesheet" href="./css/style.css">
<script>

</script>

</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div align="center">
		<div class="title">
			<h2>영화 목록</h2>
			<br>
			<br>
		</div>
		<form method="post"
			action="<%=request.getContextPath()%>/movieSearch.do">
			<div class="search">
				<select name="search_field">
					<option value="movie_name">영화 제목(한글)</option>
					<option value="movie_state">상태</option>
				</select> 
					<input name="search_name" placeholder="내용을 입력하세요"> 
					<input type="submit" value="검색">
			</div>
		</form>
		<br>
		<br>
		<br>
		<div style="width:900px;" align="center">
		<table class="table table-striped table-hover">
			<tr>
				<th>영화제목</th>
				<th>상태</th>
				<th>상영설정</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			
			<c:set var="list" value="${List }" />
			<c:if test="${!empty List}">
				<c:forEach items="${List }" var="dto">
					<tr>
						<td>${dto.getTitle_ko() }</td>
						<td>${dto.getMstate() }</td>
						<td><input type="button" value="관리"
							onclick="location.href='moiveManage.do?movieCode=${dto.getMoviecode()}'"></td>
						<td><input type="button" value="수정"
							onclick="location.href='movieEdit.do?movieCode=${dto.getMoviecode()}'"></td>
						<td><input type="button" value="삭제"
							onclick="if(confirm('정말 삭제하시겠습니까?')){location.href='movieDelete.do?movieCode=${dto.getMoviecode()}'}
										else{return false}"></td>
					</tr>
				</c:forEach>
			</c:if>

			<c:if test="${empty List}">
				<tr>
					<td colspan="5" align="center">검색된 데이터가 없습니다.</td>
			</c:if>
		</table>
		</div>
		
		<br><br>
		<div class="search">
			<input type="button" value="영화등록"
				onclick="location.href='<%=request.getContextPath()%>/movieWrite.do'">
		</div>
			<c:if test="${page > block }">
				<a href="movieSearch.do?page=1&search_field=${search_field }&search_name=${search_name }">[맨처음]</a>
				<a href="movieSearch.do?page=${startBlock - 1 }&search_field=${search_field }&search_name=${search_name }">◀</a>
			</c:if>

			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
				<c:if test="${i == page }">
					<b><a href="movieSearch.do?page=${i }&search_field=${search_field }&search_name=${search_name }">[${i }]</a></b>
				</c:if>

				<c:if test="${i != page }">
					<a
						href="movieSearch.do?page=${i }&search_field=${search_field }&search_name=${search_name }">[${i }]</a>
				</c:if>
			</c:forEach>

			<c:if test="${endBlock < allPage }">
				<a href="movieSearch.do?page=${endBlock + 1 }&search_field=${search_field }&search_name=${search_name }">▶</a>
				<a href="movieSearch.do?page=${allPage }&search_field=${search_field }&search_name=${search_name }">[마지막]</a>
			</c:if>
		</div>
		<jsp:include page="../include/mfooter.jsp" />
</body>
</html>