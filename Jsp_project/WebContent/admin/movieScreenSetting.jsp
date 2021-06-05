<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<link href="./css/style.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.8.6/jquery.timepicker.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.8.6/jquery.timepicker.js"></script>


<meta charset="UTF-8">
<title></title>

<script type="text/javascript">

	// 지점 변경시 상영관 변경
	function cinemaSelect(selectValue){ 

		var cinSelect = document.getElementById("cinema_cin");
		$("#cinema_cin").children('option').remove();
		
		console.log("선택 값 - "+selectValue);
		
		var cin_code = selectValue.split(":");
		console.log("첫번째 관 - "+cin_code[1]);
		
		var otxt = "";

		for(var i=1;i<=6;i++) {
			if(cin_code[i] == 1)
			otxt += '<option value="'+i+'">'+i+'관 </option>';
		}
		
		cinSelect.innerHTML= otxt;
		
	}
	
	// 상영 정보 삭제
	function screen_delete(screencode) {
		var con_res = confirm("해당 상영 정보를 삭제하시겠습니까?");
		
		if(con_res == true){
			location.href = "<%=request.getContextPath() %>/movieScreenDelete.do?screencode="+screencode;
		}
	}
	
	// 상영 정보 수정
	function screen_modify(code,starttime,endtime) {
		$("#sc_modify_ok"+code).show();
		$("#sc_modify_cc"+code).show();
		$("#sc_modify"+code).hide();
		
		var srt_time = "";
		
		if(Math.floor(starttime % 60) < 10) {
			srt_time = Math.floor(starttime / 60) + ":0" + Math.floor(starttime % 60);
		} else {
			srt_time = Math.floor(starttime / 60) + ":" + Math.floor(starttime % 60);
		}
		
		var end_time = "";
		
		if(Math.floor(endtime % 60) < 10) {
			end_time = Math.floor(endtime / 60) + ":0" + Math.floor(endtime % 60);
		} else {
			end_time = Math.floor(endtime / 60) + ":" + Math.floor(endtime % 60);
		}
		
		$("#start_time_td_"+code).empty();
		$("#start_time_td_"+code).html("<input type='text' id='new_s_time_"+code+"' name='start_modify' required size='4'>");
		
		$("#end_time_td_"+code).empty();
		$("#end_time_td_"+code).html("<input type='text' id='new_e_time_"+code+"' name='end_modify' required size='4' disabled>");
		
		$("#new_s_time_"+code).timepicker({
			step: 1,
			timeFormat: 'H:i',    
			scrollbar: false
		});
		
		$("#new_s_time_"+code).on('changeTime', function() {
            var new_time = $("#new_s_time_"+code).val();
            endtimeAuto_update(new_time,code);
        });
		
		$("#new_e_time_"+code).timepicker({
			step: 1,
			timeFormat: 'H:i',    
			scrollbar: false
		});
		
		console.log("수정-시작시간:"+srt_time);
		console.log("수정-종료시간:"+end_time);
		
		$("#new_s_time_"+code).timepicker('setTime', srt_time);
		$("#new_e_time_"+code).timepicker('setTime', end_time);

	}
	
	// 상영 정보 수정 취소
	function screen_cancle(code,starttime,endtime) {
		$("#sc_modify_ok"+code).hide();
		$("#sc_modify_cc"+code).hide();
		$("#sc_modify"+code).show();
		
		var srt_time = "";
		
		if(Math.floor(starttime % 60) < 10) {
			srt_time = Math.floor(starttime / 60) + "시 0" + Math.floor(starttime % 60)+"분";
		} else {
			srt_time = Math.floor(starttime / 60) + "시 " + Math.floor(starttime % 60)+"분";
		}
		
		var end_time = "";
		
		if(Math.floor(endtime % 60) < 10) {
			end_time = Math.floor(endtime / 60) + "시 0" + Math.floor(endtime % 60)+"분";
		} else {
			end_time = Math.floor(endtime / 60) + "시 " + Math.floor(endtime % 60)+"분";
		}
		
		$("#start_time_td_"+code).empty();
		$("#start_time_td_"+code).html(srt_time);
		
		$("#end_time_td_"+code).empty();
		$("#end_time_td_"+code).html(end_time);
		
	}
	
	// 상영 정보 수정 확인
	function screen_modify_ok(code) {
		
		var stime = $("#new_s_time_"+code).val();
		var etime = $("#new_e_time_"+code).val();
		
		var sform = document.getElementById("sform");
		
		var i_stime = document.createElement('input');
		var i_etime = document.createElement('input');
		i_stime.setAttribute("type","hidden");
		i_stime.setAttribute("name","start_time");
		i_stime.setAttribute("value",stime);
		i_etime.setAttribute("type","hidden");
		i_etime.setAttribute("name","end_time");
		i_etime.setAttribute("value",etime);
		
		sform.appendChild(i_stime);
		sform.appendChild(i_etime);
		$("#screencode").val(code);
	    sform.submit();
	    
	    $("#sc_modify_ok"+code).hide();
		$("#sc_modify_cc"+code).hide();
		$("#sc_modify"+code).show();
	    
	}
	
	// 페이지 실행 시 자동 함수
	function cinemaAuto(){ 
		console.log("페이지 이동 자동 함수 실행");
		var cinemaSelect = document.getElementById("select_cinema");
		var cinSelect = document.getElementById("cinema_cin");
		
		var selectValue = cinemaSelect.options[cinemaSelect.selectedIndex].value;
		console.log("선택 값 - "+selectValue);
		
		var cin_code = selectValue.split(":");
		
		var otxt = "";

		for(var i=1;i<=6;i++) {
			if(cin_code[i] == 1)
			otxt += '<option value="'+i+'">'+i+'관 </option>';
		}
		
		cinSelect.innerHTML= otxt;
		
	}
	
	// 영화 변경시 러닝타임 변경 / 상영 종료 시간 변경
	function movieSelect(selectValue){ 
		var runningSelect = document.getElementById("running_time");
		var runningTimeStr = selectValue.split(":");
		$("#running_time").children('running_input').remove();
		
		runningSelect.innerHTML = "<input id='running_input' required size='3' value='"+runningTimeStr[1]+"' disabled>분";
		
		endtimeAuto("movie_change");
	}
	
	// 상영 종료 시간 조절 함수
	function endtimeAuto(flag) {
		console.log(flag);
		var running_data = document.getElementById("running_input");
		var running = running_data.value;
		
		var time_pick = document.getElementById("timepick_start");
		var time_data = time_pick.value.split(":");
		var hour = Number(time_data[0])+Math.floor(running / 60);
		var min = Number(time_data[1])+Math.floor(running % 60);
		
		if(min > 59) {
			hour++;
			min = min-60;
		}
		
		var end_time = "";
		
		if(min < 10) {
			end_time = hour + ":0" + min;
		} else {
			end_time = hour + ":" + min;
		}
		console.log("셋팅 데이터 :"+end_time);
		
		if(flag == 'open')	{
			$("#timepick_end").timepicker({
				step: 1,
				timeFormat: 'H:i',
				scrollbar: false
			});
			
			$("#timepick_end").timepicker('setTime', end_time);
		} else if(flag = 'movie_change') {
			$("#timepick_end").timepicker('setTime', end_time);
		}
	}
	
	// 시작 시간 변경 시 종료 시간 조절 함수
	function endtimeAuto_change(new_time) {
		console.log("시작 시간 변경");
		var running_data = document.getElementById("running_input");
		var running = running_data.value;
		
		var time_data = new_time.split(":");
		var hour = Number(time_data[0])+Math.floor(running / 60);
		var min = Number(time_data[1])+Math.floor(running % 60);
		
		if(min > 59) {
			hour++;
			min = min-60;
		}
		
		var end_time = "";
		
		if(min < 10) {
			end_time = hour + ":0" + min;
		} else {
			end_time = hour + ":" + min;
		}
		
		console.log("셋팅 데이터 :"+end_time);

		$("#timepick_end").timepicker('setTime', end_time);
	}
	
	// 영화 상영 목록 수정 시 상영 종료 시간 셋팅
	function endtimeAuto_update(new_time,code) {
		console.log("영화 상영 목록 수정");
		var running_data = document.getElementById("s_running"+code);
		var running = running_data.value;
		
		var time_data = new_time.split(":");
		var hour = Number(time_data[0])+Math.floor(running / 60);
		var min = Number(time_data[1])+Math.floor(running % 60);
		
		if(min > 59) {
			hour++;
			min = min-60;
		}
		
		var end_time = "";
		
		if(min < 10) {
			end_time = hour + ":0" + min;
		} else {
			end_time = hour + ":" + min;
		}
		
		console.log("셋팅 데이터 :"+end_time);

		$("#new_e_time_"+code).timepicker('setTime', end_time);
	}
	
	$(document).ready(function() {
		cinemaAuto();
		
		$('#timepick_start').timepicker({
			step: 1,				 //시간 간격
			timeFormat: 'H:i',       //시간:분 으로표시
			scrollbar: false
		});
		
		$("#timepick_start").timepicker('setTime', new Date());
		
		$('#timepick_start').on('changeTime', function() {
            var new_time = $('#timepick_start').val();
            endtimeAuto_change(new_time);
        });
		
		$(".sc_modify_ok").hide();
		$(".sc_modify_cc").hide();

		endtimeAuto("open");
		
    });
	
	

