<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 마이페이지 - 예매내역 관리</title>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
<!-- 	<div style="margin:20px;"> -->
		<nav id="side_bar">
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/memPwdChk.do?memid=${memSession.id }">개인정보 수정</a></li>
		</nav>
<!-- 	</div> -->
	<div class="my_all_div" align="center">
		<div class="my_title_div">
			<span>예매내역 관리</span>
		</div>
		<div class="my_boo_div">
			<p class="mypage">예매내역</p>
			<table class="table table-hover boo_table">
				<tr class="boo_table_tr">
					<th>예매번호</th>
					<th>지점</th>
					<th>영화제목</th>
					<th>상영시간</th>
					<th>취소</th>
				</tr>

				<c:if test="${!empty blist }">
					<c:forEach items="${blist }" var="dto">
						<tr>
							<td>${dto.bookingcode }</td>
							<td>${dto.cinemaname }</td>
							<td>${dto.title_ko }</td>
							<td>${dto.start_time} ~ ${dto.end_time}</td>
							<td><input type="button" value="취소" class="btn table_btn"
								onclick="if(confirm('정말 취소하시겠습니까?')){location.href='bootedDelete.do?bookingcode=${dto.bookingcode }'}
										else{return false}"></td>
						</tr>
					</c:forEach>
				</c:if>

				<c:if test="${empty blist }">
					<tr>
						<td colspan="4" align="center">검색된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>