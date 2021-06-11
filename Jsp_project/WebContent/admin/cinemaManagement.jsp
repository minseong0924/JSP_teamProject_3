<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
					<c:set var="llist" value="${List }" />
					<c:if test="${empty llist }">
						<option value="">:::저장된 지역 없음:::</option>
					</c:if>
	
					<c:if test="${!empty llist }">
						<c:forEach items="${llist }" var="dto">
							<option value="${dto.localcode }">${dto.localname }</option>
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
				<tr>
					<td colspan="4" align="center">검색된 데이터가 없습니다.</td>
				</tr>
			</table>
		</div>
		
		<br><br>
		<div class="search">
			<input type="button" value="지점등록"
				onclick="location.href='<%=request.getContextPath()%>/cinemaWrite.do'">
		</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
	
</body>
</html>