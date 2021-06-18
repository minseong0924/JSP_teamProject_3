<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 예매완료</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">

	function goMain() {
		location.href="<%=request.getContextPath()%>/main.do";
	}
	
	function goMypage(id) {
		location.href="<%=request.getContextPath() %>/myPageBooked.do?memid="+id;
	}
	
	function resetBooking(code) {
		if(confirm("정말 예매를 취소하시겠습니까?")) {
			$.ajax({
				type:"post",
				url: "/Jsp_project/movieBookingCancel.do",
				dataType: "json",
				async: false,
				data: {
						"bookingcode" : code
					  },
				success: function(data) {
					if(data > 0) {
						alert("예매가 취소되었습니다. 메인으로 돌아갑니다.")
						location.href='<%=request.getContextPath()%>/mainList.do';
					}
				},
				error: function(request,status,error){
			       alert("error!!!");
				}
			});
		}
	}

</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div align="center">
		<p><font color="purple">예매가 성공적으로 완료되었습니다!</font></p>
		<hr>
		<p>예매 번호 : ${booking.bookingcode }</p>
		<div align="center">
			<table align="center" border="0">
				<tr><td rowspan="9">
						<img src="<%=request.getContextPath() %>/upload/${screen.poster }"
				 		width="250px" height="400px" >
					</td>
					<td>영화 : ${booking.title_ko }(${screen.mtype })</td>
				</tr>
				<tr>
					<td>관람가 : ${screen.age }</td>
				</tr>
				<tr>
					<td>일시 : 
					    ${booking.start_date },&nbsp;${booking.start_time } ~ 
					    ${booking.end_date },&nbsp;${booking.end_time }
	               	</td>
				</tr>
				<tr>
					<td>극장 : ${booking.cinemaname } │ ${booking.cincode }관</td>
				</tr>
				<tr>
					<td>
						좌석 : 
						<c:set var="seat" value="${fn:split(booking.seat_no ,'/')}" />
						<c:forEach var="seatno" items="${seat}" varStatus="i">
							${seatno} 번 좌석 │
						     <%--<c:if test="${i.count == 2}">${seatno}</c:if>
						     <c:if test="${i.last}">-${seatno}</c:if>  --%>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>
						총 결제 금액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />원
					</td>
				</tr>
				<tr>
					<td>
						결제수단 : ${booking.credit }
					</td>
				</tr>
			</table>
		</div>
		<div align="center">
			<input type="button" onclick="goMain()" value="메인으로" class="btn btn-default">
			<input type="button" onclick="resetBooking('${booking.bookingcode }', '${booking.id }')" value="예매취소" class="btn btn-danger">
			<input type="button" onclick="goMypage('${booking.id}')" value="나의 예매내역 확인" class="btn btn-info">
		</div>
	</div>
</body>
</html>