<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	var select_person = 0;
	
	// 인원 선택 (4명까지)
	function selectPerson(inputbox) {
		var adultsel = Number($("#adult").val());
		var juniorsel = Number($("#junior").val());
		var seniorsel = Number($("#senior").val());
		var total_person = adultsel + juniorsel + seniorsel;
		select_person = total_person;

		console.log(inputbox);
		
		if((total_person) > 4) {
			alert("인원선택은 총 4명까지 가능합니다.");
			inputbox.value = (inputbox.value-1);
			select_person = select_person-1;
			return;
		}
		
		var addHtml = "선택좌석"
		addHtml += "<div>"
		for(var i=0; i<select_person; i++ ) {
			addHtml += "<p>■</p>"
		}
		addHtml += "</div>"
		
		$("#seat_select").html(addHtml);
	}
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<form class="form-inline">
		<div class="form-group" align="center" style="float: left; min-width: 700px;">
			<table width="700">
				<tr>
					<td align="left">관람인원선택</td>
					<td align="right"><button type="button" id="reset" class="btn btn-default">초기화</button></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<div align="center" class="booking_person col-xs-2" style="float: left; width: auto;">
							  성인 <input style="width:60px; height:30px;" onchange="selectPerson(this)"
							  	type="number" id="adult" class="form-control" value="0" max="4" min="0">&nbsp;&nbsp;
							  청소년 <input style="width:60px; height:30px;" onchange="selectPerson(this)"
							  	type="number" id="junior" class="form-control" value="0" max="4" min="0">&nbsp;&nbsp;
							  우대 <input style="width:60px; height:30px;" onchange="selectPerson(this)"
							  	type="number" id="senior" class="form-control" value="0" max="4" min="0">
					   </div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						좌석정보..
					</td>
				</tr>
			</table>
		</div>
		
		<div align="center" style="float: left; width: 300px;">
			<table>
				<tr>
				 <td colspan="2">
				 	<p>${sdto.moviename }</p>
				 	<p>${sdto.mtype }</p>
				 </td>
				</tr>
				<tr>
				 <td>${sdto.cinemaname }<br>${sdto.cincode }관<br>
				 	${sdto.start_date }<br>
			 		<span id="start_time">
	               		<fmt:parseNumber value="${(sdto.start_time / 60) }" integerOnly="true" />:
	               		<fmt:parseNumber value="${(sdto.start_time % 60) }" integerOnly="true" />~
	               	</span>
	               	<span id="end_time">
	               		<c:if test="${sdto.end_time >= 1440}">
	               			<fmt:parseNumber value="${((sdto.end_time- 1440) / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<c:if test="${sdto.end_time < 1440}">
	               			<fmt:parseNumber value="${(sdto.end_time / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<fmt:parseNumber value="${(sdto.end_time % 60) }" integerOnly="true" />
	               	</span>
				 </td>
				 <td>
				 	<img id="s_poster" src="<%=request.getContextPath() %>/upload/${sdto.poster }"
				 		width="60px" height="80px" >
				 </td>
				</tr>
				<tr>
				 <td>예매완료<br>예매가능</td>
				 <td id="seat_select" style="height: 170px;">선택좌석</td>
				</tr>
				<tr>
				 <td colspan="2">
				 	<p id="person_select">성인 </p>
				 	<p id="total_price">최종 결제 금액 : 0원</p>
				 </td>
				</tr>
				<tr>
				 <td><button type="button" id="before" class="btn btn-default btn-block">이전</button></td>
				 <td><button type="button" id="next" class="btn btn-primary btn-block">다음</button></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>