<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빠른 예매</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	//지역 선택시 지점 출력
	function selectLocal(cinemalist) {
		
	}
</script>

</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div align="center">
		<table class="table">
			<tr>
				<td>9 오늘</td>
				<td>10 내일</td>
				<td>11 금</td>
				<td>12 토</td>
			</tr>
		</table>
		<table class="table">
			<tr>
				<td>
					<div class="booking_list panel panel-default" align="left">
					  <div class="panel-heading">영화</div>
					  <div class="list-group">
					  	<c:if test="${!empty movielist }">
		                   <c:forEach items="${movielist }" var="mdto">
		                      <a href="#" class="list-group-item">${mdto.title_ko }</a>
		                   </c:forEach>
		                </c:if>
					  </div>
					</div>
				</td>
				<td>
					<div class="booking_list panel panel-default" align="left">
					  <div class="panel-heading">극장</div>
					  <div class="list-group">
					  	<c:if test="${!empty locallist }">
		                   <c:forEach items="${locallist }" var="ldto">
		                      <a href="#" class="list-group-item">${ldto.localname }</a>
		                   </c:forEach>
		                </c:if>
					  </div>
					</div>
				</td>
				<td>
					<div class="booking_list panel panel-default" align="left">
					  <div id="cinlist" class="list-group">
		                <c:if test="${!empty cinemalist }">
		                   <c:forEach items="${cinemalist }" var="cdto">
		                      <a href="#" class="list-group-item">${cdto.cinemaname }</a>
		                   </c:forEach>
		                </c:if>
					  </div>
					</div>
				</td>
				
				<td>
					<div class="booking_list panel panel-default">
					  <div class="panel-heading" align="left">시간</div>
					  <div class="list-group">
					    영화와 극장을 선택하시면 상영시간표를 비교하여 볼 수 있습니다.
					  </div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>