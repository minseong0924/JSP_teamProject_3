<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빠른 예매</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	var today = new Date();
	today = today.toISOString().slice(0, 10);

	//지역 선택시 지점 출력
	function selectLocal(localcode) {
		$(".cinema_detail").hide();
		$("#cinema_detail"+localcode).show();
	}
	
	//상단바 날짜 설정
	function daySetting(dayflag, day) {
		var currentDay;
		
		if(dayflag =='open') {
			currentDay = new Date();  
		} else if(dayflag == 'before') {
			$("#header_day").empty();
			currentDay = new Date(day);
			currentDay = new Date(currentDay.setDate(currentDay.getDate() - 1));
		} else if(dayflag == 'after') {
			$("#header_day").empty();
			currentDay = new Date(day);
			currentDay = new Date(currentDay.setDate(currentDay.getDate() + 1));
		} else if(dayflag == 'movie') {
			$("#header_day").empty();
			currentDay = new Date(day);
			currentDay = new Date(currentDay.setDate(currentDay.getDate()));
		}
		
		console.log(currentDay);
		
		var weekName = ['일', '월', '화', '수', '목', '금', '토'];
		var theYear = currentDay.getFullYear();
		var theMonth = currentDay.getMonth();
		var theDate  = currentDay.getDate();
		 
		var thisWeek = [];
		 
		for(var i=0; i<10; i++) {
		  var resultDay = new Date(theYear, theMonth, theDate + i);
		  var yyyy = resultDay.getFullYear();
		  var mm = Number(resultDay.getMonth()) + 1;
		  var dd = resultDay.getDate();
		 
		  mm = String(mm).length === 1 ? '0' + mm : mm;
		  dd = String(dd).length === 1 ? '0' + dd : dd;
		 
		  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
		}
		 
		console.log(thisWeek);
		
		var day = "";
		
		for(var j=0; j<thisWeek.length; j++) {
			var thisday = new Date(thisWeek[j]);
			thisday = thisday.toISOString().slice(0, 10);
			
			day += "<button type='button' class='list-group-item list-group-item-action' "
			        + "onclick=\"dayBaseScreenOpen('"+thisday+"')\" "
					+ "id='day"+(j+1)+"' value='"+thisWeek[j]+"'>"
					+ "<span>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]
					+ "</span>"
					+ "</button>";
		}
		
		day = "<button type='button' class='list-group-item list-group-item-action' "
				+ "onclick='dayBeforeSetting()' id='before_btn'><i class='glyphicon glyphicon-chevron-left'></i></button>"
				+ day
				+ "<button type='button' class='list-group-item list-group-item-action' "
				+ "onclick='dayAfterSetting()' id='after_btn'><i class='glyphicon glyphicon-chevron-right'></i> </button>";
		
		$("#header_day").html(day);
	}
	
	function dayBeforeSetting() {
		var today = new Date();
		today = today.toISOString().slice(0, 10);
		var day = $("#day1").val();
		
		if(day == today) {
			return;
		} else {
			daySetting("before", day);
		}
	}
	
	function dayAfterSetting() {
		var day = $("#day1").val();
		daySetting("after", day);
	}
	
	function movieSelct(moviecode){
		var thisday = new Date();
		thisday = thisday.toISOString().slice(0, 10);
		var movieExist = false;
		console.log("movie:"+moviecode);
		console.log("thisday:"+thisday);
		// 선택한 표시
		$("#screenmovie"+moviecode).addClass("active");
		
		$.ajax({
			type:"post",
			url: "/Jsp_project/screenListOpen.do",
			dataType: "json",
			async: false,
			data: {
					"flag" : "dayBase",
				    "value" : thisday
				  },
			success: function(data) {
				var screenlist = data.slist;
				for(var i=0; i<screenlist.length; i++) {
					if(moviecode == screenlist[i].moviecode) {
						// 선택한 영화가 상영 정보에 있는 영화일 경우 true를 반환
						movieExist = true;
						break;
					}
				}
			},
			error: function(request,status,error){
		       alert("error!!!");
			}
		});
		
		console.log("movieExist:"+movieExist);
		
		if(!movieExist) {
			// 선택한 영화가 상영 정보에 없는 영화인 경우 : 제일 빠른 상영일로 셋팅
			if(confirm("해당 일자에 상영 시간표가 없습니다.\n선택하신 영화의 가장 빠른 예매일로 변경하시겠습니까?")){
				$.ajax({
					type:"post",
					url: "/Jsp_project/screenListOpen.do",
					dataType: "json",
					async: false,
					data: {
							"flag" : "movieBase",
						    "value" : moviecode
						  },
					success: function(data) {
						var screenlist = data.slist;
						var movieBtGroup = $("#movielist_div").children("button");
						var dayGroup = $("#header_day").children("button");
						var min_start_date = "";
						
						for(var i=0; i<screenlist.length; i++) {
							for(var m=0; m<movieBtGroup.length; m++) {
								console.log("moviecode: "+screenlist[i].moviecode
											+" start: "+screenlist[i].start_date
											+" end: "+screenlist[i].end_date);
							}
							
							// 선택한 영화의 상영 시작일 무작위 저장
							if(moviecode == screenlist[i].moviecode) {
								min_start_date = screenlist[i].start_date;
							}
							
						}
						
						// 선택한 영화의 상영 시작일 중 가장 빠른 날짜 저장.
						for(var i=0; i<screenlist.length; i++) {
							if(moviecode == screenlist[i].moviecode) {
								if(min_start_date > screenlist[i].start_date) {
									min_start_date = screenlist[i].start_date;
								}
							}
						}
						
						console.log("min_start_date: "+min_start_date);
						
						// 가장 빠른 상영 시작일이 과거(오늘 이전)일 경우 오늘 날짜로 셋팅
						// 그렇지 않은 경우 DB에서 가져온 상영 시작일로 셋팅
						if(min_start_date >= today) {
							daySetting("movie", min_start_date);
						} else {
							daySetting("movie", today);
						}
						
						// 날짜 버튼을 새로 그려줬으므로 리셋팅
						dayGroup = $("#header_day").children("button");
						dayGroup.attr('disabled', true);
						
						// 상영 날짜에 따른 날짜 버튼 disable/able 셋팅
						for(var i=0; i<screenlist.length; i++) {
							if(moviecode == screenlist[i].moviecode) {
								for(var d=1; d<dayGroup.length -1; d++) {
									console.log("dayGroup.eq("+d+").val(): "+dayGroup.eq(d).val());
									console.log("screenlist["+i+"].start_date: "+screenlist[i].start_date);
									console.log("screenlist["+i+"].end_date: "+screenlist[i].end_date);
									if(dayGroup.eq(d).val() >= screenlist[i].start_date && 
											dayGroup.eq(d).val() <= screenlist[i].end_date) {
										dayGroup.eq(d).attr('disabled', false);
									}
								}
							}
						}
						
						// 영화를 선택하면 다음 날짜로 넘기기 금지
						$("#after_btn").attr('disabled', true);
					},
					error: function(request,status,error){
				       alert("error!!!");
					}
				});
			} else {
				// 선택한 영화가 상영 정보에 있는 영화인 경우 : 오늘 날짜를 기준으로 상영정보 가져오기
				
			}
		}
		
	}
	
	function dayBaseScreenOpen(day) {
		
		$.ajax({
			type:"post",
			url: "/Jsp_project/screenListOpen.do",
			dataType: "json",
			data: {
					"flag" : "dayBase",
				    "value" : day
				  },
			success: function(data) {
				screenlist = data.slist;
				var movieBtGroup = $("#movielist_div").children("button");
				movieBtGroup.attr('disabled', true);
				
				for(var i=0; i<screenlist.length; i++) {
					for(var m=0; m<movieBtGroup.length; m++) {
						if(movieBtGroup.eq(m).val() == screenlist[i].moviecode) {
							$("#screenmovie"+screenlist[i].moviecode).attr('disabled', false);
						}
					}
				}
			},
			error: function(request,status,error){
		       // alert("code:"+request.status+"\n"
		       // 		+"message:"+request.responseText+"\n"+"error:"+error);
		       alert("error!!!");
			}
		});
	}
	
	$(document).ready(function() {
		$(".cinema_detail").hide();
		
		daySetting("open");
    });
