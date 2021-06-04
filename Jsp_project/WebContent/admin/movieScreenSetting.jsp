<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">

	// 영화 변경시 러닝타임 변경
	function movieSelect(selectValue){ 
		var runningSelect = document.getElementById("running_time");
		var runningTimeStr = selectValue.split(":");
		
		runningSelect.innerHTML = runningTimeStr[1]+"분";
		console.log(runningTimeStr[1]+"분");
	}

	// 지점 변경시 상영관 변경
	function cinemaSelect(selectValue){ 

		var cinSelect = document.getElementById("cinema_cin");
		$("#cinema_cin").children('option').remove();
		
		console.log("선택 값 - "+selectValue);
		
		var cin_code = selectValue.split(":");
		console.log("첫번째 관 - "+cin_code[1]);
		
		var otxt = "";

		for(var i=1;i<=6;i++) {
			if(cin_code[i] == 1)
			otxt += '<option value="'+i+'">'+i+'관 </option>';
		}
		
		console.log(otxt);
		cinSelect.innerHTML= otxt;
		
	}

</script>

</head>

<body>
	<jsp:include page="../include/mheader.jsp" />
	
	<!-- 새로운 상영 영화 추가 -->
	<div class="container"> 
	<p>영화 상영 추가</p>
	<form method="post" action="<%=request.getContextPath() %>/movieScreenInsert.do">
		<table class="table table-hover"> 
			<thead>
				<tr> 
					<th>영화명(코드)</th> 
					<th>러닝 타임</th> 
					<th>상영 지점</th> 
					<th>상영관</th> 
					<th>상영시간(시작 시간)</th> 
					<th>추가</th>
				</tr> 
			</thead> 
			<tbody>
				<tr> 
					<td>
						<select id="select_movie" name="movie_code" onchange="movieSelect(this.value)">
		                  <c:if test="${empty movielist }">
		                     <option value="">:::저장된 영화 없음:::</option>
		                  </c:if>
		                  
		                  <c:if test="${!empty movielist }">
		                     <c:forEach items="${movielist }" var="mdto">
		                        <option value="${mdto.moviecode }:${mdto.running_time }">${mdto.title_ko } [${mdto.moviecode }]</option>
		                     </c:forEach>
		                  </c:if>
		               </select>
	               	</td>
	               	
	               	<td id="running_time">
	               		${movielist.get(0).running_time }분
	               	</td>
	               	
	               	<td>
						<select id="select_cinema" name="cinema_code" onchange="cinemaSelect(this.value)">
		                  <c:if test="${empty cinemalist }">
		                     <option value="">:::상영 지점 없음:::</option>
		                  </c:if>
		                  
		                  <c:if test="${!empty cinemalist }">
		                     <c:forEach items="${cinemalist }" var="cdto">
		                        <option value="${cdto.cinemacode }:${cdto.one_cin }:${cdto.two_cin }:${cdto.three_cin }:${cdto.four_cin }:${cdto.five_cin }:${cdto.six_cin }">
		                        	${cdto.cinemaname } [${cdto.cinemacode }]</option>
		                     </c:forEach>
		                  </c:if>
		               </select>
	               	</td>
	               	
	               	<td>
					   <select id="cinema_cin" name="cinema_cin">
						  	<c:if test="${!empty cinemalist }">
		                     	<c:if test="${cinemalist.get(0).one_cin == 1 }">
		                        	<option value="1">1관</option>
		                        </c:if>
		                        
		                        <c:if test="${cinemalist.get(0).two_cin == 1 }">
		                        	<option value="2">2관</option>
		                        </c:if>
		                        
		                        <c:if test="${cinemalist.get(0).three_cin == 1 }">
		                        	<option value="3">3관</option>
		                        </c:if>
		                        
		                        <c:if test="${cinemalist.get(0).four_cin == 1 }">
		                        	<option value="4">4관</option>
		                        </c:if>
		                        
		                        <c:if test="${cinemalist.get(0).five_cin == 1 }">
		                        	<option value="5">5관</option>
		                        </c:if>
		                        
		                        <c:if test="${cinemalist.get(0).six_cin == 1 }">
		                        	<option value="6">6관</option>
		                        </c:if>
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
				<c:forEach items="${screenlist }" var="screen">
					<tr> 
						<td> ${screen.screencode } </td>
						<td>
		                  <c:if test="${!empty movielist }">
		                     <c:forEach items="${movielist }" var="moviedto">
		                        	<c:if test="${moviedto.moviecode == screen.moviecode }">
		                        		${moviedto.title_ko } [${moviedto.moviecode }]
		                        	</c:if>
		                     </c:forEach>
		                  </c:if>
		               	</td>
		               	
		               	<td>
		                  <c:if test="${!empty cinemalist }">
		                     <c:forEach items="${cinemalist }" var="cinemadto">
		                        	<c:if test="${cinemadto.cinemacode == screen.cinemacode }">
		                        		${cinemadto.cinemaname } [${cinemadto.cinemacode }]
		                        	</c:if>
		                     </c:forEach>
		                  </c:if>
		               	</td>
		               	
		               	<td> ${screen.cincode }관 </td>
		               	
		               	<td>
		               		<%-- <input type="time" class="timepicker" name="start_time">--%>
		               		<fmt:parseNumber value="${(screen.start_time / 60) }" integerOnly="true" />시
		               		<fmt:parseNumber value="${(screen.start_time % 60) }" integerOnly="true" />분
		               	</td>
		               	
		               	<td>
		               		<%--<input type="time" class="timepicker" name="end_time">--%>
		               		<fmt:parseNumber value="${(screen.end_time / 60) }" integerOnly="true" />시
		               		<fmt:parseNumber value="${(screen.end_time % 60) }" integerOnly="true" />분
		               	</td>
		               	
		               	<td>
		               		<input type="button" value="수정" onclick="screen_modify()">
		               	</td>
		               	
		               	<td>
		               		<a href="<%=request.getContextPath() %>/movieScreenDelete.do?screencode=${screen.screencode }"
		               			onclick="return confirm('해당 상영 정보를 삭제하시겠습니까?');">삭제 </a>
		               	</td>
					</tr> 
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	
</body>
</html>