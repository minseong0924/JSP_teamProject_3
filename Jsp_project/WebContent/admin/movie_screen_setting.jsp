<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script type="text/javascript">

	$(document).ready(function(){
	    $('input.timepicker').timepicker({
	    	timeFormat: 'HH:mm',
		    interval: 30,
		    startTime: '00:00',
		    dynamic: false,
		    dropdown: true,
		    scrollbar: true
	    });
	});
</script>
</head>

<body>
	<jsp:include page="../include/mheader.jsp" />
	
	<!-- 새로운 상영 영화 추가 -->
	<div class="container"> 
	<p>영화 상영 추가</p>
	<form method="post" action="<%=request.getContextPath() %>/screen_insert.do">
		<table class="table table-hover"> 
			<thead>
				<tr> 
					<th>영화명(코드)</th> 
					<th>상영 지점</th> 
					<th>상영관</th> 
					<th>상영시간(시작 시간)</th> 
					<th>추가</th>
				</tr> 
			</thead> 
			<tbody>
				<tr> 
					<td>
						<select name="movie_code">
		                  <c:if test="${empty movielist }">
		                     <option value="">:::저장된 영화 없음:::</option>
		                  </c:if>
		                  
		                  <c:if test="${!empty movielist }">
		                     <c:forEach items="${movielist }" var="mdto">
		                        <option value="${mdto.moviecode }">${mdto.title_ko } [${mdto.moviecode }]</option>
		                     </c:forEach>
		                  </c:if>
		               </select>
	               	</td>
	               	
	               	<td>
						<select name="cinema_code">
		                  <c:if test="${empty cinemalist }">
		                     <option value="">:::상영 지점 없음:::</option>
		                  </c:if>
		                  
		                  <c:if test="${!empty cinemalist }">
		                     <c:forEach items="${cinemalist }" var="cdto">
		                        <option value="${cdto.cinemacode }">${cdto.cinemaname } [${cdto.cinemacode }]</option>
		                     </c:forEach>
		                  </c:if>
		               </select>
	               	</td>
	               	
	               	<td>
						<select name="cinema_cin_code">
		                  <c:if test="${empty cinema_cin_list }">
		                     <option value="">:::상영관 없음:::</option>
		                  </c:if>
		                  
		                  <c:if test="${!empty cinema_cin_list }">
		                     <c:forEach items="${cinema_cin_list }" var="movie_list">
		                        <option value="${cinema_cin_list.code }">${cinema_cin_list.name }</option>
		                     </c:forEach>
		                  </c:if>
		               </select>
	               	</td>
	               	
	               	<td>
	               		<input type="time" class="timepicker" name="start_time">
	               	</td>
	               	
	               	<td>
	               		<input type="submit" value="추가">
	               	</td>
	               	 
				</tr> 
	
			</tbody>
		</table>
	</form>
	</div>
	
	<br><br>
	
	<!-- 현재 상영 설정된 영화 목록 -->
	<div class="container"> 
	<p>영화 상영 목록</p>
		<table class="table"> 
			<thead>
				<tr>
					<th>상영코드</th>
					<th>영화명(코드)</th> 
					<th>상영 지점</th> 
					<th>상영관</th> 
					<th>상영 시작 시간</th> 
					<th>상영 종료 시간</th> 
					<th>수정</th>
					<th>삭제</th>
				</tr> 
			</thead> 
			<tbody>
				<c:forEach items="${screen_list }" var="screen">
					<tr> 
						<td> ${screen.code } </td>
						<td>
							<select name="movie_code">
			                  <c:if test="${empty movie_list }">
			                     <option value="">:::저장된 영화 없음:::</option>
			                  </c:if>
			                  
			                  <c:if test="${!empty movie_list }">
			                     <c:forEach items="${movie_list }" var="movie_list">
			                        <option value="${movie_list.code }">${movie_list.name } [${movie_list.code }]</option>
			                     </c:forEach>
			                  </c:if>
			               </select>
		               	</td>
		               	
		               	<td>
							<select name="cinema_code">
			                  <c:if test="${empty cinema_list }">
			                     <option value="">:::상영 지점 없음:::</option>
			                  </c:if>
			                  
			                  <c:if test="${!empty cinema_list }">
			                     <c:forEach items="${cinema_list }" var="movie_list">
			                        <option value="${cinema_list.code }">${cinema_list.name } [${cinema_list.code }]</option>
			                     </c:forEach>
			                  </c:if>
			               </select>
		               	</td>
		               	
		               	<td>
							<select name="cinema_cin_code">
			                  <c:if test="${empty cinema_cin_list }">
			                     <option value="">:::상영관 없음:::</option>
			                  </c:if>
			                  
			                  <c:if test="${!empty cinema_cin_list }">
			                     <c:forEach items="${cinema_cin_list }" var="movie_list">
			                        <option value="${cinema_cin_list.code }">${cinema_cin_list.name }</option>
			                     </c:forEach>
			                  </c:if>
			               </select>
		               	</td>
		               	
		               	<td>
		               		<input type="time" class="timepicker" name="start_time">
		               	</td>
		               	
		               	<td>
		               		<input type="time" class="timepicker" name="end_time">
		               	</td>
		               	
		               	<td>
		               		<input type="button" value="수정" onclick="screen_modify()">
		               	</td>
		               	
		               	<td>
		               		<input type="button" value="삭제" onclick="screen_delete()">
		               	</td>
					</tr> 
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	
</body>
</html>