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
<body class="main_body">
	<jsp:include page="include/mheader.jsp" />

	<div align="center" class="main_body_title title_font">
		B O X O F F I C E
	</div>

	
	<div class="main_body_box">
		<div class="box_movie">
			<div align="right" class="search">
				<a href="<%=request.getContextPath() %>/movieChart.do" class="nav_a_color">더 많은 영화보기 <i class='glyphicon glyphicon-hand-right'></i></a>
			</div>
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list}">
			<table class="table_bg">
				<tr>
				<c:forEach begin="0" end="3" step="1" items="${list }" var="dto">
					<td class="td_img"><img src="upload/${dto.getPoster() }" alt="이미지가없습니다"
						width="250" height="370"><br>
					<button onclick="location.href='movieQuickBooking.do?moviecode=${dto.getMoviecode()}'" class="btn btn-dark btn_bg">예매</button></td>
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
		<div class="bottom_box">
			<div class="left_line">
				<input class="bottom_input" name="search_name" placeholder="영화명을 입력해 주세요">
				<input class="bottom_btn" type="submit" value="&#xf002;">
			</div>
			<div class="center_line">
				<a href="<%=request.getContextPath() %>/timeTable.do"><i class='glyphicon glyphicon-list-alt'></i><span>&nbsp;&nbsp;상영시간표</span></a>
				<!-- <input type="button" value="상영시간표" onclick="location.href='timeTable.do'"> -->
			</div>
			<div class="center_line">
				<a href="<%=request.getContextPath() %>/movieChart.do"><i class='glyphicon glyphicon-film'></i><span>&nbsp;&nbsp;영화차트</span></a>
				<!-- <input type="button" value="영화차트" onclick="location.href='movieChart.do'"> -->
			</div>
			<div class="right_line">
				<a href="<%=request.getContextPath() %>/movieQuickBooking.do"><i class='glyphicon glyphicon-barcode'></i><span>&nbsp;&nbsp;빠른예매</span></a>
				<!-- <input type="button" value="빠른예매" onclick="location.href='booking.do'"> -->
			</div>
			<!-- <table class="search_bg">
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
			</table> -->
		</div>
		</form>
	</div>
	<jsp:include page="include/mfooter.jsp" />
</body>
</html>