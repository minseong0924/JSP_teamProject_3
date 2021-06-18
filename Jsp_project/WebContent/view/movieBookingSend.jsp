<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 결제하기</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	function valueSetting() {
		var radioVal = $('.credit_rb:checked').val();
		$("#credit").val(radioVal);
	}
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div align="center">
		<div id="table_div" style="width: 700px;">
			<table cellspacing="1" border="0" width="700">
				<tr>
					<td rowspan="9">
						<img src="<%=request.getContextPath() %>/upload/${sdto.poster }"
				 		width="250px" height="400px" >
					</td>
					<td>${sdto.moviename }(${sdto.mtype })</td>
				</tr>
				<tr>
					<td>${sdto.movienameEng }</td>
				</tr>
				<tr>
					<td>${sdto.age }</td>
				</tr>
				<tr>
					<td>
					    ${sdto.start_date }&nbsp;
						<c:if test="${(sdto.start_time / 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.start_time / 60) }" integerOnly="true" />:
						<c:if test="${(sdto.start_time % 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.start_time % 60) }" integerOnly="true" />&nbsp;~
	               		<c:if test="${sdto.end_time >= 1440}">
	               			<c:if test="${((sdto.end_time-1440) / 60) < 10}">0</c:if><fmt:parseNumber value="${((sdto.end_time- 1440) / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<c:if test="${sdto.end_time < 1440}">
	               			<c:if test="${((sdto.end_time) / 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.end_time / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<c:if test="${((sdto.end_time) % 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.end_time % 60) }" integerOnly="true" />
	               	</td>
				</tr>
				<tr>
					<td>${sdto.cinemaname } │ ${sdto.cincode }관</td>
				</tr>
				<tr>
					<td>
						<c:set var="seat" value="${fn:split(select_seat,'/')}" />
						<c:forEach var="seatno" items="${seat}" varStatus="i">
							${seatno} 번 좌석<br>
						     <%--<c:if test="${i.count == 2}">${seatno}</c:if>
						     <c:if test="${i.last}">-${seatno}</c:if>  --%>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>
						<c:if test="${adult != 0}">
							일반 : ${adult }명<br>
							금액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${adult * 15000}" />
						</c:if>
						<c:if test="${junior != 0}">
							청소년 : ${junior }명<br>
							금액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${junior * 10000}" />
						</c:if>
					</td>
				</tr>
				<tr>
					<td>결제하실 금액</td>
				</tr>
				<tr>
					<td>총 <fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />원</td>
				</tr>
			</table>
		</div>
		<div id="credit_div" style="width: 700px;">
			<p>결제 수단</p>
			<div class="form-check form-check-inline">
			  <input class="credit_rb form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="신용카드" checked>
			  <label class="form-check-label" for="inlineRadio1">신용카드</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="credit_rb form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="계좌이체">
			  <label class="form-check-label" for="inlineRadio2">계좌이체</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="credit_rb form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="휴대폰결제">
			  <label class="form-check-label" for="inlineRadio3">휴대폰결제</label>
			</div>
		</div>

		<div id="total_form_div" style="width: 700px;">
			<form method="post" action="<%=request.getContextPath() %>/movieBookingSend.do"
				onsubmit="valueSetting()">
				<input type="hidden" name="screencode" value="${sdto.screencode }">
				<input type="hidden" name="select_seat" value="${select_seat }">
				<input type="hidden" name="userid" value="${memSession.id }">
				<input type="hidden" name="credit" id="credit">
				
				<button type="submit" class="btn btn-block btn-info" style="height: 100px;">
					<i class='glyphicon glyphicon-credit-card'></i></button>
			</form>
		</div>
	</div>

</body>
</html>