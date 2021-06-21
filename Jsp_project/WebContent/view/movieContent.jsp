<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 영화 상세 정보</title>
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
				var id = Rlist[i].id
				console.log(id);
				console.log(Rlist[i].id);
				var starId = id.substring(0,id.length-2)+"**";
				$(".review").append("<div class='review-list' name='review-list"+i+"' value='"+Rlist[i].no+"'>");
				$("div[name=review-list"+i+"]").append("<div class='review_id'><span>"+starId+"</span></div>");
				$("div[name=review-list"+i+"]").append("<div class='review_point'><span>"+Rlist[i].point+"점</span></div>");
				$("div[name=review-list"+i+"]").append("<div class='review_text'><span>"+Rlist[i].content+"</span></div>");
				$(".review").append("</div>");
				if(Rlist[i].id == '${memSession.id}') {
					$("div[name=review-list"+i+"]").append("<div class='review_update'><button class='btn btn-dark review_btn2' onclick='update(`"+i+"`,`"+Rlist[i].no+"`,`"+Rlist[i].moviecode+"`)'>수정</button></div>");
					$("div[name=review-list"+i+"]").append("<div class='review_delete'>"
					+ "<button onclick='if(confirm(`정말 삭제하시겠습니까?`)){location.href=`<%=request.getContextPath()%>/reviewDelete.do?no="+Rlist[i].no+"&moviecode="+Rlist[i].moviecode+"`}"
					+ "else{return;}' class='btn btn-dark review_btn2'>"
					+ "삭제</button>");
				}
			}
		},
		error: function(request,status,error){
	       alert("error!!!");
		}
	});
}
function update(i, no1, moviecode1) {
	console.log(moviecode1);
	var moviecode = moviecode1;
	var no = no1;
	var id = $("div[name=review-list"+i+"]").find(".review_id").find("span").text();
	var text = $("div[name=review-list"+i+"]").find(".review_text").find("span").text();
	var point = $("div[name=review-list"+i+"]").find(".review_point").find("span").text();
	var point1 = point.substring(0, point.length-1);

	$("div[name=review-list"+i+"]").find(".review_id").remove();
	$("div[name=review-list"+i+"]").find(".review_point").remove();
	$("div[name=review-list"+i+"]").find(".review_text").remove();
	$("div[name=review-list"+i+"]").find(".review_update").remove();
	$("div[name=review-list"+i+"]").find(".review_delete").remove();
	
	$("div[name=review-list"+i+"]").append
	("<form method='post' action='<%=request.getContextPath() %>/reviewUpdateOk.do'></form");
	
	$("div[name=review-list"+i+"]").find("form").append
	("<div class='review_id'><span>"+id+"</span></div>");
	
	$("div[name=review-list"+i+"]").find("form").append
	("<input type='hidden' value='"+no+"' name='no'><input type='hidden' name='moviecode' value='"+moviecode+"'>");
	
	$("div[name=review-list"+i+"]").find("form").append(
	"<div class='review_point'><select name='point' required>"	
	+ "<option disabled>:::평점:::</option>"
	+ "<% for(int i=1; i<11; i++) { %>"
	+ "<option id='point<%=i%>' value='<%=i%>'> <%=i %>점 </option><%} %></select></div>");

	$("#point"+point1).attr('selected', 'selected');
	
	$("div[name=review-list"+i+"]").find("form").append
	("<div class='review_text'><textarea rows='7' cols='10' name='review-text' required>"
	+ text
	+"</textarea></div>");  
	$("div[name=review-list"+i+"]").find("form").append
	("<div class='review_update'><input type='submit' value='확인'></div>");
	$("div[name=review-list"+i+"]").find("form").append
	("<div class='review_delete'><button onclick='location.reload()'>취소</button></div>");
}

function check(id) {
	$.ajax({
		type:"post",
		url: "/Jsp_project/ReviewIdCheck.do",
		dataType: "json",
		data: {"title_ko" : $(".movie-title").text(),
			"id": id},
		success: function(data) {
			if(id.length==0) {
				alert('로그인을 하셔야 리뷰를 작성할 수 있습니다.');
			}else if(data == 1) {
				alert('영화당 한 번의 리뷰만 남길 수 있습니다.');
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
	 			<p>${dto.getRate() }</p>
	 		</div>
	 		<div class="movie-info-stack">
	 			<p>누적관객수</p>
	 			<p>${dto.getStack() }</p>
	 		</div>
	 		
	 		<div class="poster">
	 			<img src="upload/${dto.getPoster() }" height="350">
	 		</div>
	 		<div class="reserve">
	 			<a href='movieQuickBooking.do?moviecode=${dto.getMoviecode()}'>예매</a>
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
			<div class="review_in_div">
				<h3 style="color:white;">실관람평</h3>
				<div class="memberName">
					<span>${memSession.id}:box</span>
				</div>
				<form method="post" action="<%=request.getContextPath() %>/reviewWriteOk.do">
					<div class="review_write" onclick="check('${memSession.id}')">
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
							<input type="submit" class="btn btn-dark review_btn" value="관람평 쓰기">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>