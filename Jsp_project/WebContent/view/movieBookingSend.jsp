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
	<div align="center" class="pay_all_div">
		<div class="pay_title_div">예매내역 확인</div>
		<div id="table_div" class="pay_table_div">
			<table>
				<tr>
					<td rowspan="9">
						<img src="<%=request.getContextPath() %>/upload/${sdto.poster }"
				 		class="pay_img" >
					</td>
					<td class="pay_td"><b>영화&nbsp;&nbsp;&nbsp;</b>${sdto.moviename }(${sdto.mtype })</td>
				</tr>
				<tr>
					<td class="pay_td">${sdto.movienameEng }</td>
				</tr>
				<tr>
					<td class="pay_td"><b>관람가&nbsp;&nbsp;&nbsp;</b>${sdto.age }</td>
				</tr>
				<tr>
					<td class="pay_td">
					    <b>일시&nbsp;&nbsp;&nbsp;</b>${sdto.start_date }&nbsp;
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
					<td class="pay_td"><b>극장&nbsp;&nbsp;&nbsp;</b>${sdto.cinemaname } │ ${sdto.cincode }관</td>
				</tr>
				<tr>
					<td class="pay_td">
						<b>좌석&nbsp;&nbsp;&nbsp;</b> 
						<c:set var="seat" value="${fn:split(select_seat,'/')}" />
						<c:forEach var="seatno" items="${seat}" varStatus="i">
							${seatno} 번 좌석 │
						     <%--<c:if test="${i.count == 2}">${seatno}</c:if>
						     <c:if test="${i.last}">-${seatno}</c:if>  --%>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>
						<c:if test="${adult != 0}">
							<b>일반&nbsp;&nbsp;&nbsp;</b>${adult }명<br>
							<b>금액&nbsp;&nbsp;&nbsp;</b><fmt:formatNumber type="number" maxFractionDigits="3" value="${adult * 15000}" />
						</c:if>
						<c:if test="${junior != 0}">
							<b>청소년&nbsp;&nbsp;&nbsp;</b>${junior }명<br>
							<b>금액&nbsp;&nbsp;&nbsp;</b><fmt:formatNumber type="number" maxFractionDigits="3" value="${junior * 10000}" />
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="pay_total_td">결제하실 금액</td>
				</tr>
				<tr>
					<td style="text-align: right;"><b>총 <fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />원</b></td>
				</tr>
			</table>
		</div>
		<div id="credit_div">
			<div class="pay_title_div2">결제 수단</div>
			<div class="credit_in_div">
				<div class="pay_cre_div form-check form-check-inline">
				  <input class="credit_rb form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="신용카드" checked>
				  <label class="form-check-label" for="inlineRadio1">신용카드</label>
				</div>
				<div class="pay_cre_div form-check form-check-inline">
				  <input class="credit_rb form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="계좌이체">
				  <label class="form-check-label" for="inlineRadio2">계좌이체</label>
				</div>
				<div class="pay_cre_div form-check form-check-inline">
				  <input class="credit_rb form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="휴대폰결제">
				  <label class="form-check-label" for="inlineRadio3">휴대폰결제</label>
				</div>
			</div>
		</div>
		<div id="total_form_div">
			<div class="pay_title_div2">안내 사항</div>
				<div class="pay_check_div" align="center">
					<form method="post" action="<%=request.getContextPath() %>/movieBookingSend.do"
						onsubmit="valueSetting()">
						<div class="pay_check_in_div" align="left">
							<span>- 인터넷 예매는 온라인 상으로 영화상영 시간 20분 전 까지 취소 가능하며 20분 이후에는 취소 불가합니다.</span><br>
							<span>- 예매 취소는 예매한 아이디를 통해서 하실 수 있습니다.</span><br>
							<span>- 입장지연에 따른 관람 불편을 최소화하고자 본 영화는 약 10분 후에 시작됩니다.(일부 극장 제외)</span><br>
						</div>
						<div class="pay_submit_div" align="center">
							<label>
								<input type="checkbox" required> 상기 결제 내역을 확인하였습니다.
							</label>
							<input type="hidden" name="screencode" value="${sdto.screencode }">
							<input type="hidden" name="select_seat" value="${select_seat }">
							<input type="hidden" name="userid" value="${memSession.id }">
							<input type="hidden" name="credit" id="credit">
							<input type="hidden" name="price" value="${price}">
							
							
							<br><button type="submit" class="pay_btn btn" style="height: 50px;">
								<i class='glyphicon glyphicon-credit-card'></i> 결제하기</button>
						</div>
					</form>
				</div>
		</div>
	</div>

</body>
</html>