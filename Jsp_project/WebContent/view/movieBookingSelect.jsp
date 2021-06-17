<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 예매하기</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	
	// 관람 인원 총 합계
	var select_person = 0;
	var select_seat_loc = 999;
	var total_price_loc = 0;
	
	// 인원 선택 (4명까지)
	function selectPerson(btn) {
		// 커버 삭제 / 선택한 좌석 초기화
		select_seat_loc = 999;
		$("#seat_cover_div").hide();
		$("#seat_arr_div").children("button").removeClass("selected_seat");
		$(".seat_btn[disabled!='disabled']").css("background-color","#B2EBF4");
		$("#seat_select_span").html("좌석번호");
		$("#total_price_span").html("총금액");
		
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
		
		// 총인원 셋팅
		var adultsel = 0;
		
		if($("#adult_gr").children(".selected_person").val() != null) {
			adultsel = $("#adult_gr").children(".selected_person").val();
		}
		
		var juniorsel = 0;
		
		if($("#junior_gr").children(".selected_person").val() != null) {
			juniorsel = $("#junior_gr").children(".selected_person").val();
		}
		
		//var total_person = adultsel + juniorsel;
		select_person = Number(adultsel) + Number(juniorsel);
		
	}
	
	// 좌석 선택 체크 메서드(선택한 좌석, 총 좌석수)
	function seatCheck(seat, allseat) {
		var select_seat = 0;
		var addHtml = "좌석번호<br>"
			addHtml += "<div>"
		
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
			$("#"+seat.id).css('background-color','orange');
			
			
		} else {// 이미 선택된 좌석이면 선택 해제
			$("#"+seat.id).removeClass("selected_seat");
			$("#"+seat.id).css('background-color','#B2EBF4');
			select_seat_loc = 999;
		}
		
		for(var i=1; i<=allseat; i++) {
			if($("#seat"+i).hasClass("selected_seat")) {
				addHtml += $("#seat"+i).val() + "번<br>";
			}
		}
		
		$("#seat_select_span").html(addHtml);
		
		if(select_seat == (select_person-1)) {
			price_cal();
			select_seat_loc = select_seat+1;
		}
		console.log(seat.id);
	}
	
	// 금액 계산 메서드
	function price_cal() {
		var htmlStr = "";
		var adultsel = 0;
		var juniorsel = 0;
		var adultPrice = 0;
		var juniorPrice = 0;
		
		if($("#adult_gr").children(".selected_person").val() != null) {
			adultsel = $("#adult_gr").children(".selected_person").val();
			adultPrice = 15000 * Number(adultsel);
			adultsel = 15000 * Number(adultsel);
			adultsel = adultsel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

			htmlStr += "일반&nbsp;&nbsp;"+adultsel+"원<br>";
		} else {
			htmlStr += "일반&nbsp;&nbsp;0원<br>";
		}
		
		if($("#junior_gr").children(".selected_person").val() != null) {
			juniorsel = $("#junior_gr").children(".selected_person").val();
			juniorPrice = 10000 * Number(juniorsel);
			juniorsel = 10000 * Number(juniorsel);
			juniorsel = juniorsel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			htmlStr += "청소년&nbsp;&nbsp;"+ juniorsel +"원<br>";
		} else {
			htmlStr += "청소년&nbsp;&nbsp;0원<br>";
		}

		var totalPrice = adultPrice + juniorPrice;
		total_price_loc = totalPrice;
		totalPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		htmlStr += "<br>총금액&nbsp;&nbsp;" + totalPrice + "원";
		
		$("#total_price_span").html(htmlStr);
	}
	
	// 결제 화면 넘어가기 메서드(스크린코드, 총좌석수)
	function payment(id, code, allseat) {
		if(select_seat_loc == 999) {
			alert("좌석을 선택해주세요!");
			return;
		}
		
		if(select_seat_loc != select_person) {
			alert("선택한 인원 수만큼 좌석을 선택해주세요!");
			return;
		}
		
		if(id == "") {
			var login = window.location.search;
			var logincode = login.split("=");
			onClick();
			$("#loginValue").val(logincode[1]);
			console.log($("#loginValue").val());
			return;
		}

		var form = document.createElement("form");

		form.setAttribute("method", "post");
		form.setAttribute("action", "<%=request.getContextPath() %>/movieBookingPayment.do");
		
		var params = new Array();
		
		//스크린코드
		params[0] = code;
		params[1] = "";
		
		//선택 좌석
		for(var i=1; i<=allseat; i++) {
			if($("#seat"+i).hasClass("selected_seat")) {
				params[1] += $("#seat"+i).val() + "/";
			}
		}
		
		//선택 인원 명수 : 일반
		if($("#adult_gr").children(".selected_person").val() == null) {
			params[2] = 0;
		} else {
			params[2] = $("#adult_gr").children(".selected_person").val();
		}
		
		//선택 인원 명수 : 청소년
		if($("#junior_gr").children(".selected_person").val() == null) {
			params[3] = 0;
		} else {
			params[3] = $("#junior_gr").children(".selected_person").val();
		}
		
		
		//총 금액
		params[4] = total_price_loc;
		console.log(params);

		for ( var key in params) {

			var hiddenField = document.createElement('input');

			hiddenField.setAttribute('type', 'hidden');
			hiddenField.setAttribute('name', key);
			hiddenField.setAttribute('value', params[key]);

			form.appendChild(hiddenField);

		}

		document.body.appendChild(form);

		form.submit();

	}
	
	$(document).ready(function() {
		
		// 예매 좌석/일반 좌석 색상 설정
		$(".seat_btn[disabled='disabled']").css("background-color","#EAEAEA");
		$(".seat_btn[disabled!='disabled']").css("background-color","#B2EBF4");
    });
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<form>
		<div id="top_title_div" align="center">
			인원/좌석
		</div>
		<!-- 상단 인원 선택 / 영화 상영 일시 -->
		<div id="person_seat_div" align="center">
			<div align="center" class="booking_person" style="display: inline-block;">
				<div id="adult_gr" class="top_div btn-group" role="group" align="left">
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
				<div id="junior_gr" class="top_div btn-group" role="group" align="left">
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
	   		
	   		<div id="top_movie_info_div" class="top_div" align="left">
	   			<span>${sdto.cinemaname }</span>&nbsp;│&nbsp;
	   			<span>${sdto.cincode }관</span>&nbsp;│&nbsp;
	   			<span style="color: orange; font-weight: bold;">
	   				남은좌석&nbsp;&nbsp;&nbsp;
	   				<c:if test="${bookseat[0] == '' }">
	   					${seat.allseat }/${seat.allseat }
	   				</c:if>
	   				<c:if test="${bookseat[0] != '' }">
	   					${(seat.allseat-fn:length(bookseat)) }/${seat.allseat }
	   				</c:if>
	   			</span>&nbsp;│&nbsp;
	   			<h4>일시&nbsp;&nbsp;&nbsp;${sdto.start_date }&nbsp;
	   					<c:if test="${(sdto.start_time / 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.start_time / 60) }" integerOnly="true" />:
						<c:if test="${(sdto.start_time % 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.start_time % 60) }" integerOnly="true" />&nbsp;~
	               		<c:if test="${sdto.end_time >= 1440}">
	               			<c:if test="${((sdto.end_time-1440) / 60) < 10}">0</c:if><fmt:parseNumber value="${((sdto.end_time- 1440) / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<c:if test="${sdto.end_time < 1440}">
	               			<c:if test="${((sdto.end_time) / 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.end_time / 60) }" integerOnly="true" />:
	               		</c:if>
	               		<c:if test="${((sdto.end_time) % 60) < 10}">0</c:if><fmt:parseNumber value="${(sdto.end_time % 60) }" integerOnly="true" />
				</h4>
				<img id="seat_info_img"
					 src="<%=request.getContextPath() %>/image/seat_info2.jpg"
		 		     width="110px" height="75px" >
			</div>
		</div>
		
		<hr>
		<!-- 좌석 셋팅 -->
		<div id="seat_div" align="center" style="positon :relative; z-index: 1;">
			<div id="seat_cover_div" align="center"><span id="cover_span">관람할 인원을 선택해주세요.</span></div>
			<div id="screen_image_div">
				<img id="main_screen"
					 src="<%=request.getContextPath() %>/image/screen.JPG"
	 				 width="570px" height="40px" >
			</div><br>
			<div id="seat_arr_div" align="center">
				<c:forEach var="seatno" begin="1" end="${seat.allseat }" >
					<button 
						type="button"
						style="width: 30px; height: 30px; border: 0px;"
						id="seat${seatno }"
						value="${seatno }"
						class="seat_btn"
						onclick="seatCheck(this,${seat.allseat })"
						<c:forEach var="i" begin="1" end="${fn:length(bookseat) }" >
							<c:if test="${bookseat[i] == seatno}">
								disabled="disabled"
							</c:if>
						</c:forEach>>
					</button>
					<c:if test="${seatno%13 == 0 }"><br><br></c:if>
				</c:forEach>
			</div>
		</div>
		<div id="seat_info_img_div" style="float: right;">
			
		</div>
		
		<hr>
		<!-- 하단 영화정보 / 좌석 선택 정보 / 결제 금액 -->
		<div id="movie_div" align="center">
			<div id="before_btn_div" class="bottm_div">
				<button 
					type="button"
					id="before"
					class="btn btn-light btn-block"
					onclick="history.back()"
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
			
			<div id="seat_info_div" class="bottm_div" align="left" >
				<span id="seat_select_span">좌석번호</span>
			</div>
			
			<div id="price_info_div" class="bottm_div" align="left" >
				<span id="total_price_span">총금액</span>
			</div>
			
			<div id="next_btn_div" class="bottm_div">
				<button 
					type="button"
					id="next"
					class="btn btn-light btn-block"
					onclick="payment('${memSession.id }','${sdto.screencode}', '${seat.allseat }')"
					style="width:150px; height:150px;">
				<i class='glyphicon glyphicon-credit-card'></i>
				</button>
			</div>
		</div>

	</form>
</body>
</html>