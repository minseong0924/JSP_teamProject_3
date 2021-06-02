<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.movieList {
	text-align: left;
	margin-left: 500px;
}

.search {
	text-align: right;
	margin-right: 500px;
}

td {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div align="center">
		<div class="movieList">
			<h2>영화 목록</h2>
			<br>
			<br>
		</div>
		<form method="post"
			action="<%=request.getContextPath()%>/movieSearch.do">
			<div class="search">
				<select name="search_field">
					<option value="movie_name">영화 제목</option>
					<option value="movie_state">상태</option>
				</select> 
					<input name="search_name" value="검색할 내용을 입력하세요"
							onFocus="this.value=''"> 
					<input type="submit" value="검색">
			</div>
		</form>
		<br>
		<br>
		<br>

		<table border="1" cellspacing="0" width="900">
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
						<td>${dto.getMname() }</td>
						<td>${dto.getMstate() }</td>
						<td><input type="button" value="관리"
							onclick="location.href='moiveManage.do?movieCode=${dto.getMovieCode()}'"></td>
						<td><input type="button" value="수정"
							onclick="location.href='movieEdit.do?movieCode=${dto.getMovieCode()}'"></td>
						<td><input type="button" value="삭제"
							onclick="location.href='movieDelete.do?movieCode=${dto.getMovieCode()}'"></td>
					</tr>
				</c:forEach>
			</c:if>

			<c:if test="${empty List}">
				<tr>
					<td colspan="5" align="center">검색된 데이터가 없습니다.</td>
			</c:if>
		</table>
		<br><br>
		<div class="search">
			<input type="button" value="등록"
				onclick="location.href='movieWrite.jsp'">
		</div>
			<c:if test="${page > block }">
				<a href="board_search.do?page=1&search_field=${search_field }&search_name=${search_name }">[맨처음]</a>
				<a href="board_search.do?page=${startBlock - 1 }&search_field=${search_field }&search_name=${search_name }">◀</a>
			</c:if>

			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
				<c:if test="${i == page }">
					<b><a
						href="board_search.do?page=${i }&search_field=${search_field }&search_name=${search_name }">[${i }]</a></b>
				</c:if>

				<c:if test="${i != page }">
					<a
						href="board_search.do?page=${i }&search_field=${search_field }&search_name=${search_name }">[${i }]</a>
				</c:if>
			</c:forEach>

			<c:if test="${endBlock < allPage }">
				<a href="board_search.do?page=${endBlock + 1 }&search_field=${search_field }&search_name=${search_name }">▶</a>
				<a href="board_search.do?page=${allPage }&search_field=${search_field }&search_name=${search_name }">[마지막]</a>
			</c:if>
		</div>
		<jsp:include page="../include/mfooter.jsp" />
</body>
</html>