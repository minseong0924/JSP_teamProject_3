<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영 시간표</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.8.6/jquery.timepicker.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.8.6/jquery.timepicker.js"></script>

<script>
let today = new Date();
let year = today.getFullYear();
let month = today.getMonth() + 1;
let date = today.getDate();
let yearmonth = year + "-0" +month;
let day = "";
let count = 0;
let date_data = yearmonth + "-" +date;
let tym = yearmonth+"-"+today.getDate();

// 페이지 시작 시 
$(document).ready(function(){
		movie();
		opendate();
		dateButton('서울', tym);

}); 

//영화별 start
//영화별 눌렀을 때 함수
function movie() {
	$.ajax({
		type: "post",
		url : "/Jsp_project/movieList2.do",	
		dataType : "json",	
		data: {},	
		success: function(data) {	
			$("#title_ko").show();
			$("#title_ko2").hide();
			$(".btn-group1").show();
			$("#img").show();
			$(".local").empty();
			$(".movie-choise1").find("ul").empty();
			var list = data.list;
			for(var i=0; i<list.length; i++) {
				$(".movie-choise1").find("ul").append
				("<li><button id='tit' type='button' class='btn' onclick='change(`"+list[i].moviecode+"`)'>"
						+list[i].title_ko+"</button></li>");
			}
			$("#title_ko").text(list[0].title_ko);
			dateButton('서울', tym);
			
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}

//영화별 상영시간표 띄우는 함수	
function opendate() {
	today = new Date();
	year = today.getFullYear();
	month = today.getMonth() + 1;
	date = today.getDate();
	yearmonth = year + "-0" +month;
	day = "";
	count = 0;
	date_data = yearmonth + "-" +date;
	tym = yearmonth+"-"+today.getDate();
	$(".wrap").append("<button class='btn-pre' title='이전 날짜 보기'></button>");
	$(".btn-pre").append("<i class='glyphicon glyphicon-chevron-left'></i");
	
	
	for(var i=date; i<date+13; i++) {
		tym = yearmonth+"-"+i;
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
			$(".wrap").append("<button class='on sat'type='button' onclick='dateButton(`"+tym+"`)'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}else if(day =="일"){			
			$(".wrap").append("<button class='on holi'  type='button' onclick='dateButton(`"+tym+"`)'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}else {
			$(".wrap").append("<button class='on' type='button' onclick='dateButton(`"+tym+"`)'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}
		count++;
	}
		$(".wrap").append("<button class='btn-next' title='다음 날짜 보기'></button>");
		$(".btn-next").append("<i class='glyphicon glyphicon-chevron-right'></i");
}
//영화명을 눌렀을 때 이벤트
function change(moviecode) {
	$.ajax({
		type: "post",		
		dataType : "xml",	
		url : "/Jsp_project/data/timeTable.jsp",	
		data: {"param": moviecode},	
		success: function(data) {	
			var dat = $(data).find("movie");
			$("#img").attr("src", "/Jsp_project/upload/"+dat.find("poster").text());
			$("#title_ko").text(dat.find("ko").text());
			
			var today2 = new Date();
			var todaydate2 = today2.getFullYear()+ "-0" + (today2.getMonth() + 1)+ "-" +today2.getDate();

			dateButton(todaydate2);
			
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}
//영화별에서 날짜 버튼을 눌렀을 때 이벤트	
function dateButton(date) {
		date_data = date;
		load('서울',date_data);
}

//영화별에서 아래 서울 ~제주 버튼을 눌렀을 때 이벤트
function load(location) {
	$.ajax({
		type: "post",		
		dataType : "xml",	
		url : "/Jsp_project/data/timeTableLocation.jsp",	
		data: {"location": location, "title_ko":$("#title_ko").text(),
				"today": date_data	},	
		success: function(data) {
			$(".theater-list").empty();
			var dat = $(data).find("screen1").find("screen");
			
			//dat.find("cinemaname").text() 저장용
			var pre = "";
			var cincode = 0;
			var srt_time = "";
			var starttime = 0;
				
			//극장 뿌리기
			dat.each(function(){
				//영화관이 중복되지 않게하는 조건문.
				if($("cinemaname", this).text() != pre) {
					$(".theater-list").append("<div id='"+$("cinemaname", this).text()+"'class='theater-list-box'><div class='locationInfo'><h3 class='localarea' >"+$("cinemaname", this).text()+"</h3></div>"
							+"<hr width='70%' align='left'></div>");
				}
					pre = $("cinemaname", this).text();
						
				starttime = $("start_time", this).text();
				if(Math.floor(starttime % 60) < 10) {
					srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
				} else {
					srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
				}

				// 관이 중복되지 않게하는 조건문
				if($("cincode", this).text() != cincode){	
					$("#"+$("cinemaname", this).text()+"").append("<div id='"+$("cincode", this).text()+"'class='theater-list-box1'><span class='localscreen'>"+$("cincode", this).text()+"관</span>" +
						"<div class='movietype'><span class='movietype-text'>"+$("mtype", this).text()+"</span></div>"+
						"<div class='movietime-box'><a href='#' class='movietime'>"+srt_time+"</a></div></div>");
				}else {
					$("#"+$("cinemaname", this).text()+"").find("#"+$("cincode", this).text()+"").append("<div class='movietime-box'><a href='#' class='movietime'>"+srt_time+"</a></div>");
				}
						cincode = $("cincode", this).text();
			});
			
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
//영화별 end

// 극장별 start
//극장별 눌렀을 때 함수
function theater() {
	$.ajax({
		type: "post",		
		dataType : "xml",	
		url : "/Jsp_project/data/LocalList.jsp",	
		data: {},	
		success: function(data) {	
			$(".btn-group1").hide();
			$("#title_ko2").show();
			$("#title_ko").hide();
			$("#img").hide();
			$(".wrap").empty();
			$(".local").empty();
			local_button('서울');
			opendate1();
			
			$(".movie-choise1").find("ul").empty();
			var dat = $(data).find("local1").find("local");
			var prev = "";
			dat.each(function(){
			var localname = "'"+$("localname",this).text()+"'";
				if($("localname",this).text() != prev){
					$(".local").append("<button id='"+$("localname",this).text()+"'class='local-button' onclick='local_button(`"+$("localname",this).text()+"`)'>"+$("localname",this).text()+"</button");
				}

					$(".movie-choise1").find("ul").append
					("<li><button id='tit' type='button' class='btn'" +
					"onclick='change2("+$("localname",this).text()+","+$("cinemaname",this).text()+")'>"+$("cinemaname",this).text() +
					"</button></li>")
				
					prev = $("localname",this).text();
			});
			
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}

// 극장별에서 위에 서울 버튼을 눌렀을 떄 나타나는 함수 극장들을 생성함.
function local_button(local) {
	$.ajax({
		type: "post",		
		dataType : "xml",	
		url : "/Jsp_project/data/localCinemaList.jsp",	
		data: {"local":local},	
		success: function(data) {	
			$(".movie-choise1").find("ul").empty();
			var dat1 = $(data).find("cin").find("cin1");
			dat1.each(function(){
				var n = 0;
				$(".movie-choise1").find("ul").append
				("<li><button id='tit"+n+"' type='button' class='btn' onclick='changecinema(`"+$("cinemaname", this).text()+"`)'>"
						+$("cinemaname", this).text()+"</button></li>");
				n++;
			});
			changecinema($("#tit0").text());
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

// 극장명을 눌렀을 때 정보를 가져오는 함수
function changecinema(cinemaname) {
	$.ajax({
		type: "post",		
		dataType : "json",
		url : "/Jsp_project/cinematable.do",	
		data: {"cinemaname": cinemaname},	
		success: function(data) {
			$(".theater-list").empty();			
			var slist = data.list;
			
			//dat.find("cinemaname").text() 저장용
			var pre = "";

			$("#title_ko2").text(cinemaname);
			
			var today2 = new Date();
			var todaydate2 = today2.getFullYear()+ "-0" + (today2.getMonth() + 1)+ "-" +today2.getDate();

			dateButton1(todaydate2);		
		},
		
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}

//극장별에서 날짜 버튼을 눌렀을 때 이벤트	
function dateButton1(date_data) {

		load1($("#title_ko2").text(), date_data);
}

// 극장별에서 정보를 보여주는 메서드
function load1(cinemaname, chandate) {
	$.ajax({
		type: "post",		
		dataType : "json",	
		url : "/Jsp_project/cinematable.do",	
		data: {"cinemaname": cinemaname,
				"today" : chandate},	
		success: function(data) {
			$(".theater-list").empty();			
			var slist = data.list;
			
			//dat.find("cinemaname").text() 저장용
			var pre = "";
			var cincode = 0;
			//$("#title_ko2").text(cinemaname);
		
			//영화명 뿌리기
			for(var i=0; i<slist.length; i++) {

				if(slist[i].moviename != pre) {
					$(".theater-list").append("<div id='"+slist[i].moviename+"'class='theater-list-box'><div class='locationInfo'><h3 class='localarea' >"+slist[i].moviename+"</h3></div>"
							+"<hr width='70%' align='left'></div>");
				}
					pre = slist[i].moviename;

			}
			
			for(var i=0; i<slist.length; i++) {
				
				starttime = slist[i].start_time;
				if(Math.floor(starttime % 60) < 10) {
					srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
				} else {
					srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
				}
			
				// 관이 중복되지 않게하는 조건문
				
				if(slist[i].moviename != pre ||slist[i].cincode != cincode){
					$("#"+slist[i].moviename+"").append("<div id='"+slist[i].cincode+"'class='theater-list-box1'><span class='localscreen'>"+slist[i].cincode+"관</span>" +
						"<div class='movietype'><span class='movietype-text'>"+slist[i].mtype+"</span></div>"+
						"<div class='movietime-box'><a href='#' class='movietime'>"+srt_time+"</a></div></div>");
				}else {
					$("#"+slist[i].moviename+"").find("#"+slist[i].cincode+"").append("<div class='movietime-box'><a href='#' class='movietime'>"+srt_time+"</a></div>");
				}
						cincode = slist[i].cincode;
						pre = slist[i].moviename;
			}
		},
		
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}

// 극장별 상영시간표 띄우는 함수 
function opendate1() {
	today = new Date();
	year = today.getFullYear();
	month = today.getMonth() + 1;
	date = today.getDate();
	yearmonth = year + "-0" +month;
	day = "";
	count = 0;
	date_data = yearmonth + "-" +date;
	tym = yearmonth+"-"+today.getDate();
	$(".wrap").append("<button class='btn-pre' title='이전 날짜 보기'></button>");
	$(".btn-pre").append("<i class='glyphicon glyphicon-chevron-left'></i");
	
	
	for(var i=date; i<date+13; i++) {
		tym = yearmonth+"-"+i;
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
			$(".wrap").append("<button class='on sat'type='button' onclick='dateButton1(`"+tym+"`)'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}else if(day =="일"){			
			$(".wrap").append("<button class='on holi'  type='button' onclick='dateButton1(`"+tym+"`)'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}else {
			$(".wrap").append("<button class='on' type='button' onclick='dateButton1(`"+tym+"`)'month='"+month+"'>"+i+"<br>"+day+"</button>");
		}
		count++;
	}
		$(".wrap").append("<button class='btn-next' title='다음 날짜 보기'></button>");
		$(".btn-next").append("<i class='glyphicon glyphicon-chevron-right'></i");
}
//극장별 end
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div class="timetable">	
		<div class="timetable-container">
			<div class="movie-choise-area">
				<ul>
					<li><button onclick="movie()" title="영화별 선택" class="btn" ><span>영화별</span></button></li>
					<li><button onclick="theater()" title="극장별 선택" class="btn" ><span>극장별</span></button></li>
				</ul>
			</div>
			
			<c:set var="list" value="${List }"/>
			<div class="movie-choise">
				<div class="local">

				</div>
				<br><br>
				<div class="movie-choise1">
					<ul>

					</ul>
				</div>
			</div>	
			

			<div class="movieposter">
				<img id="img" src="<%=request.getContextPath() %>/upload/${list[0].getPoster() }" height="300px" >
			</div>
		</div>	
			<div class="movie-tit-div">
			<h3 class="movie-tit">
				<span id="title_ko"></span>
				<span id="title_ko2"></span>
				상영 시간표
			</h3>
			</div>
			<div class="wrap">

			</div>
			
			<div class="btn-group1" role="group" aria-label="...">
			  <button type="button" class="btn btn-default btn1" onclick="load('서울')">서울</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('경기')">경기</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('인천')">인천</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('대전')">대전/충청/세종</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('부산')">부산/대구/경상</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('광주')">광주/전라</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('강원')">강원</button>
			  <button type="button" class="btn btn-default btn1" onclick="load('제주')">제주</button>
			</div>
			
			<div class="theater-list">
				<div class="theater-list-box">
					<div class="locationInfo">
						<h3 class="localarea">강남</h3>
						<hr width="70%" align="left">
					</div>
					<div class="theater-list-box1">
					
					</div>
	
					
					
				</div>
			</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>