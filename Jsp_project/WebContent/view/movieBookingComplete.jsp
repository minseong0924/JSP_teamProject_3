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
	<div class="com_all_div" align="center">
		<div class="pay_title_div">예매 번호 : ${booking.bookingcode }</div>
		<div align="center" class="pay_table_div">
			<table>
				<tr><td rowspan="9">
						<img src="<%=request.getContextPath() %>/upload/${screen.poster }"
				 		class="pay_img" >
					</td>
					<td class="pay_td"><b>영화&nbsp;&nbsp;&nbsp;</b>${booking.title_ko }(${screen.mtype })</td>
				</tr>
				<tr>
					<td class="pay_td"><b>관람가&nbsp;&nbsp;&nbsp;</b>${screen.age }</td>
				</tr>
				<tr>
					<td class="pay_td">
					    <b>일시&nbsp;&nbsp;&nbsp;</b> 
					    ${booking.start_date },&nbsp;${booking.start_time } ~ 
					    ${booking.end_date },&nbsp;${booking.end_time }
	               	</td>
				</tr>
				<tr>
					<td class="pay_td"><b>극장&nbsp;&nbsp;&nbsp;</b>${booking.cinemaname } │ ${booking.cincode }관</td>
				</tr>
				<tr>
					<td>
						<b>좌석&nbsp;&nbsp;&nbsp;</b>  
						<c:set var="seat" value="${fn:split(booking.seat_no ,'/')}" />
						<c:forEach var="seatno" items="${seat}" varStatus="i">
							${seatno} 번 좌석 │
						     <%--<c:if test="${i.count == 2}">${seatno}</c:if>
						     <c:if test="${i.last}">-${seatno}</c:if>  --%>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td class="pay_total_td" style="text-align: right;">
						총 결제 금액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />원
					</td>
				</tr>
				<tr>
					<td>
						<b>결제수단&nbsp;&nbsp;&nbsp;</b> ${booking.credit }
					</td>
				</tr>
			</table>
		</div>
		<p class="com_end_div">예매가 성공적으로 완료되었습니다!</p>
	</div>
	<div class="bottom_box2">
			<div class="center_line">
				<a href="javascript:goMain()">
					<i class='glyphicon glyphicon-home'></i><span>&nbsp;&nbsp;메인으로</span></a>
			</div>
			<div class="center_line">
				<a href="javascript:resetBooking('${booking.bookingcode }', '${booking.id }')">
					<i class='glyphicon glyphicon-eye-close'></i><span>&nbsp;&nbsp;예매 취소</span></a>
			</div>
			<div class="right_line">
				<a href="javascript:goMypage('${booking.id}')">
					<i class='glyphicon glyphicon-barcode'></i><span>&nbsp;&nbsp;나의 예매내역 확인</span></a>
			</div>
	</div>
</body>
</html>