</script>

</head>

<body>
	<jsp:include page="../include/mheader.jsp" />
	
	<!-- 새로운 상영 영화 추가 -->
	<div class="container"> 
	<p>영화 상영 추가</p>
	<form method="post" action="<%=request.getContextPath() %>/movieScreenInsert.do">
		<table class="table table-hover"> 
			<thead>
				<tr> 
					<th>영화명(코드)</th> 
					<th>러닝 타임</th> 
					<th>상영 지점</th> 
					<th>상영관</th> 
					<th>상영 시작 시간</th> 
					<th>상영 종료 시간</th> 
					<th>추가</th>
				</tr> 
			</thead> 
			<tbody>
				<tr> 
					<td>
						<select id="select_movie" name="movie_code" onchange="movieSelect(this.value)">
		                  <c:if test="${empty movielist }">
		                     <option value="">:::저장된 영화 없음:::</option>
		                  </c:if>
		                  
		                  <c:if test="${!empty movielist }">
		                     <c:forEach items="${movielist }" var="mdto">
		                        <option value="${mdto.moviecode }:${mdto.running_time }">${mdto.title_ko } [${mdto.moviecode }]</option>
		                     </c:forEach>
		                  </c:if>
		               </select>
	               	</td>
	               	
	               	<td id="running_time">
	               		<input id="running_input" required size="3" value="${movielist.get(0).running_time }" disabled>분
	               	</td>
	               	
	               	<td>
						<select id="select_cinema" name="cinema_code" onchange="cinemaSelect(this.value)">
		                  <c:if test="${empty cinemalist }">
		                     <option value="">:::상영 지점 없음:::</option>
		                  </c:if>
		                  
		                  <c:if test="${!empty cinemalist }">
		                     <c:forEach items="${cinemalist }" var="cdto">
		                        <option value="${cdto.cinemacode }:${cdto.one_cin }:${cdto.two_cin }:${cdto.three_cin }:${cdto.four_cin }:${cdto.five_cin }:${cdto.six_cin }">
		                        	${cdto.cinemaname } [${cdto.cinemacode }]</option>
		                     </c:forEach>
		                  </c:if>
		               </select>
	               	</td>
	               	
	               	<td>
					   <select id="cinema_cin" name="cinema_cin">
						  	
		               </select>
	               	</td>
	               	
	               	<td>
	               		<input type="text" class="timepicker" name="start_time" placeholder="시간 선택" id="timepick_start" 
	               			required size="4" maxlength="4">

	               	</td>
	               	
	               	<td>
	               		<input type="text" class="timepicker" name="end_time" placeholder="시간 선택" id="timepick_end" 
	               			required size="4" maxlength="4" disabled>

	               	</td>
	               	
	               	<td>
	               		<input type="submit" value="추가">
	               	</td>
	               	 
				</tr> 
	
			</tbody>
		</table>
	</form>
	</div>
	
	<br><br>
	
	<!-- 현재 상영 설정된 영화 목록 -->
	<div class="container"> 
	<p>영화 상영 목록</p>
	<form method="post" name="frm" id="sform" action="<%=request.getContextPath() %>/movieScreenUpdate.do">
		<table class="table table-hover"> 
			<thead>
				<tr>
					<th>상영코드</th>
					<th>영화명(코드)</th> 
					<th>상영 지점</th> 
					<th>상영관</th> 
					<th>상영 시작 시간</th> 
					<th>상영 종료 시간</th> 
					<th>수정</th>
					<th>삭제</th>
				</tr> 
			</thead> 
			<tbody>
				<c:forEach items="${screenlist }" var="screen">
					<tr> 
						<td> ${screen.screencode } </td>
						<td>
		                  <c:if test="${!empty movielist }">
		                     <c:forEach items="${movielist }" var="moviedto">
		                        	<c:if test="${moviedto.moviecode == screen.moviecode }">
		                        		${moviedto.title_ko } [${moviedto.moviecode }]
		                        		<input type="hidden" id="s_running${screen.screencode }" value="${moviedto.running_time }">
		                        	</c:if>
		                     </c:forEach>
		                  </c:if>
		               	</td>
		               	
		               	<td>
		                  <c:if test="${!empty cinemalist }">
		                     <c:forEach items="${cinemalist }" var="cinemadto">
		                        	<c:if test="${cinemadto.cinemacode == screen.cinemacode }">
		                        		${cinemadto.cinemaname } [${cinemadto.cinemacode }]
		                        	</c:if>
		                     </c:forEach>
		                  </c:if>
		               	</td>
		               	
		               	<td> ${screen.cincode }관 </td>
		               	
		               	<td id="start_time_td_${screen.screencode }">
		               		<%-- <input type="time" class="timepicker" name="start_time">--%>
		               		<fmt:parseNumber value="${(screen.start_time / 60) }" integerOnly="true" />시
		               		<fmt:parseNumber value="${(screen.start_time % 60) }" integerOnly="true" />분
		               	</td>
		               	
		               	<td id="end_time_td_${screen.screencode }">
		               		<%--<input type="time" class="timepicker" name="end_time">--%>
		               		<fmt:parseNumber value="${(screen.end_time / 60) }" integerOnly="true" />시
		               		<fmt:parseNumber value="${(screen.end_time % 60) }" integerOnly="true" />분
		               	</td>
		               	
		               	<td>
			               		<input type="button" id="sc_modify${screen.screencode }"
			               			value="수정" onclick="screen_modify(${screen.screencode },${screen.start_time },${screen.end_time })">
			               		<input type="button" id="sc_modify_cc${screen.screencode }" class="sc_modify_cc"
			               			value="취소" onclick="screen_cancle(${screen.screencode },${screen.start_time },${screen.end_time })">
			               		<input type="button" id="sc_modify_ok${screen.screencode }" class="sc_modify_ok"
			               			value="확인" onclick="screen_modify_ok(${screen.screencode })">
		               		
		               			<input type="hidden" name="moviecode" value="${screen.moviecode }">
		               			<input type="hidden" name="screencode" id="screencode"> 
		               			<input type="hidden" name="cincode" value="${screen.cincode }"> 
		               			<input type="hidden" name="cinemacode" value="${screen.cinemacode }"> 
		               	</td>
		               	<td>
	               			<input type="button" value="삭제" onclick="screen_delete(${screen.screencode })">
		               	</td>
					</tr> 
				</c:forEach>
			</tbody>
		</table>
		</form>
	</div>
	
	
	
</body>
</html>