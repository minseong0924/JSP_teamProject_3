<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 상영 시간표</title>
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
		setTimeout(function() { movie() }, 10);
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
				("<li><button id='"+list[i].moviecode+"' type='button' class='btn' onclick='movieNameB(`"+list[i].moviecode+"`)'>"
						+list[i].title_ko+"</button></li>");
			}
			$("#title_ko").text(list[0].title_ko);
			
			dateButton($(".wrap").find(".bk").val());	
			opendate(0,new Date());
			$("#list_theater").attr("class" ,"btn");
			$("#list_movie").attr("class" ,"btn bk");
			$(".movie-choise1").find("button").first().attr("class" ,"btn bk");
			$("#day1").attr("class" ,"on bk");
			$("#img").attr("src", "/Jsp_project/upload/"+list[0].poster);
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}

//영화별 상영시간표 띄우는 함수	
function opendate(dayflag, day) {
	var currentDay;
	
	if(dayflag == 'before') {
		$(".wrap").empty();
		currentDay = new Date(day);
		currentDay = new Date(currentDay.setDate(currentDay.getDate() - 1));
	} else if(dayflag == 'after') {
		$(".wrap").empty();
		currentDay = new Date(day);
		currentDay = new Date(currentDay.setDate(currentDay.getDate() + 1));
	}else {
		$(".wrap").empty();
		currentDay = new Date(day);
		currentDay = new Date(currentDay.setDate(currentDay.getDate()));
	}

	var weekName = ['일', '월', '화', '수', '목', '금', '토'];
	var theYear = currentDay.getFullYear();
	var theMonth = currentDay.getMonth();
	var theDate  = currentDay.getDate();
	 
	var thisWeek = [];
	 
	for(var i=0; i<13; i++) {
	  var resultDay = new Date(theYear, theMonth, theDate + i);
	  var yyyy = resultDay.getFullYear();
	  var mm = Number(resultDay.getMonth()) + 1;
	  var dd = resultDay.getDate();
	 
	  mm = String(mm).length === 1 ? '0' + mm : mm;
	  dd = String(dd).length === 1 ? '0' + dd : dd;
	 
	  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
	}
	var day = "";
	
	$(".wrap").append("<button onclick='dayBeforeSetting()' class='btn-pre' title='이전 날짜 보기'></button>");
	$(".btn-pre").append("<i class='glyphicon glyphicon-chevron-left'></i");
	
	for(var j=0; j<thisWeek.length; j++) {
		if(weekName[new Date(thisWeek[j]).getDay()] == "토"){
			$(".wrap").append("<button id='day"+(j+1)+"' class='on sat'type='button' onclick='dateButton(`"+thisWeek[j]+"`)' value='"+thisWeek[j]+"'>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]+"</button>");
		}else if(weekName[new Date(thisWeek[j]).getDay()] =="일"){			
			$(".wrap").append("<button id='day"+(j+1)+"' class='on holi'  type='button' onclick='dateButton(`"+thisWeek[j]+"`)' value='"+thisWeek[j]+"'>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]+"</button>");
		}else {
			$(".wrap").append("<button id='day"+(j+1)+"' class='on' type='button' onclick='dateButton(`"+thisWeek[j]+"`)' value='"+thisWeek[j]+"'>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]+"</button>");
		}
	}
	
	$(".wrap").append("<button onclick='dayAfterSetting()' class='btn-next' title='다음 날짜 보기'></button>");
	$(".btn-next").append("<i class='glyphicon glyphicon-chevron-right'></i");
}
function dayBeforeSetting() {
	today = new Date();
	today = today.toISOString().slice(0, 10);
	day = $("#day1").val();
	var checked = $(".wrap").find(".bk").prev().val();
	var attrid = $(".wrap").find(".bk").attr("id");
	var bk = $(".wrap").find(".bk").prev();
	if(day == today) {
		return;
	} else {
		opendate("before", day);
	}

		/* if(bk.attr("disabled")=='disabled') {
			while(true) {
				bk = bk.prev();
				day1 = bk.val();
				if(bk.attr("disabled")==null) {
					break;
				}
			}
		} */ 
	if(attrid == "day1") {
		var day1 = day.substring(0,4) + "-" + day.substring(5,7) +"-" +(String)((Number)(day.substring(8,10)) - 1);
		day = $("#day1").val();
		day1 = day.substring(0,4) + "-" 
		+ day.substring(5,7) +"-" 
		+(String)((Number)(day.substring(8,10)) - 1);
		dateButton(day1);	
	}else {
		dateButton(day);
	}
}

function dayAfterSetting() {
	var day = $("#day1").val();
	var checked = $(".wrap").find(".bk").next().val();
	var bk = $(".wrap").find(".bk").next();
	if(bk.attr("disabled")=='disabled') {
		while(true) {
			bk = bk.next();
			checked = bk.val();
			console.log(checked);
			if(bk.attr("disabled")==null) {
				break;
			}
		}
	} 
	opendate("after", day);
	dateButton(checked);
}


//영화명을 눌렀을 때 이벤트
function movieNameB(moviecode) {
	$.ajax({
		type: "post",		
		dataType : "xml",	
		url : "/Jsp_project/data/timeTable.jsp",	
		data: {"param": moviecode},	
		success: function(data) {	
			var dat = $(data).find("movie");
			$("#img").attr("src", "/Jsp_project/upload/"+dat.find("poster").text());
			$("#title_ko").text(dat.find("ko").text());
			
			$(".movie-choise1").find(".bk").attr("class" ,"btn");
			$("#"+moviecode).attr("class", "btn bk");
			
			var today2 = new Date();
			var todaydate2 = today2.getFullYear()+ "-0" + (today2.getMonth() + 1)+ "-" +today2.getDate();
			
			dateButton($(".wrap").find(".bk").val());

		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}
//영화별에서 상영정보가 없는 버튼을 비활성화 하는 함수 
function dateButtonDisabled() {
	$.ajax({
		type: "post",		
		dataType : "json",	
		url : "/Jsp_project/TableScreenList.do",	
		data: {"title_ko": $("#title_ko").text()},	
		success: function(data) {	
			$(".wrap").find(".on").attr("disabled", true);
			$(".btn1").attr("disabled", true);
			 var slist = data.slist;
			 var today = new Date();
			/*  if($(".wrap").find(".bk").val() != null) {
				 today = new Date($(".wrap").find(".bk").val());
			 } */
			 var srt_time = "";
			 console.log(slist.length);
			if(slist.length != 0) {
				 for(var i=0; i<slist.length; i++) {
					var starttime = slist[i].start_time;
					if(Math.floor(starttime % 60) < 10) {
						srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
					} else {
						srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
					}
					
					var moviedate = new Date(slist[i].start_date);
					var mYear = moviedate.getFullYear();
					var mMonth = moviedate.getMonth() + 1;
					var mMonth1 = moviedate.getMonth();
					var mDate = moviedate.getDate();
					var moviedate1 = new Date(mYear, mMonth1, mDate+1);
					mMonth = String(mMonth).length === 1 ? '0' + mMonth : mMonth;
					mDate = String(mDate).length === 1 ? '0' + mDate : mDate;

					if(moviedate1.toISOString().slice(0, 10) == today.toISOString().slice(0, 10)){
						if(srt_time.substring(0,2)>today.getHours() || (srt_time.substring(0,2)==today.getHours()&&srt_time.substring(3,5)>today.getMinutes())) {
							var ymd = mYear + '-' + mMonth + '-' + mDate;
							$("button[value="+ymd+"]").attr("disabled", false);
							$("button[name="+slist[i].localname+"]").attr("disabled", false);
						}
					}else if(moviedate1.toISOString().slice(0, 10) > today.toISOString().slice(0, 10)){
						var ymd = mYear + '-' + mMonth + '-' + mDate;
						$("button[value="+ymd+"]").attr("disabled", false);
						$("button[name="+slist[i].localname+"]").attr("disabled", false);
					}

				}
				
				 if(!$(".wrap").find(".bk").val()) {
					 $(".wrap").find(".on").first().attr("class", "on bk");
				 } 
				 
				 if($(".wrap").find(".bk").attr("disabled")=='disabled') {
						var moviedate = new Date(slist[0].start_date);
						var mYear = moviedate.getFullYear();
						var mMonth = moviedate.getMonth() + 1;
						var mMonth1 = moviedate.getMonth();
						var mDate = moviedate.getDate();
						var moviedate1 = new Date(mYear, mMonth1, mDate+1);
						mMonth = String(mMonth).length === 1 ? '0' + mMonth : mMonth;
						mDate = String(mDate).length === 1 ? '0' + mDate : mDate;
						ymd = mYear + '-' + mMonth + '-' + mDate;
						$(".wrap").find(".bk").attr("class", "on");
						$("button[value="+ymd+"]").attr("class", "on bk");
							console.log(ymd);
						dateButton(ymd);
				} 
			}
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});

}
//영화별에서 날짜 버튼을 눌렀을 때 이벤트	
function dateButton(date) {
		$(".wrap").find(".bk").attr("class", "on");
		$("button[value='"+date+"']").attr("class", "on bk");
		if(date == null) {
			var dat1 = new Date();
			date = dat1.toISOString().slice(0, 10);
		}
		console.log(date);
		load('서울',date);
}

//영화별에서 아래 서울 ~제주 버튼을 눌렀을 때 이벤트
function load(location, date_data) {
	if($(".wrap").find(".bk").val() != null) {
		date_data = $(".wrap").find(".bk").val();
	}else {
		date_data = $(".wrap").find(".on").first().val();
	}
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
				var moviedate = new Date($("start_date",this).text());
				var nowdate = new Date();
				var mYear = moviedate.getFullYear();
				var mMonth = moviedate.getMonth();
				var mMonth1 = moviedate.getMonth() + 1;
				var mDate = moviedate.getDate();
				var moviedate1 = new Date(mYear, mMonth, mDate+1);
			
				if(moviedate1.toISOString().slice(0, 10) == nowdate.toISOString().slice(0, 10)) {
					today = new Date();
					starttime = $("start_time", this).text();
					
					if(Math.floor(starttime % 60) < 10) {
						srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
					} else {
						srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
					}
					
					if(srt_time.substring(0,2)>today.getHours() || (srt_time.substring(0,2)==today.getHours()&&srt_time.substring(3,5)>today.getMinutes())) {	
						//영화관이 중복되지 않게하는 조건문.
						if($("cinemaname", this).text() != pre) {
							$(".theater-list").append("<div id='"+$("cinemaname", this).text()+"'class='theater-list-box'><div class='locationInfo'><h3 class='localarea' >"+$("cinemaname", this).text()+"</h3></div>"
									+"<hr width='70%' align='left'></div>");
						}
							pre = $("cinemaname", this).text();

						// 관이 중복되지 않게하는 조건문
						if($("cincode", this).text() != cincode){	
							$("#"+$("cinemaname", this).text()).append("<div id='"+$("cincode", this).text()+"'class='theater-list-box1'><span class='localscreen'>"+$("cincode", this).text()+"관</span>" +
								"<div class='movietype'><span class='movietype-text'>"+$("mtype", this).text()+"</span></div>"+
								"<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+$("screencode", this).text()+"' class='movietime'>"+srt_time+"</a><br><span>"+$("remaining_seats",this).text()+"석</span></div></div>");
						}else {
							$("#"+$("cinemaname", this).text()).find("#"+$("cincode", this).text()).append("<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+$("screencode", this).text()+"' class='movietime'>"+srt_time+"</a><br><span>"+$("remaining_seats",this).text()+"석</span></div>");
						}
							cincode = $("cincode", this).text();
					}
				}else {
					today = new Date();
					starttime = $("start_time", this).text();
					if(Math.floor(starttime % 60) < 10) {
						srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
					} else {
						srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
					}
					
					//영화관이 중복되지 않게하는 조건문.
					if($("cinemaname", this).text() != pre) {
						$(".theater-list").append("<div id='"+$("cinemaname", this).text()+"'class='theater-list-box'><div class='locationInfo'><h3 class='localarea' >"+$("cinemaname", this).text()+"</h3></div>"
								+"<hr width='70%' align='left'></div>");
					}
						pre = $("cinemaname", this).text();
					// 관이 중복되지 않게하는 조건문
					if($("cincode", this).text() != cincode){	
						$("#"+$("cinemaname", this).text()).append("<div id='"+$("cincode", this).text()+"'class='theater-list-box1'><span class='localscreen'>"+$("cincode", this).text()+"관</span>" +
							"<div class='movietype'><span class='movietype-text'>"+$("mtype", this).text()+"</span></div>"+
							"<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+$("screencode", this).text()+"' class='movietime'>"+srt_time+"</a><br><span>"+$("remaining_seats",this).text()+"석</span></div></div>");
					}else {
						$("#"+$("cinemaname", this).text()).find("#"+$("cincode", this).text()).append("<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+$("screencode", this).text()+"' class='movietime'>"+srt_time+"</a><br><span>"+$("remaining_seats",this).text()+"석</span></div>");
					}
						cincode = $("cincode", this).text();
				}
			});
			
			if($(".theater-list-box").attr("id") == null) {
				$(".theater-list").append("<div class='theater-list-box'><div class='locationInfo'><h3 class='localarea'>상영가능한 극장이 없습니다.</h3></div>"
						+"</div>");
			}
				$(".btn-group1").find(".bk").attr("class","btn btn1");
				$("button[name='"+location+"']").attr("class", "btn btn1 bk");
				
				dateButtonDisabled();
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
			opendate1(0, new Date());
			
			$(".movie-choise1").find("ul").empty();
			var dat = $(data).find("local1").find("local");
			var prev = "";
			$("#list_movie").attr("class" ,"btn");
			$("#list_theater").attr("class" ,"btn bk");
			$(".local").find("button").first().attr("class", "btn bk");
			$("#day1").attr("class" ,"on bk");
			
			dat.each(function(){
			var localname = "'"+$("localname",this).text()+"'";
				if($("localname",this).text() != prev){
					$(".local").append("<button id='"+$("localname",this).text()+"'class='btn' onclick='local_button(`"+$("localname",this).text()+"`)'>"+$("localname",this).text()+"</button");
				}

					$(".movie-choise1").find("ul").append
					("<li><button id='tit' type='button' class='btn'" +
					"onclick='change2("+$("localname",this).text()+","+$("cinemaname",this).text()+")'>"+$("cinemaname",this).text() +
					"</button></li>")
				
					prev = $("localname",this).text();
					
			});
			
			$(".movie-choise1").find("button").first().attr("class" ,"btn bk");
			changecinema($("tit0").text());
			console.log($("tit0").text() + "$('tit0').name()");
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
				("<li><button id='tit"+n+"' type='button' class='btn' onclick='changecinema(`"+$("cinemaname", this).text()+"`)'"
						+"name='"+$("cinemaname", this).text()+"'>"
						+$("cinemaname", this).text()+"</button></li>");
				n++;
			});
			changecinema($("#tit0").text());
			$(".local").find(".bk").attr("class", "btn");
			$("#"+local).attr("class", "btn bk");
			$("#tit0").attr("class", "btn bk");
			
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

//극장별에서 상영정보가 없는 버튼을 비활성화 하는 함수 
function dateButtonDisabled1() {
	$.ajax({
		type: "post",		
		dataType : "json",	
		url : "/Jsp_project/TableScreenList1.do",	
		data: {"title_ko2": $("#title_ko2").text()},	
		success: function(data) {	
			 var slist = data.slist;
			 var today = new Date();
			$(".wrap").find(".on").attr("disabled", true);
			 if(slist.length != 0) {
				 for(var i=0; i<slist.length; i++) {
						var starttime = slist[i].start_time;
							
							if(Math.floor(starttime % 60) < 10) {
								srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
							} else {
								srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
							}
							
							var moviedate = new Date(slist[i].start_date);
							var mYear = moviedate.getFullYear();
							var mMonth = moviedate.getMonth() + 1;
							var mMonth1 = moviedate.getMonth();
							var mDate = moviedate.getDate();
							var moviedate1 = new Date(mYear, mMonth1, mDate+1);
							mMonth = String(mMonth).length === 1 ? '0' + mMonth : mMonth;
							mDate = String(mDate).length === 1 ? '0' + mDate : mDate;
							
						if(moviedate1.toISOString().slice(0, 10) == today.toISOString().slice(0, 10)){
							if(srt_time.substring(0,2)>today.getHours() || (srt_time.substring(0,2)==today.getHours()&&srt_time.substring(3,5)>today.getMinutes())) {
								var ymd = mYear + '-' + mMonth + '-' + mDate;
								$("button[value="+ymd+"]").attr("disabled", false);
								console.log(ymd);
							}
						}else {
							var ymd = mYear + '-' + mMonth + '-' + mDate;
							$("button[value="+ymd+"]").attr("disabled", false);
								console.log(ymd);
						}
						
					 }
				 if($(".wrap").find(".bk").attr("disabled")=='disabled') {
						var moviedate = new Date(slist[0].start_date);
						var mYear = moviedate.getFullYear();
						var mMonth = moviedate.getMonth() + 1;
						var mMonth1 = moviedate.getMonth();
						var mDate = moviedate.getDate();
						var moviedate1 = new Date(mYear, mMonth1, mDate+1);
						mMonth = String(mMonth).length === 1 ? '0' + mMonth : mMonth;
						mDate = String(mDate).length === 1 ? '0' + mDate : mDate;
						$(".wrap").find(".bk").attr("class", "on");
						ymd = mYear + '-' + mMonth + '-' + mDate;
						$("button[value="+ymd+"]").attr("class", "on bk");
						dateButton1(ymd);
				} 
			}
		},
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
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
			var pre = "";

			$("#title_ko2").text(cinemaname);
			
			var today2 = new Date();
			var todaydate2 = today2.getFullYear()+ "-0" + (today2.getMonth() + 1)+ "-" +today2.getDate();

			dateButton1($(".wrap").find(".bk").val());
			$(".movie-choise1").find(".bk").attr("class", "btn");
			$("button[name="+cinemaname+"]").attr("class", "btn bk");

			$(".wrap").find("button").eq(1).attr("class", "on bk");
		},
		
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}

//극장별에서 날짜 버튼을 눌렀을 때 이벤트	
function dateButton1(date_data) {
		$(".wrap").find(".bk").attr("class", "on");
		$("button[value='"+date_data+"']").attr("class", "on bk");
		load1($("#title_ko2").text(), date_data);
}

// 극장별에서 정보를 보여주는 메서드
function load1(cinemaname, chandate) {
	if($(".wrap").find(".bk").val() != null) {
		chandate = $(".wrap").find(".bk").val();
	}else {
		chandate = $(".wrap").find(".on").first().val();
	}
	console.log(cinemaname);
	$.ajax({
		type: "post",		
		dataType : "json",	
		url : "/Jsp_project/cinematable.do",	
		data: {"cinemaname": cinemaname,
				"today" :  chandate},	
		success: function(data) {
			$(".theater-list").empty();			
			
			var slist = data.list;
		
			console.log(slist.length);

			
			//dat.find("cinemaname").text() 저장용
			var pre = "";
			var cincode = 0;
			var moviedate = "";
			console.log(slist.length==0);
			if(slist.length==0) {
				moviedate = new Date();
			}else {
				moviedate = new Date(slist[0].start_date);
			}
			
			var nowdate = new Date();
			var mYear = moviedate.getFullYear();
			var mMonth = moviedate.getMonth();
			var mDate = moviedate.getDate();
			var moviedate1 = new Date(mYear, mMonth, mDate+1);
			console.log(moviedate1.toISOString().slice(0, 10));
			console.log(nowdate.toISOString().slice(0, 10));
			if(moviedate1.toISOString().slice(0, 10) == nowdate.toISOString().slice(0, 10))	{
				//영화명 뿌리기
				for(var i=0; i<slist.length; i++) {
					today = new Date();
					starttime = slist[i].start_time;
					
					if(Math.floor(starttime % 60) < 10) {
						srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
					} else {
						srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
					}
					
					if(srt_time.substring(0,2)>today.getHours() || (srt_time.substring(0,2)==today.getHours()&&srt_time.substring(3,5)>today.getMinutes())){
						
						if(slist[i].moviename != pre) {
							$(".theater-list").append("<div id='"+slist[i].moviecode+"'class='theater-list-box'><div class='locationInfo'><h3 class='localarea' >"+slist[i].moviename+"</h3></div>"
									+"<hr width='70%' align='left'></div>");
						}
							pre = slist[i].moviename;
					}
				}
				
				for(var i=0; i<slist.length; i++) {
					
					starttime = slist[i].start_time;
					if(Math.floor(starttime % 60) < 10) {
						srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
					} else {
						srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
					}
			
					// 관이 중복되지 않게하는 조건문
					if(srt_time.substring(0,2)>today.getHours() || (srt_time.substring(0,2)==today.getHours()&&srt_time.substring(3,5)>today.getMinutes())) {
						if(slist[i].moviename != pre || slist[i].cincode != cincode){
							$("#"+slist[i].moviecode).append("<div id='"+slist[i].cincode+"'class='theater-list-box1'><span class='localscreen'>"+slist[i].cincode+"관</span>" +
								"<div class='movietype'><span class='movietype-text'>"+slist[i].mtype+"</span></div>"+
								"<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+slist[i].screencode+"' class='movietime'>"+srt_time+"</a><br><span>"+slist[i].remaining_seats+"석</span></div></div>");
							console.log('돌아감');
						}else {
							$("#"+slist[i].moviecode).find("#"+slist[i].cincode).append("<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+slist[i].screencode+"' class='movietime'>"+srt_time+"</a><br><span>"+slist[i].remaining_seats+"석</span></div>");
						}
							cincode = slist[i].cincode;
							pre = slist[i].moviename;
					}
				}
			}else {
				for(var i=0; i<slist.length; i++) {
					
					if(slist[i].moviename != pre) {
						$(".theater-list").append("<div id='"+slist[i].moviecode+"'class='theater-list-box'><div class='locationInfo'><h3 class='localarea' >"+slist[i].moviename+"</h3></div>"
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
						if(slist[i].moviename != pre || slist[i].cincode != cincode){
							$("#"+slist[i].moviecode).append("<div id='"+slist[i].cincode+"'class='theater-list-box1'><span class='localscreen'>"+slist[i].cincode+"관</span>" +
								"<div class='movietype'><span class='movietype-text'>"+slist[i].mtype+"</span></div>"+
								"<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+slist[i].screencode+"' class='movietime'>"+srt_time+"</a><br><span>"+slist[i].remaining_seats+"석</span></div></div>");
							console.log($("#"+slist[i].moviename).val());
						}else {
							$("#"+slist[i].moviecode).find("#"+slist[i].cincode).append("<div class='movietime-box'><a href='<%=request.getContextPath()%>/movieBookingReady.do?screencode="+slist[i].screencode+"' class='movietime'>"+srt_time+"</a><br><span>"+slist[i].remaining_seats+"석</span></div>");
						}
					
							cincode = slist[i].cincode;
							pre = slist[i].moviename;
				}
			}
			if($(".theater-list-box").attr("id") == null) {
				$(".theater-list").append("<div class='theater-list-box'><div class='locationInfo'><h3 class='localarea'>상영가능한 영화가 없습니다.</h3></div>"
						+"</div>");
			}
			dateButtonDisabled1();
		},
		
		error:function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
	});
}
//극장별 상영시간표 띄우는 함수 
function opendate1(dayflag, day) {
	var currentDay;
	$(".wrap").empty();
	if(dayflag == 'before') {
		currentDay = new Date(day);
		currentDay = new Date(currentDay.setDate(currentDay.getDate() - 1));
	} else if(dayflag == 'after') {
		currentDay = new Date(day);
		currentDay = new Date(currentDay.setDate(currentDay.getDate() + 1));
	}else {
		currentDay = new Date(day);
		currentDay = new Date(currentDay.setDate(currentDay.getDate()));
	}
	console.log(day);
	console.log(dayflag);
	console.log(currentDay);
	
	var weekName = ['일', '월', '화', '수', '목', '금', '토'];
	var theYear = currentDay.getFullYear();
	var theMonth = currentDay.getMonth();
	var theDate  = currentDay.getDate();
	 
	var thisWeek = [];
	 
	for(var i=0; i<13; i++) {
	  var resultDay = new Date(theYear, theMonth, theDate + i);
	  var yyyy = resultDay.getFullYear();
	  var mm = Number(resultDay.getMonth()) + 1;
	  var dd = resultDay.getDate();
	 
	  mm = String(mm).length === 1 ? '0' + mm : mm;
	  dd = String(dd).length === 1 ? '0' + dd : dd;
	 
	  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
	}

	var day = "";
	
	$(".wrap").append("<button onclick='dayBeforeSetting1()' class='btn-pre' title='이전 날짜 보기'></button>");
	$(".btn-pre").append("<i class='glyphicon glyphicon-chevron-left'></i");
	for(var j=0; j<thisWeek.length; j++) {
		if(weekName[new Date(thisWeek[j]).getDay()] == "토"){
			$(".wrap").append("<button id='tday"+(j+1)+"' class='on sat'type='button' onclick='dateButton1(`"+thisWeek[j]+"`)' value='"+thisWeek[j]+"'>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]+"</button>");
		}else if(weekName[new Date(thisWeek[j]).getDay()] == "일"){			
			$(".wrap").append("<button id='tday"+(j+1)+"' class='on holi'  type='button' onclick='dateButton1(`"+thisWeek[j]+"`)' value='"+thisWeek[j]+"'>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]+"</button>");
		}else {
			$(".wrap").append("<button id='tday"+(j+1)+"' class='on' type='button' onclick='dateButton1(`"+thisWeek[j]+"`)' value='"+thisWeek[j]+"'>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]+"</button>");
		}
	}
	
	$(".wrap").append("<button onclick='dayAfterSetting1()' class='btn-next' title='다음 날짜 보기'></button>");
	$(".btn-next").append("<i class='glyphicon glyphicon-chevron-right'></i");
}

function dayBeforeSetting1() {
	today = new Date();
	today = today.toISOString().slice(0, 10);
	day = $("#tday1").val();
	var checked = $(".wrap").find(".bk").prev().val();
	var attrid = $(".wrap").find(".bk").attr("id");
	var bk = $(".wrap").find(".bk").prev();
	if(day == today) {
		return;
	} else {
		opendate1("before", day);
	}
	
	var day1 = day.substring(0,4) + "-" + day.substring(5,7) +"-" +(String)((Number)(day.substring(8,10)) - 1);
	
	if(bk.attr("disabled")=='disabled') {
		while(true) {
			bk = bk.prev();
			day1 = bk.val();
			day = $("#tday1").val();
			day1 = day.substring(0,4) + "-" 
			+ day.substring(5,7) +"-" 
			+(String)((Number)(day.substring(8,10)) - 1);
			if(bk.attr("disabled")==null) {
				break;
			}
		}
	}
	
	if(attrid == "tday1") {
		dateButton1(day1);	
	}else {
		dateButton1(day);	
	}

}

function dayAfterSetting1() {
	var day = $("#tday1").val();
	var checked = $(".wrap").find(".bk").next().val();
	var bk = $(".wrap").find(".bk").next();

	if(bk.attr("disabled")=='disabled') {
		while(true) {
			bk = bk.next();
			checked = bk.val();
			
			if(bk.attr("disabled")==null) {
				break;
			}
		}
	} 
	opendate1("after", day);
	dateButton1(checked);
}
//극장별 end
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div class="timetable">	
		<div class="timetable-container">
			<div class="movie-choise-area">
				<ul style="margin-left: -10%;">
					<li class="choise_li"><button id="list_movie" onclick="movie()" title="영화별 선택" class="btn" ><span>영화별</span></button></li>
					<li><button id="list_theater" onclick="theater()" title="극장별 선택" class="btn" ><span>극장별</span></button></li>
				</ul>
			</div>
			
			<c:set var="list" value="${List }"/>
			<div class="movie-choise">
				<div class="local">

				</div>
				<br><br>
				<div class="movie-choise1">
					<ul style="list-style: none;">

					</ul>
				</div>
			</div>	
			
			<div class="movieposter">
				<img id="img" src="<%=request.getContextPath() %>/upload/${list[0].getPoster() }">
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
			  <button type="button" class="btn btn1" name="서울" onclick="load('서울',0)">서울</button>
			  <button type="button" class="btn btn1" name="경기" onclick="load('경기',0)">경기</button>
			  <button type="button" class="btn btn1" name="인천" onclick="load('인천',0)">인천</button>
			  <button type="button" class="btn btn1" name="대전/충청/세종" onclick="load('대전/충청/세종',0)">대전/충청/세종</button>
			  <button type="button" class="btn btn1" name="부산/대구/경상" onclick="load('부산/대구/경상',0)">부산/대구/경상</button>
			  <button type="button" class="btn btn1" name="광주/전라" onclick="load('광주/전라',0)">광주/전라</button>
			  <button type="button" class="btn btn1" name="강원" onclick="load('강원',0)">강원</button>
			  <button type="button" class="btn btn1" name="제주" onclick="load('제주',0)">제주</button>
			</div>
			
			<div class="theater-list">
				<div class="theater-list-box">
					<div class="locationInfo">
						<h3 class="localarea">강남</h3>
						<hr width="100%" align="left">
					</div>
					<div class="theater-list-box1">
						
					</div>
	
					
					
				</div>
			</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>