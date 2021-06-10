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
<title>지점 관리</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div align="center">
		<div class="title">
			<h2>지점 목록</h2>
			<br>
			<br>
		</div>
		<form method="post"
			action="<%=request.getContextPath() %>/cinemaSearch.do">
			<div class="search">
				<select name="local_code" required>
					<c:if test="${empty locallist }">
						<option value="">:::저장된 지역 없음:::</option>
					</c:if>
	
					<c:if test="${!empty locallist }">
						<c:forEach items="${locallist }" var="ldto">
							<option value="${ldto.localcode }">${ldto.localname }</option>
						</c:forEach>
					</c:if>
				</select>
				&nbsp;&nbsp;
				<input type="submit" value="검색">
			</div>
		</form>
		<br>
		<br>
		<br>
		<div style="width:900px;" align="center">
			<table class="table table-striped table-hover">
				<tr>
					<th>지점이름</th>
					<th>주소</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>

				<c:set var="list" value="${List }" />
				<c:if test="${!empty List}">
					<c:forEach items="${List }" var="dto">
						<tr>
							<td>${dto.getCinemaname() }</td>
							<td>${dto.getAddress() }</td>
							<td><input type="button" value="수정"
								onclick="location.href='cinemaEdit.do?cinemaCode=${dto.getCinemacode()}'"></td>
							<td><input type="button" value="삭제"
								onclick="if(confirm('정말 삭제하시겠습니까?')){location.href='cinemaDelete.do?cinemaCode=${dto.getCinemacode()}'}
										else{return false}"></td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${empty List}">
					<tr>
						<td colspan="4" align="center">검색된 데이터가 없습니다.</td>
				</c:if>
			</table>
		</div>
		
		<br><br>
		<div class="search">
			<input type="button" value="지점등록"
				onclick="location.href='<%=request.getContextPath()%>/cinemaWrite.do'">
		</div>
		
		<c:if test="${page > block }">
			<a href="cinemaSearch.do?page=1&local_code=${local_code }">[맨처음]</a>
			<a href="cinemaSearch.do?page=${startBlock - 1 }&local_code=${local_code }">◀</a>
		</c:if>

		<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			<c:if test="${i == page }">
				<b><a href="cinemaSearch.do?page=${i }&local_code=${local_code }">[${i }]</a></b>
			</c:if>

			<c:if test="${i != page }">
				<a href="cinemaSearch.do?page=${i }&local_code=${local_code }">[${i }]</a>
			</c:if>
		</c:forEach>

		<c:if test="${endBlock < allPage }">
			<a href="cinemaSearch.do?page=${endBlock + 1 }&local_code=${local_code }">▶</a>
			<a href="cinemaSearch.do?page=${allPage }&local_code=${local_code }">[마지막]</a>
		</c:if>

	</div>
	<jsp:include page="../include/mfooter.jsp" />
	
</body>
</html>