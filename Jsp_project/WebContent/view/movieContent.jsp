<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세정보</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
	loadReview();
});
function loadReview() {
	
	$.ajax({
		type:"post",
		url: "/Jsp_project/ReviewList.do",
		dataType: "json",
		data: {"title_ko" : $(".movie-title").text()},
		success: function(data) {
			var Rlist = data.list;
			
			for(var i=0; i<Rlist.length; i++) {
				$(".review").append("<div class='review-list' name='review-list"+i+"'>");
				$("div[name=review-list"+i+"]").append("<div class='review_id'><span>"+Rlist[i].id+"</span></div>");
				$("div[name=review-list"+i+"]").append("<div class='review_point'><span>"+Rlist[i].point+"점</span></div>");
				$("div[name=review-list"+i+"]").append("<div class='review_text'><span>"+Rlist[i].content+"</span></div>");
				$(".review").append("</div>");		
			}
			
		},
		error: function(request,status,error){
	       alert("error!!!");
		}
	});
}

function loginCheck(id) {
	if(id == null) {
		alert('로그인을 하셔야 리뷰를 작성할 수 있습니다.');
	}else {
		return;
	}
}

function check(id) {
	$.ajax({
		type:"post",
		url: "/Jsp_project/ReviewIdCheck.do",
		dataType: "json",
		data: {"title_ko" : $(".movie-title").text(),
			"id": id},
		success: function(data) {
			
			if(data == 1) {
				alert('')
			}
			
		},
		error: function(request,status,error){
	       alert("error!!!");
		}
	});
}
</script>

</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<br><br>
	<c:set var="dto" value="${List }"/>
	<div class="movie-content">
		<div class="movie-content-img" style="background-image:url('./upload/${dto.getPoster() }');">
			<!-- https://img.megabox.co.kr/SharedImg/2021/05/06/WkhMtd7UfrrFwj8wML9FAKAtUKwPPMR5_570.jpg -->
		</div>
		
		<div class="movie-detail-cont">
			<br><br>
			<c:if test="${dto.getMstate() == '상영중' }">
			<p class="d-day">상영중</p>
			</c:if>
			<c:if test="${dto.getMstate() == '개봉 예정' }">
			<p class="d-day">${dto.getOpendate() } 개봉</p>
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
			<form method="post" action="<%=request.getContextPath() %>/reviewWriteOk.do"
					onsubmit="check(${memSession.id})">
				<div class="review_write" onclick="loginCheck(${memSession.id})">
					<input type="hidden" name="moviecode" value="${dto.getMoviecode() }">
					<input type="hidden" name="title_ko" value="${dto.getTitle_ko() }">
					<input type="hidden" name="id" value="${memSession.id}">
					<div class="review_write_point">
						<select class="point_area" name="point" required>
									<option value="" selected disabled>:::평점:::</option>
							<% for(int i=1; i<11; i++) { %>
									<option value="<%=i%>"><%=i %>점</option>
							<%} %>
						</select>
					</div>
					<div class="review_write_text">
						<textarea rows="7" cols="10" name="review-text" 
							placeholder="${dto.getTitle_ko() }재미있게 보셨나요? 영화의 어떤점이 좋았는지 평가해주세요"
							required></textarea>
					</div>
					<div class="review_write_button">
						<input type="submit" value="관람평 쓰기">
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>