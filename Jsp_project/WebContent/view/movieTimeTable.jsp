<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영 시간표</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var date = today.getDate();
	var yearmonth = year + "-0" +month;
	var day = "";
	var count = 0;
	
$(document).ready(function(){
	
	$(".wrap").append("<button class='btn-pre' title='이전 날짜 보기'></button>");
	$(".btn-pre").append("<i class='glyphicon glyphicon-chevron-left'></i");
	for(var i=date; i<date+13; i++) {
		var tym = yearmonth+"-"+i;
		var day = "";
		day = today.getDay();
		
		day = day + count;
		
		if(day>=7) {
			day = day%7;
		}

		switch(day) {
			case 0 : day="일"; break;
			case 1 : day="월"; break;
			case 2 : day="화"; break;
			case 3 : day="수"; break;
			case 4 : day="목"; break;
			case 5 : day="금"; break;
			case 6 : day="토"; break;	
		}
		if(count==0) {
			day="오늘";
		}else if(count==1) {
			day="내일";
		}
		
		
		if(day == "토"){
			$(".wrap").append("<button class='on sat' name='btn' type='button' date_data='"+tym+"'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}else if(day =="일"){			
			$(".wrap").append("<button class='on holi' name='btn' type='button' date_data='"+tym+"'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}else {
			$(".wrap").append("<button class='on' name='btn' type='button' date_data='"+tym+"'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}
		count++;
	}
		$(".wrap").append("<button class='btn-next' title='이전 날짜 보기'></button>");
		$(".btn-next").append("<i class='glyphicon glyphicon-chevron-right'></i");
		
		//load(date_data);
}); 
	

function change(moviecode) {
	$.ajax({
		type: "post",		// post 방식으로 전송
		dataType : "xml",	// 응답 데이터를 텍스트 형식으로 지정
		url : "/Jsp_project/data/timeTable.jsp",	// 전송할 페이지를 지정
		data: {"param": moviecode},	// 전송할 매개변수와 값을 설정
		success: function(data) {	// 전송과 응답이 성공했을 때 작업을 설정하는 공간
			var dat = $(data).find("movie");
			$("#img").attr("src", "/Jsp_project/upload/"+dat.find("poster").text());
			$("#title_ko").text(dat.find("ko").text());
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}

function load(location) {
	$.ajax({
		type: "post",		// post 방식으로 전송
		dataType : "xml",	// 응답 데이터를 텍스트 형식으로 지정
		url : "/Jsp_project/data/timeTableLocation.jsp",	// 전송할 페이지를 지정
		data: {"location": location, "title_ko":$("#title_ko").text(),
			"today": date_data	},	// 전송할 매개변수와 값을 설정
		success: function(data) {
			$(".theater-list").empty();
			var dat = $(data).find("screen1").find("screen");
			
			//dat.find("cinemaname").text() 저장용
			var pre = "";
			var cincode = 0;
			
			//극장 뿌리기
			dat.each(function(){
				//영화관이 중복되지 않게하는 조건문.
				if($("cinemaname", this).text() != pre) {
					$(".theater-list").append("<div id='"+$("cinemaname", this).text()+"'class='theater-list-box'><div class='locationInfo'><h3 class='localarea' >"+$("cinemaname", this).text()+"</h3></div>"
							+"<hr width='70%' align='left'></div>");
				}
					pre = $("cinemaname", this).text();
					
						console.log(cincode);
						
				
				// 관이 중복되지 않게하는 조건문
				if($("cincode", this).text() != cincode){	
					$("#"+$("cinemaname", this).text()+"").append("<div id='"+$("cincode", this).text()+"'class='theater-list-box1'><span class='localscreen'>"+$("cincode", this).text()+"관</span>" +
						"<div class='movietype'><span class='movietype-text'>"+$("mtype", this).text()+"</span></div>"+
						"<div class='movietime-box'><a href='#' class='movietime'>"+$("start_time", this).text()+"</a></div></div>");
				}else {
					$("#"+$("cinemaname", this).text()+"").find("#"+$("cincode", this).text()+"").append("<div class='movietime-box'><a href='#' class='movietime'>"+$("start_time", this).text()+"</a></div>");
				}
						cincode = $("cincode", this).text();
			});
			
			// 시간표 뿌리기
		/* 	dat.each(function(){
				console.log($(".localarea").text());
				if($("cinemaname", this).text() == $(".localarea").text()) {	
				$(".theater-list-box").append("<div class='theater-list-box1'><span class='localscreen'>"+$("cincode", this).text()+"관</span>" +
						"<div class='movietype'><span class='movietype-text'>"+$("mtype", this).text()+"</span></div></div>")
				}
				
			}); */
			
			/* <div class="theater-list-box1">
			<span class="localscreen">1관</span>
				<div class="movietype">
					<span class="movietype-text">2D</span>
				</div>
			
				<div class="movietime-box">
					<a href="#" class="movietime">17:50</a>
				</div>
		</div> */
/* $(".theater-list").append
	("<div class='locationInfo'><h3 class='localarea'>"+dat.find("cinemaname").text()+"</h3></div>"
	+ ""); */
					/* <div class="theater-list">
					<div class="locationInfo">
						<h3 class="localarea">강남</h3>
						<hr width="70%" align="left">
					</div>
						
					<div class="theater-list-box">
						<span class="localscreen">1관</span>
						
						<div class="movietype">
							<span class="movietype-text">2D</span>
						</div>
						
						<div class="movietime-box">
							<a href="#" class="movietime">17:50</a>
						</div>
					</div>
				</div> */
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div class="timetable">	
		<div class="timetable-container">
			<div class="movie-choise-area">
				<ul>
					<li><a href="#" title="영화별 선택" class="btn"><span>영화별</span></a></li>
					<li><a href="#" title="극장별 선택" class="btn"><span>극장별</span></a></li>
				</ul>
			</div>
			
			<c:set var="list" value="${List }"/>
			<div class="movie-choise">
			<br><br>
				<ul>
					<c:forEach items="${List }" var="dto">
					<li>
						<button id="tit" type="button" class="btn" onclick="change(${dto.getMoviecode()})">${dto.getTitle_ko() }
						</button>
					</li>
					</c:forEach>
				</ul>
			</div>

			<div class="movieposter">
				<img id="img" src="<%=request.getContextPath() %>/upload/${list[0].getPoster() }" height="300px" >
			</div>
		</div>	
			<div class="movie-tit-div">
			<h3 class="movie-tit">
				<span id="title_ko">${list[0].getTitle_ko() }</span>
				상영 시간표
			</h3>
			</div>
			<div class="wrap">

			</div>
			
			<div class="btn-group1" role="group" aria-label="...">
			  <button type="button" class="btn btn-default btn1" onclick="load('seoul')">서울</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('gk')">경기</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('incheo')">인천</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('daejeon')">대전/충청/세종</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('busan')">부산/대구/경상</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('gwangju')">광주/전라</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('gangwon')">강원</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('jeju')">제주</button>
			</div>
			
			<div class="theater-list">
				<div class="theater-list-box">
					<div class="locationInfo">
						<h3 class="localarea">강남</h3>
						<hr width="70%" align="left">
					</div>
					<div class="theater-list-box1">
						<span class="localscreen">1관</span>
							<div class="movietype">
								<span class="movietype-text">2D</span>
							</div>

							<div class="movietime-box">
								<a href="#" class="movietime">17:50</a>
							</div>
					</div>


					<div class="theater-list-box1">
						<span class="localscreen">1관</span>
							<div class="movietype">
								<span class="movietype-text">2D</span>
							</div>

							<div class="movietime-box">
								<a href="#" class="movietime">17:50</a>
							</div>

					</div>


				</div>
			
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>