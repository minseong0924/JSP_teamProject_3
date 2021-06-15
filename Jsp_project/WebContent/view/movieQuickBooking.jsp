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
	var selectDay = "";
	var selectMovie = "";

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
			
			day += "<button type='button' class='list-group-item list-group-item-action list-group-item-info' "
			        + "onclick=\"dayBaseScreenOpen('"+thisday+"','day"+(j+1)+"')\""
					+ "id='day"+(j+1)+"' value='"+thisWeek[j]+"'>"
					+ "<span>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]
					+ "</span>"
					+ "</button>";
		}
		
		day = "<button type='button' class='list-group-item list-group-item-action list-group-item-info' "
				+ "onclick='dayBeforeSetting()' id='before_btn'><i class='glyphicon glyphicon-chevron-left'></i></button>"
				+ day
				+ "<button type='button' class='list-group-item list-group-item-action list-group-item-info' "
				+ "onclick='dayAfterSetting()' id='after_btn'><i class='glyphicon glyphicon-chevron-right'></i> </button>";
		
		$("#header_day").html(day);
	}
	
	// 날짜 이전 버튼 클릭 시(현재 날짜인 경우 더는 앞으로 가지 않음)
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
	
	// 날짜 다음 버튼 클릭 시
	function dayAfterSetting() {
		var day = $("#day1").val();
		daySetting("after", day);
	}
	
	// 영화 기준 상영영화 조회
	function movieSelect(moviecode){
		selectMovie = moviecode;

		var movieExist = false;
		console.log("movie:"+moviecode);
		console.log("thisday:"+today);
		
		$.ajax({
			type:"post",
			url: "/Jsp_project/screenListOpen.do",
			dataType: "json",
			async: false,
			data: {
					"flag" : "dayBase",
				    "value" : $("#day1").val(),
				    "code" : 0
				  },
			success: function(data) {
				var screenlist = data.slist;
				for(var i=0; i<screenlist.length; i++) {
					if(moviecode == screenlist[i].moviecode) {
						// 선택한 영화가 오늘 날짜로 상영 정보에 있을 경우 true를 반환
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
		
		if((selectDay == "") && !movieExist) {
			// 선택한 날짜가 없고, 선택한 극장이 없고, 영화가 오늘 날짜의 상영 정보에 없는 영화인 경우 : 제일 빠른 상영일로 셋팅
			if(confirm("해당 영화는 오늘 상영 시간표가 없습니다.\n선택하신 영화의 가장 빠른 예매일로 변경하시겠습니까?")){
				$.ajax({
					type:"post",
					url: "/Jsp_project/screenListOpen.do",
					dataType: "json",
					async: false,
					data: {
							"flag" : "movieBase",
						    "value" : moviecode,
						    "code" : 0
						  },
					success: function(data) {
						var screenlist = data.slist;
						var movieBtGroup = $("#movielist_div").children("button");
						var dayGroup = $("#header_day").children("button");
						var min_start_date = "";
						var movie_poster = "";
						var movie_name = "";
						
						allDisabled();
						$(".cinema_detail").hide();
					
						for(var i=0; i<screenlist.length; i++) {
						
							// 상영 정보 목록 초기화
							$("#screen_div").empty();
							
							// data로 받은 목록에  있는 영화만 활성화
							$("#screenmovie"+screenlist[i].moviecode).attr('disabled', false);
							
							// data로 받은 목록에  없는 지역/극장이면 활성화
							$("#screenlocal"+screenlist[i].localcode).attr('disabled', false);
							$("#screencinema"+screenlist[i].cinemacode).attr('disabled', false);
							
							// 선택한 영화의 상영 시작일 무작위 저장
							// 포스터 경로, 제목 저장
							if(moviecode == screenlist[i].moviecode) {
								min_start_date = screenlist[i].start_date;
								movie_poster = screenlist[i].poster;
								movie_name = screenlist[i].moviename;
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
						
						$("#day1").addClass('active');
						
						// 선택 영화 포스터, 영화 제목 하단에 추가
						var addHtml = "<img src='upload/"+movie_poster+"' alt='이미지가없습니다' width='60' height='90'>";
						addHtml += "<font color='blue'> "+movie_name+"</font>";
						addHtml += "<button type='button' class='btn btn-default' onclick='selectCancel()'>X</button>";
						$("#select_movie_under").html(addHtml);
						
					},
					error: function(request,status,error){
				       alert("error!!!");
					}
				});
			}
		} else if((selectDay == "") && movieExist) {
			// 선택한 날짜/극장이 없고, 영화가 오늘 날짜의 상영 정보에 있는 영화인 경우 : 오늘 날짜를 기준으로 상영정보 가져오기
			$.ajax({
				type:"post",
				url: "/Jsp_project/screenListOpen.do",
				dataType: "json",
				async: false,
				data: {
						"flag" : "dayBase_re",
					    "value" : today,
					    "code" : moviecode
					  },
				success: function(data) {
					var screenlist = data.slist;
					var movie_poster = "";
					var movie_name = "";
					
					allDisabled();
					$(".cinema_detail").hide();
				
					for(var i=0; i<screenlist.length; i++) {
					
						// 상영 정보 목록 초기화
						$("#screen_div").empty();
						
						// data로 받은 목록에  있는 영화만 활성화
						$("#screenmovie"+screenlist[i].moviecode).attr('disabled', false);
						
						// data로 받은 목록에  없는 지역/극장이면 활성화
						$("#screenlocal"+screenlist[i].localcode).attr('disabled', false);
						$("#screencinema"+screenlist[i].cinemacode).attr('disabled', false);
						
						// 선택한 영화의 상영 시작일 무작위 저장
						// 포스터 경로, 제목 저장
						if(moviecode == screenlist[i].moviecode) {
							min_start_date = screenlist[i].start_date;
							movie_poster = screenlist[i].poster;
							movie_name = screenlist[i].moviename;
						}
					
					}

					// 선택 영화 포스터, 영화 제목 하단에 추가
					var addHtml = "<img src='upload/"+movie_poster+"' alt='이미지가없습니다' width='60' height='90'>";
					addHtml += "<font color='blue'> "+movie_name+"</font> ";
					addHtml += "<button type='button' class='btn btn-default' onclick='selectCancel()'>X</button>";
					$("#select_movie_under").html(addHtml);
				},
				error: function(request,status,error){
			       alert("error!!!");
				}
			});
			
		} else if(selectDay != ""){
			// 날짜를 선택하여 리스트가 이미 셋팅된 경우 : 영화 단독 조회
			$.ajax({
				type:"post",
				url: "/Jsp_project/screenListOpen.do",
				dataType: "json",
				async: false,
				data: {
						"flag" : "movieBase_re",
					    "value" : selectDay,
					    "code" : moviecode
					  },
				success: function(data) {
					var screenlist = data.slist;
					var movie_poster = "";
					var movie_name = "";
					
					// 선택한 영화 빼고 모두 disable
					allDisabled();
					$(".cinema_detail").hide();
				
					for(var i=0; i<screenlist.length; i++) {
					
						// 상영 정보 목록 초기화
						$("#screen_div").empty();
						
						// data로 받은 목록에  있는 영화만 활성화
						$("#screenmovie"+screenlist[i].moviecode).attr('disabled', false);
						
						// data로 받은 목록에  없는 지역/극장이면 활성화
						$("#screenlocal"+screenlist[i].localcode).attr('disabled', false);
						$("#screencinema"+screenlist[i].cinemacode).attr('disabled', false);
					
					}
					
					movie_poster = screenlist[0].poster;
					movie_name = screenlist[0].moviename;
					
					// 선택 영화 포스터, 영화 제목 하단에 추가
					var addHtml = "<img src='upload/"+movie_poster+"' alt='이미지가없습니다' width='60' height='90'>";
					addHtml += "<font color='blue'> "+movie_name+"</font> ";
					addHtml += "<button type='button' class='btn btn-default' onclick='selectCancel()'>X</button>";
					$("#select_movie_under").html(addHtml);
				},
				error: function(request,status,error){
			       alert("error!!!");
				}
			});
			
		}
		
	}
	
	// 날짜기준 상영 영화 조회
	function dayBaseScreenOpen(day, dayID) {
		
		// 선택한 영화가 있으면
		if($('#select_movie_under').children().length != 0){
			 if(confirm('이미 선택한 영화가 있습니다. 취소하고 날짜 기준으로 조회하시겠습니까?')) {
				 
			 } else{
				 return;
			 }
		}
		
		selectDay = day;
		
		$.ajax({
			type:"post",
			url: "/Jsp_project/screenListOpen.do",
			dataType: "json",
			data: {
					"flag" : "dayBase",
				    "value" : day,
				    "code" : 0
				  },
			success: function(data) {
				screenlist = data.slist;
				allDisabled();
				$(".cinema_detail").hide();
				$("#header_day").children("button").attr('disabled', false);
				$("#header_day").children("button").removeClass('active');
				$("#"+dayID).addClass('active');
				$('#select_movie_under').empty();
				
				for(var i=0; i<screenlist.length; i++) {
					
					// 상영 정보 목록 초기화
					$("#screen_div").empty();
					
					// data로 받은 목록에  있는 영화만 활성화
					$("#screenmovie"+screenlist[i].moviecode).attr('disabled', false);
					
					// data로 받은 목록에  없는 지역/극장이면 활성화
					$("#screenlocal"+screenlist[i].localcode).attr('disabled', false);
					$("#screencinema"+screenlist[i].cinemacode).attr('disabled', false);
					
				}
			},
			error: function(request,status,error){
		       // alert("code:"+request.status+"\n"
		       // 		+"message:"+request.responseText+"\n"+"error:"+error);
		       alert("error!!!");
			}
		});
	}
	
	function allDisabled() {
		var movieBtGroup = $("#movielist_div").children("button");
		movieBtGroup.attr('disabled', true);
		var localBtGroup = $("#local_list").children("button");
		localBtGroup.attr('disabled', true);
		var cinemaBtGroup = $(".cinema_detail").children("button");
		cinemaBtGroup.attr('disabled', true);
	}
	
	// 영화 선택 취소
	function selectCancel() {
		selectMovie = "";
		if(selectDay == "") {
			$("#header_day").children("button").removeClass('active');;
			$("#day1").addClass('active');
			
			$.ajax({
				type:"post",
				url: "/Jsp_project/screenListOpen.do",
				dataType: "json",
				async: false,
				data: {
						"flag" : "dayBase",
					    "value" : $("#day1").val(),
					    "code" : 0
					  },
				success: function(data) {
					screenlist = data.slist;
					allDisabled();
					$(".cinema_detail").hide();
					$("#select_cinema_under").empty();
					$("#select_movie_under").empty();
					
					for(var i=0; i<screenlist.length; i++) {
						
						// 상영 정보 목록 초기화
						$("#screen_div").empty();
						
						// data로 받은 목록에  있는 영화만 활성화
						$("#screenmovie"+screenlist[i].moviecode).attr('disabled', false);
						
						// data로 받은 목록에  없는 지역/극장이면 활성화
						$("#screenlocal"+screenlist[i].localcode).attr('disabled', false);
						$("#screencinema"+screenlist[i].cinemacode).attr('disabled', false);
						
					}
				},
				error: function(request,status,error){
			       alert("error!!!");
				}
			});
		} else {
			$.ajax({
				type:"post",
				url: "/Jsp_project/screenListOpen.do",
				dataType: "json",
				async: false,
				data: {
						"flag" : "dayBase",
					    "value" : selectDay,
					    "code" : 0
					  },
				success: function(data) {
					screenlist = data.slist;
					allDisabled();
					$(".cinema_detail").hide();
					$("#select_cinema_under").empty();
					$("#select_movie_under").empty();
					
					for(var i=0; i<screenlist.length; i++) {
						
						// 상영 정보 목록 초기화
						$("#screen_div").empty();
						
						// data로 받은 목록에  있는 영화만 활성화
						$("#screenmovie"+screenlist[i].moviecode).attr('disabled', false);
						
						// data로 받은 목록에  없는 지역/극장이면 활성화
						$("#screenlocal"+screenlist[i].localcode).attr('disabled', false);
						$("#screencinema"+screenlist[i].cinemacode).attr('disabled', false);
						
					}
				},
				error: function(request,status,error){
			       alert("error!!!");
				}
			});
		}
	}
		
	//극장 기준 조회
	function cinemaSelect(cinemacode, cinemaname) {
		console.log("cinemacode: "+cinemacode);
		console.log("cinemaname: "+cinemaname);
		$("#select_cinema_under").html("<font color='blue'>"+cinemaname+"</font>");
		
		var cinemaDay = "";
		
		console.log("selectDay: "+selectDay);
		// 선택했던 날짜 값이 있으면 선택 날짜로 조회
		if(selectDay == "") {
			if($("#day1").val() > today) {
				cinemaDay = $("#day1").val();
			} else {
				cinemaDay = today;
			}
		} else {
			cinemaDay = selectDay;
		}
		console.log("cinemaDay: "+cinemaDay);
		
		$.ajax({
			type:"post",
			url: "/Jsp_project/screenListOpen.do",
			dataType: "json",
			data: {
					"flag" : "cinemaBase",
				    "value" : cinemaDay+":"+selectMovie,
				    "code" : cinemacode
				  },
			success: function(data) {
				var slist = data.slist;
				var appendHtml = "";
				
				// 상영 정보 버튼 셋팅
				appendHtml = "<ul class='list-group' style='list-style:none; padding-left: 5px;'>";
				
				for(var i=0; i<slist.length; i++) {
					
					var srt_time = slist[i].start_time;
					
					if(Math.floor(srt_time % 60) < 10) {
						srt_time = Math.floor(srt_time / 60) + ":0" + Math.floor(srt_time % 60);
					} else {
						srt_time = Math.floor(srt_time / 60) + ":" + Math.floor(srt_time % 60);
					}
					
					var end_time = slist[i].end_time;
					
					// 0시 이후
					if(end_time >= 1440) {
						end_time = end_time - 1440;
					}
					
					if(Math.floor(end_time % 60) < 10) {
						end_time = Math.floor(end_time / 60) + ":0" + Math.floor(end_time % 60);
					} else {
						end_time = Math.floor(end_time / 60) + ":" + Math.floor(end_time % 60);
					} 
	
			        appendHtml += "<li class='list-group-item list-group-item-action'>";
			        appendHtml += "<div style='width:490px;' align='left'>";
			        appendHtml += "<button type='button' class='btn' "
			        appendHtml += "onclick='booking("+slist[i].screencode+")'>";
			        appendHtml += "<div style='float:left;' align='left'>";
				
			        appendHtml += "<div class='time' style='float:left; width:60px;'>";
			        appendHtml += "<strong title='상영 시작'>"+srt_time+"</strong>";
			        appendHtml += "<em title='상영 종료'><br>~"+end_time+"</em>";
			        appendHtml += "</div>";

			        appendHtml += "<div class='movie_title' style='float:left; width:360px;'>";
		            appendHtml += "<strong title='영화명'>"+slist[i].moviename+"</strong>";
		            appendHtml += "<br><em>"+slist[i].mtype+"</em>";
			        appendHtml += "</div>";

			        appendHtml += "<div class='theater' style='float:left; width:30px;' title='극장'>";
			        appendHtml += ""+slist[i].cinemaname+"<br />"+slist[i].cincode+"관";
			        appendHtml += "</div>";

			        appendHtml += "</div>";
			        appendHtml += "</button>";
			        appendHtml += "</div>";
			        appendHtml += "</li>";
					    
				}
				
				appendHtml += "</ul>";
			    
			    $("#screen_div").html(appendHtml);
			},
			error: function(request,status,error){
		       // alert("code:"+request.status+"\n"
		       // 		+"message:"+request.responseText+"\n"+"error:"+error);
		       alert("error!!!");
			}
		});
	}
	
	function booking(screencode) {
		location.href="<%=request.getContextPath()%>/movieBookingReady.do?screencode="+screencode;
	}
	
	$(document).ready(function() {
		$(".cinema_detail").hide();
		
		daySetting("open");
		
		$("#day1").addClass('active');
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
			                      onclick="movieSelect(${mdto.moviecode })"
			                      class="list-group-item list-group-item-action list-group-item-info">${mdto.title_ko }</button>
		                   </c:forEach>
		                </c:if>
					  </div>
					</div>
				</td>
				<td style="width:150px;"><span class="booking_title">극장</span>
					<div class="booking_list panel panel-default" align="left">
					  <div id="local_list" class="list-group">
					  	<c:if test="${!empty locallist }">
		                   <c:forEach items="${locallist }" var="ldto">
		                   		<button type="button" 
			                      id="screenlocal${ldto.localcode }"
			                      value="${ldto.localcode }"
			                      onclick="selectLocal(${ldto.localcode })"
			                      class="list-group-item list-group-item-action list-group-item-info">${ldto.localname }</button>
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
									<button type="button" 
				                      id="screencinema${cdto.cinemacode }"
				                      value="${cdto.cinemacode }"
				                      onclick="cinemaSelect(${cdto.cinemacode },'${cdto.cinemaname }')"
				                      class="list-group-item list-group-item-action list-group-item-info">${cdto.cinemaname }</button>
			                	</c:if>
				            </c:forEach>
				            </div>
			            </c:forEach>
		            </div>
				</td>
				<td style="width:500px;" rowspan="2"><span class="booking_title">시간</span>
					<div class="booking_list panel panel-default">
					  <div id="screen_div" class="list-group" style="height:400px; overFlow : auto;">
					    	영화와 극장을 선택하시면 상영시간표를 비교하여 볼 수 있습니다.
					  </div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="height:250px;" id="select_movie_under"></td>
				<td style="height:250px;" id="select_cinema_under" colspan="2"></td>
			</tr>
		</table>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>