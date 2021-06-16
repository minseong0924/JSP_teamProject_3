<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	
	// 관람 인원 총 합계
	var select_person = 0;
	
	// 인원 선택 (4명까지)
	function selectPerson(btn) {
		// 누른 버튼의 클래스 값
		var btn_class = $("#"+btn.id).attr("class").split(" ");
		
		
		if(btn_class[0] == "adult_btn") {
			$("#adult_gr").children().css('background-color','');

			if(btn.value != 0){
				$("#adult_gr").children().removeClass("selected_person");
				$("#"+btn.id).addClass("selected_person");
				$("#"+btn.id).css('background-color','orange');
				
				if(!$("#junior_gr").children().hasClass("selected_person")) {
					$("#junior_gr").children().attr('disabled', false);
					for(var i=4; i>(4-btn.value); i--) {
						$("#junior"+i).attr('disabled',true);
					}
				} else {
					console.log($("#adult_gr").children(".selected_person").val());
					$("#junior_gr").children().attr('disabled', true);
					$("#junior0").attr('disabled',false);
					for(var i=1; i<=4-$("#adult_gr").children(".selected_person").val(); i++) {
						$("#junior"+i).attr('disabled',false);
					}
				}
			} else {
				$("#junior_gr").children().attr('disabled', false);
				$("#adult_gr").children().removeClass("selected_person");
			}
			
		} else {
			$("#junior_gr").children().css('background-color','');
			
			if(btn.value != 0){
				$("#junior_gr").children().removeClass("selected_person");
				$("#"+btn.id).addClass("selected_person");
				$("#"+btn.id).css('background-color','orange');
				
				if(!$("#adult_gr").children().hasClass("selected_person")) {
					$("#adult_gr").children().attr('disabled', false);
					for(var i=4; i>(4-btn.value); i--) {
						$("#adult"+i).attr('disabled',true);
					}
				} else {
					console.log($("#junior_gr").children(".selected_person").val());
					$("#adult_gr").children().attr('disabled', true);
					$("#adult0").attr('disabled',false);
					for(var i=1; i<=4-$("#junior_gr").children(".selected_person").val(); i++) {
						$("#adult"+i).attr('disabled',false);
					}
				}
			} else {
				$("#adult_gr").children().attr('disabled', false);
				$("#junior_gr").children().removeClass("selected_person");
			}
		}
		
		/*
		// 고른 값이 0이면 다른 버튼 disable 전부 풀기
		if($("#junior_gr").children().hasClass("selected_person")
								&& (btn_class[0] == "adult_btn")) {
			
			$("#adult_gr").children().css('background-color','');
			
		} 
		else if($("#adult_gr").children().hasClass("selected_person")
									&& (btn_class[0] == "junior_btn")) {
						
			$("#junior_gr").children().css('background-color','');
			
		} else {
			if(btn_class[0] == "adult_btn") {
				if(btn.value == 0) {
					$("#junior_gr").children().attr('disabled', false);
				} else {
					
				}
				$("#adult_gr").children().removeClass("selected_person");
				$("#adult_gr").children().css('background-color','');
			} else {
				if(btn.value == 0) {
					$("#adult_gr").children().attr('disabled', false);
				} else {
					
				}
				$("#junior_gr").children().removeClass("selected_person");
				$("#junior_gr").children().css('background-color','');
			}
			// 고른 인원수 만큼 다른 유형의 버튼 disabled
			for(var i=4; i>(4-btn.value); i--) {
				if(btn_class[0] == "adult_btn") {
					$("#junior"+i).attr('disabled',true);
				} else {
					$("#adult"+i).attr('disabled',true);
				}
			}
		}
		
		*/
		
		/*
		var adultsel = Number($("#adult").val());
		var juniorsel = Number($("#junior").val());
		var seniorsel = Number($("#senior").val());
		var total_person = adultsel + juniorsel + seniorsel;
		select_person = total_person;

		console.log(inputbox);
		
		if((total_person) > 4) {
			alert("인원선택은 총 4명까지 가능합니다.");
			inputbox.value = (inputbox.value-1);
			select_person = select_person-1;
			return;
		}
		
		var addHtml = "선택좌석"
		addHtml += "<div>"
		for(var i=0; i<select_person; i++ ) {
			addHtml += "<p>■</p>"
		}
		addHtml += "</div>"
		
		$("#seat_select").html(addHtml);*/
	}
	
	// 좌석 선택 체크 메서드(선택한 좌석, 총 좌석수)
	function seatCheck(seat, allseat) {
		var select_seat = 0;
		
		// 선택되지 않은 좌석이면
		if(!($("#"+seat.id).hasClass("selected_seat"))) {
			// 관람 인원 총 합계보다 선택한 좌석 수가 많으면 return
			for(var i=1; i<=allseat; i++) {
				if($("#seat"+i).hasClass("selected_seat")) {
					select_seat++;
				}
			}
			if(select_seat == select_person) {
				alert("좌석은 관람 인원만큼만 선택할 수 있습니다.");
				return;
			}
			
			$("#"+seat.id).addClass("selected_seat");
			$("#"+seat.id).addClass("active");
			
		} else {// 이미 선택된 좌석이면 선택 해제
			$("#"+seat.id).removeClass("selected_seat");
			$("#"+seat.id).removeClass("active");
		}
		
		console.log(seat.id);
	}
</script>
<style type="text/css">
	.bottm_div {
		display: inline-block;
		width: auto;
		height: 150px;
		vertical-align: top;
		margin-right: 10px;
	}
	
	.adult_btn {
		width:60px;
		height:40px;
	}
	
	.junior_btn {
		width:60px;
		height:40px;
	}
	
	.selected_btn {
		background-color: #e00;
	}

