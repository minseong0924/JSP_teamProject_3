<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 메인</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div style="margin:20px;">
		<nav id="side_bar">
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역</a></li>
			<li><a class="side_menu" href="#">개인정보 수정</a></li>
		</nav>
	</div>
	<div align="center">
		<div class="title">
			<br><br>
			<h2>마이페이지</h2>
			<br><br>
			<span class="memname">${memSession.name }님</span>
			<span class="mempoint">포인트</span>
			<br>
			<span><a class="memedit" href="<%=request.getContextPath() %>/memEdit.do?memid=${memSession.id }">개인정보수정 ≫</a></span>
			<span class="mempoint1">${memSession.point }P</span>
			<br><br><br><br>
			<div class="memleft">
				<span class="mypage">나의 무비스토리</span>

				<table class="mypageinfo">
					<tr>
						<th>총 예매 영화</th>
						<th>남긴 리뷰</th>
					</tr>
					<tr>
						<td>${booked_count }</td>
						<td>${review_count }</td>
					</tr>
				</table>
			</div>
			<div class="memright">
				<span class="mypage">선호 관람정보</span>

				<table class="mypageinfo">
					<tr>
						<th>선호 극장</th>
						<th>선호 장르</th>
					</tr>
					<tr>
						<td>${like_cinema }</td>
						<td>${like_genre }</td>
					</tr>
				</table>
			</div>
			<br><br><br><br><br><br><br><br><br><br>
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
						<c:if test="${fn:length(blist) > 3 }">
							<c:forEach items="${blist }" var="dto" begin="0" end="2">
								<tr>
									<td>${dto.bookingcode }</td>
									<td>${dto.cinemaname }</td>
									<td>${dto.title_ko }</td>
									<td>${dto.start_time } ~ ${dto.end_time }</td>
								</tr>
							</c:forEach>
									<td colspan="4" align="center">······</td>
						</c:if>

						<c:if test="${fn:length(blist) < 4 }">
							<c:forEach items="${blist }" var="dto">
								<tr>
									<td>${dto.bookingcode }</td>
									<td>${dto.cinemaname }</td>
									<td>${dto.title_ko }</td>
									<td>${dto.start_time } ~ ${dto.end_time }</td>
								</tr>
							</c:forEach>
						</c:if>
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