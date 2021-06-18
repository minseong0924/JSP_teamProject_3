<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSANG YOUNG BOX</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<jsp:include page="include/mheader.jsp" />
	<br><br><br>
	<div align="center" class="main_body_title">
		박스오피스
	</div>
	<div class="search">
		<a href="<%=request.getContextPath() %>/movieChart.do">더 많은 영화보기</a>
	</div>
	<br><br>
	
	<div class="main_body_box">
		<div class="box_movie">
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list}">
			<table class="table table-striped">
				<tr>
				<c:forEach begin="0" end="3" step="1" items="${list }" var="dto">
					<td><img src="upload/${dto.getPoster() }" alt="이미지가없습니다"
						width="150" height="300"><br>
					<button onclick="location.href='booking.do?moviecode=${dto.getMoviecode()}'">예매</button></td>
				</c:forEach>
				</tr>
			</table>
			</c:if>
			
			<c:if test="${empty list }">
				..
			</c:if>		
		</div>
		<br>
		<form method="post" action="<%=request.getContextPath() %>/movieSearch2.do">
		<div class="main_body_box">
			<table>
				<tr>
					<td><input name="search_name" placeholder="영화명을 입력해 주세요">
						<input type="submit" value="검색">
					</td>
					<td>
						<input type="button" value="상영시간표" onclick="location.href='timeTable.do'"></td>
					<td>
						<input type="button" value="영화차트" onclick="location.href='movieChart.do'"></td>
					<td>
						<input type="button" value="빠른예매" onclick="location.href='booking.do'"></td>
				</tr>
			</table>
		</div>
		</form>
	</div>
	<jsp:include page="include/mfooter.jsp" />
</body>
</html>