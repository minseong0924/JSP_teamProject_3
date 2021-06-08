<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영 시간표</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script>
	function changeImg(img) {
		document.getElementById("img").src = "../upload"+img;
	}
</script>

</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div class="timetable-container">
		<div class="movie-choise-area">
			<ul>
				<li><a href="#" title="영화별 선택" class="btn"><span>영화별</span></a></li>
				<li><a href="#" title="극장별 선택" class="btn"><span>극장별</span></a></li>
			</ul>
		</div>
		
		<c:set var="list" value="${List }"/>
		<div class="movie-choise">
		<br><br>
			<ul>
				<c:forEach items="${List }" var="dto">
				<li>
					<button type="button" class="btn" onclick="changeImg(${dto.getPoster()})">${dto.getTitle_ko() }
					</button>
				</li>
				</c:forEach>
			</ul>
		</div>
		
		<div class="movieposter">
			<img id="img" src="<%=request.getContextPath() %>/upload/${list[0].getPoster() }" height="300px" >
		</div>
	
	
	
	
	</div>	
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>