</style>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<form>
		<div id="top_title_div" align="center">
			인원/좌석
		</div>
		
		<div id="person_seat_div" align="center">
			<div align="center" class="booking_person" style="display: inline-block;">
				<div id="adult_gr" class="btn-group" role="group" align="left">
					<span>일반</span><br>
					<button
					  	onclick="selectPerson(this)"
					  	class="adult_btn btn btn-light"
					  	type="button" id="adult0" value="0">0</button>
				    <button
					  	onclick="selectPerson(this)"
					  	class="adult_btn btn btn-secondary"
					  	type="button" id="adult1" value="1">1</button>
				  	<button
					  	onclick="selectPerson(this)"
					  	class="adult_btn btn btn-secondary"
					  	type="button" id="adult2" value="2">2</button>
				  	<button
					  	onclick="selectPerson(this)"
					  	class="adult_btn btn btn-secondary"
					  	type="button" id="adult3" value="3">3</button>
				  	<button
					  	onclick="selectPerson(this)"
					  	class="adult_btn btn btn-secondary"
					  	type="button" id="adult4" value="4">4</button>
				</div>&nbsp;&nbsp;
				<div id="junior_gr" class="btn-group" role="group" align="left">
					<span>청소년</span><br>
					<button
					  	onclick="selectPerson(this)"
					  	class="junior_btn btn btn-light"
					  	type="button" id="junior0" value="0">0</button>
				    <button
					  	onclick="selectPerson(this)"
					  	class="junior_btn btn btn-secondary"
					  	type="button" id="junior1" value="1">1</button>
				  	<button
					  	onclick="selectPerson(this)"
					  	class="junior_btn btn btn-secondary"
					  	type="button" id="junior2" value="2">2</button>
				  	<button
					  	onclick="selectPerson(this)"
					  	class="junior_btn btn btn-secondary"
					  	type="button" id="junior3" value="3">3</button>
				  	<button
					  	onclick="selectPerson(this)"
					  	class="junior_btn btn btn-secondary"
					  	type="button" id="junior4" value="4">4</button>
				</div>
	   		</div>
	   		
	   		<div id="top_movie_info_div" align="left" style="display: inline-block;">
	   			<span>${sdto.cinemaname }</span>&nbsp;|&nbsp;
	   			<span>${sdto.cincode }관</span>&nbsp;|&nbsp;
	   			<span>남은좌석&nbsp;&nbsp;&nbsp;00/${seat.allseat }</span>&nbsp;|&nbsp;
	   			<h4>일시&nbsp;&nbsp;&nbsp;${sdto.start_date }&nbsp;
						<fmt:parseNumber value="${(sdto.start_time / 60) }" integerOnly="true" />:
	               		<fmt:parseNumber value="${(sdto.start_time % 60) }" integerOnly="true" />&nbsp;~
	               		<c:if test="${sdto.end_time >= 1440}">
	               			<fmt:parseNumber value="${((sdto.end_time- 1440) / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<c:if test="${sdto.end_time < 1440}">
	               			<fmt:parseNumber value="${(sdto.end_time / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<fmt:parseNumber value="${(sdto.end_time % 60) }" integerOnly="true" />
				</h4>
			</div>
		</div>
		
		<hr>
		
		<div id="seat_div" align="center">
			<div id="screen_image_div">
				<img id="main_screen"
					src="<%=request.getContextPath() %>/image/screen.JPG"
	 		width="570px" height="40px" >
			</div><br>
			
			<div id="seat_div" align="center">
				<c:forEach var="seatno" begin="1" end="${seat.allseat }" >
					<button 
						type="button"
						style="width: 25px; height: 25px; font-size: 8px; font-variant: "
						class="btn btn-info"
						id="seat${seatno }"
						onclick="seatCheck(this,${seat.allseat })">${seatno }</button>
					<c:if test="${seatno%13 == 0 }"><br><br></c:if>
				</c:forEach>
			</div>
		</div>
		
		<hr>
		
		<div id="movie_div" align="center">
			<div id="before_btn_div" class="bottm_div">
				<button 
					type="button"
					id="before"
					class="btn btn-default btn-block"
					style="width:150px; height:150px;">
					<i class='glyphicon glyphicon-backward'></i>
				</button>
			</div>
			
			<div id="movie_img_div" align="left" class="bottm_div">
				<img id="s_poster" src="<%=request.getContextPath() %>/upload/${sdto.poster }"
				 		width="110px" height="150px" >
			</div>
			
			<div id="movie_info_div" align="left" class="bottm_div">
				 <span>
					 ${sdto.moviename } <br>
					 (${sdto.mtype })
				 </span>
			</div>
			
			<div id="cinema_info_div" align="left" class="bottm_div">
			   <span>극장&nbsp;&nbsp;&nbsp;${sdto.cinemaname }<br>
					  일시&nbsp;&nbsp;&nbsp;${sdto.start_date }&nbsp;
					 <fmt:parseNumber value="${(sdto.start_time / 60) }" integerOnly="true" />:
	               	 <fmt:parseNumber value="${(sdto.start_time % 60) }" integerOnly="true" /><br>
	               	 상영관&nbsp;&nbsp;&nbsp;${sdto.cincode }관
				</span>
			</div>
			
			<div id="seat_info_div" class="bottm_div">
				<span id="seat_select_span">좌석번호</span>
			</div>
			
			<div id="price_info_div" class="bottm_div">
				<span id="total_price">총금액</span>
			</div>
			
			<div id="next_btn_div" class="bottm_div">
				<button 
					type="button"
					id="next"
					class="btn btn-default btn-block"
					style="width:150px; height:150px;">
				<i class='glyphicon glyphicon-credit-card'></i>
				</button>
			</div>
		</div>

	</form>
</body>
</html>