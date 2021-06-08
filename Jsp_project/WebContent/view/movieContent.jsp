<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세정보</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<br><br>
	<c:set var="dto" value="${List }"/>
	<div class="movie-content">
		<div class="movie-content-img" style="background-image:url('https://img.megabox.co.kr/SharedImg/2021/05/06/WkhMtd7UfrrFwj8wML9FAKAtUKwPPMR5_570.jpg');">
			
		</div>
		
		<div class="movie-detail-cont">
			<br><br>
			<c:if test="${dto.getMstate() == '상영중' }">
			<p class="d-day">1</p>
			</c:if>
			<c:if test="${dto.getMstate() == '개봉 예정' }">
			<p class="d-day">2</p>
			</c:if>
			<br><br>
			<p class="movie-title">${dto.getTitle_ko() }</p>
			<br>
			<p class="movie-title-en">${dto.getTitle_en() }</p>
	 		<br><br><br><br>
	 		<div class="movie-info">
	 			<p>예매율</p>
	 			<p>~~</p>
	 		</div>
	 		<div class="movie-info-stack">
	 			<p>누적관객수</p>
	 			<p>~~</p>
	 		</div>
	 		
	 		<div class="poster">
	 			<img src="upload/${dto.getPoster() }" height="350">
	 		</div>
	 		<div class="reserve">
	 			<a href='booking.do?moviecode=${dto.getMoviecode()}'>예매</a>
	 		</div>
 		</div>
	</div>
 		
	<div class="movie-content-info">
		<div class="movieInfo">
				<h3>주요정보</h3>
				<br><br>
				<p>${dto.getSummary() }</p>
				<br><br>
				
				<p>상영타입 : ${dto.getMtype()} </p>
				<p>
				<span>감독 : ${dto.getDirector() }</span>
				<span>장르 : ${dto.getGenre() }</span>
				<span>등급 : ${dto.getAge() }</span>
				<span>개봉일 : ${dto.getOpendate() }</span>
				</p>
				<p>출연진 : ${dto.getActor() }</p>
		</div>
		<br><br>
		<div class="review">
			<h3>실관람평</h3>
			<div class="memberName">
				<span>box</span>
			</div>
			<form method="post" action="<%=request.getContextPath() %>/reviewWriteOk.do">
				<input type="hidden" name="moviecode" value="${dto.getMoviecode() }">
				<input type="hidden" name="title_ko" value="${dto.getTitle_ko() }">
				<input type="hidden" name="id" value="${id}">
				<div class="review-text">
					<textarea rows="7" cols="10" name="review-text" 
						placeholder="${dto.getTitle_ko() }재미있게 보셨나요? 영화의 어떤점이 좋았는지 평가해주세요"></textarea>
				</div>
				<div class="write-review">
					<input type="submit" value="관람평 쓰기">
				</div>
			</form>
			
			<c:set var="review" value="${reviewList}"/>
			<c:if test="${!empty reviewList }">
			<c:forEach var="re" items="${reviewList}">
			<br><br><br><br><br>
			<div class="memberName1">
				<span>${re.getId() }</span>
			</div>
			<div class="review-box">
				<div class="story-point">
					<span>${re.getPoint() }</span>
				</div>
				
				<div class="story-text">
					<span>${re.getCont() }</span>
				</div>
			</div>
			</c:forEach>
			</c:if>
			
			<c:if test="${empty reviewList }">
				리뷰가 없습니다.
			</c:if>
		</div>
	</div>
	
	
	
	

	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>