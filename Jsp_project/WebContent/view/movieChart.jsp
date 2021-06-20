<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
		int count = (int)request.getAttribute("count");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 영화 차트</title>
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
	<form method="post" action="<%=request.getContextPath() %>/movieSearch2.do">
		<div class="search_div">
			<div class="chart_a_div">
				<a style="padding-right: 5%; border-right: 1px solid #fff;" class="nav_a_color" href="<%=request.getContextPath()%>/movieChart.do">현재 상영작 </a>
				<a style="padding-left: 5%;" class="nav_a_color" href="<%=request.getContextPath()%>/comingsoonChart.do"> 상영 예정작</a>
			</div>
			<div class="chart_input_div">
				<input class="bottom_input" name="search_name" placeholder="영화명을 입력해 주세요">
				<input class="bottom_btn" type="submit" value="&#xf002;">
			</div>
		</div>
	</form>
<!-- 		<div class="main_body_box"> -->
			<div class="chart_table_bg">
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list}">
<!-- 			<table class="table table-striped"> -->
				<table>
				<% for(int i=0; i<count; i++) { %>
				<tr>
				<c:forEach begin="<%=(i*4) %>" end="<%=(i*4)+3 %>" step="1" items="${list }" var="dto">
					<td>
					<div class="movie-list-info">
							<div id="${dto.getMoviecode() }" class="movie-list">
							<img src="upload/${dto.getPoster() }" alt="이미지가없습니다"
								width="200" height="300" style="border-radius: 10px;">
							</div>
							<div class="summary ${dto.getMoviecode() }">
								<a href="movieContent.do?moviecode=${dto.getMoviecode() }" style="opacity:1;"
								title="${dto.getTitle_ko() } 상세보기">
								${fn:substring(dto.getSummary(),0,200) }…</a>
							</div>
					</div>
					
					<div class="title-area">
						${dto.getTitle_ko() }
					<br>
						예매율 : ${dto.getRate()}
					<br>
					<button class="btn btn-dark btn_bg" onclick="location.href='movieQuickBooking.do?moviecode=${dto.getMoviecode()}'">예매</button>
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