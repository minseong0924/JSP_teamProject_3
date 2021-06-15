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
<title>영화 차트</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>

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
							<div id="${dto.getTitle_ko() }" class="movie-list">
							<img src="upload/${dto.getPoster() }" alt="이미지가없습니다"
								width="200" height="300">
							</div>
							<div class="summary ${dto.getTitle_ko() }">
								<a href="movieContent.do?moviecode=${dto.getMoviecode() }" style="opacity:1;">
								${dto.getSummary() }</a>
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
<script>
$(document).ready(function() {
	$(".summary").hide();
});
$(".movie-list").hover(function(){
	var id = $(this).attr("id");
	$("."+id).show();
	$(this).css('opacity','0.1');
});
$("td").mouseenter(function() {
	$(".summary").hide();
	$(".movie-list").css('opacity','1');
});


/* $(".movie-list").mouseenter(function(){
	var id = $(this).attr("id");
	$("."+id).show();
	$(this).css('opacity','0.1');
	
})
.mouseleave(function() {
	$(".summary").hide();
	$(this).css('opacity','1');
}); */

</script>
</html>