</script>

</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div align="center" style="min-width:1100px;">
		<div id="header_day" align="center" class="list-group list-group-horizontal-md" role="group">
		</div>
		<table class="table">
			<tr>
				<td style="width:300px;"><span class="booking_title">영화</span>
					<div class="booking_list panel panel-default" align="left">
					  <div id="movielist_div" class="list-group list-group-flush" role="group">
					  	<c:if test="${!empty movielist }">
		                   <c:forEach items="${movielist }" var="mdto">
		                      <button type="button" 
			                      id="screenmovie${mdto.moviecode }"
			                      value="${mdto.moviecode }"
			                      onclick="movieSelct(${mdto.moviecode })"
			                      class="list-group-item list-group-item-action">${mdto.title_ko }</button>
		                   </c:forEach>
		                </c:if>
					  </div>
					</div>
				</td>
				<td style="width:150px;"><span class="booking_title">극장</span>
					<div class="booking_list panel panel-default" align="left">
					  <div class="list-group">
					  	<c:if test="${!empty locallist }">
		                   <c:forEach items="${locallist }" var="ldto">
			                      <a href="javascript:selectLocal(${ldto.localcode });" class="list-group-item">${ldto.localname }</a>
			               </c:forEach>
		                </c:if>
					  </div>
					</div>
				</td>
				<td style="width:150px;"> <br>
					<div class="booking_list panel panel-default" align="left">
						<c:forEach items="${locallist }" var="local">
							<div id="cinema_detail${local.localcode }" class="cinema_detail list-group">
							<c:forEach items="${cinemalist }" var="cdto">
								<c:if test="${local.localcode == cdto.localcode }">
			                		<a href="#" class="list-group-item">${cdto.cinemaname }</a>
			                	</c:if>
				            </c:forEach>
				            </div>
			            </c:forEach>
		            </div>
				</td>
				<td style="width:500px;" rowspan="2"><span class="booking_title">시간</span>
					<div class="booking_list panel panel-default">
					  <div class="list-group" style="height:400px;">
					    영화와 극장을 선택하시면 상영시간표를 비교하여 볼 수 있습니다.
					  </div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="height:250px;" id="select_movie_under">선택한 영화</td>
				<td style="height:250px;" id="select_cinema_under" colspan="2">선택한 극장</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>