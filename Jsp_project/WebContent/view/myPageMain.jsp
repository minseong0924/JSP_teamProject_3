<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 마이페이지 - 메인</title>
<link rel="stylesheet" href="./css/style.css">
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
			<span>마이페이지</span>
		</div>
		<div class="my_main_div">
			<div class="name_pont_div">
				<div class="name_div">
					<p class="memname">${memSession.name }님</p>
					<p><a class="memedit" href="<%=request.getContextPath() %>/memPwdChk.do?memid=${memSession.id }">개인정보수정 ≫</a></p>
				</div>
				<div class="point_div">
					<p class="mempoint">포인트</p>
					<p>${memSession.point }P</p>
				</div>
			</div>
			<div class="memleft">
				<div class="mypage">나의 무비스토리</div>

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
				<div class="mypage">선호 관람정보</div>

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
		</div>
		<div class=my_title_div2>나의 예매내역</div>
		<div class="my_boo_div">
			<span><a class="membooted" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">더보기 ≫</a></span>
			
			<table class="table table-hover boo_table">
				<tr class="boo_table_tr">
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
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>