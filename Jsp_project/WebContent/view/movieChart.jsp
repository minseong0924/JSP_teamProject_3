<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int count = (int)request.getAttribute("count");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<br><br>
	<div>
		<div class="title">
		<h2>영화 차트</h2>
		</div>
		<hr width="50%">
	
		<div class="search">
			<a href="<%=request.getContextPath()%>/movieChart.do">현재 상영작 </a>
			<a href="<%=request.getContextPath()%>/comingsoonChart.do"> 상영 예정작</a>
		</div>
		
		<div class="main_body_box">
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list}">
			<table class="table table-striped">
				<% for(int i=0; i<count; i++) { %>
				<tr>
				<c:forEach begin="<%=(i*4) %>" end="<%=(i*4)+3 %>" step="1" items="${list }" var="dto">
					<td>
					<div class="movie-list-info">
							<div class="movie-list">
							<img src="upload/${dto.getPoster() }" alt="이미지가없습니다"
								width="200" height="300">
							</div>
							<div class="summary">
								<a href="movieContent.do?moviecode=${dto.getMoviecode() }" style="opacity:1;">
								${dto.getSummary() }asdasdasdasdasdasdㅁㄴㅇㅈ머룽랴ㅜㄴ혀ㅑㅠ갼여휴겨ㅑ유향륳ㅇ러ㅏ휴아러
								</a>
							</div>
					</div>
					
					<div class="title-area">
						${dto.getTitle_ko() }
						<br>
					<button onclick="location.href='booking.do?moviecode=${dto.getMoviecode()}'">예매</button>
					</div>
					
					</td>
					
				</c:forEach>
				</tr>
				<%} %>
				
			</table>
			</c:if>
			
			<c:if test="${empty list }">
				..
			</c:if>
		</div>
	
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>