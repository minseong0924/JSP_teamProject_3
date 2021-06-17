<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 예매내역</title>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div style="margin:20px;">
		<nav id="side_bar">
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageEdit.do?memid=${memSession.id }">개인정보 수정</a></li>
		</nav>
	</div>
	<div align="center">
		<div class="title">
			<br><br>
			<h2>예매내역</h2>
			<br><br>
			<div class="memleft" style="width:1110px;">
				<span class="mypage">나의 예매내역</span>
				<span><a class="membooted" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">더보기 ≫</a></span>

				<table class="table table-striped table-hover">
					<tr>
						<th>예매번호</th>
						<th>지점</th>
						<th>영화제목</th>
						<th>상영시간</th>
					</tr>

					<c:if test="${!empty blist }">
						<c:forEach items="${blist }" var="dto">
							<tr>
								<td>${dto.bookingcode }</td>
								<td>${dto.cinemaname }</td>
								<td>${dto.title_ko }</td>
								<td>${dto.start_time } ~ ${dto.end_time }</td>
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
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>