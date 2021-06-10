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
			
			day += "<button type='button' class='btn btn-default' "
			        + "onclick=\"dayBaseScreenOpen('"+thisday+"')\" "
					+ "id='day"+j+"' value='"+thisWeek[j]+"'>"
					+ "<span>"
					+ thisWeek[j].substring(5,7)+"/"
					+ thisWeek[j].substring(8,10)+"·"
					+ weekName[new Date(thisWeek[j]).getDay()]
					+ "</span>"
					+ "</button>";
		}
		
		day = "<button type='button' class='btn btn-default' onclick='dayBeforeSetting()'>《 </button>"
				+ day
				+ "<button type='button' class='btn btn-default' onclick='dayAfterSetting()'>》 </button>";
		
		$("#header_day").html(day);
	}
	
	function dayBeforeSetting() {
		var today = new Date();
		today = today.toISOString().slice(0, 10);
		var day = $("#day0").val();
		
		if(day == today) {
			return;
		} else {
			daySetting("before", day);
		}
	}
	
	function dayAfterSetting() {
		var day = $("#day0").val();
		daySetting("after", day);
	}
	
	function dayBaseScreenOpen(day) {
		console.log(day);
		$.ajax({
			type:"post",
			url: "/Jsp_project/screenListOpen.do",
			dataType: "json",
			data: {
					"flag" : "dayBase",
				    "day" : day
				  },
			success: function(data) {
				var screenlist = data.slist;
				
				for(var i=0; i<screenlist.length; i++) {
					console.log(screenlist[i].screencode);
				}
			},
			error: function(request,status,error){
		       // alert("code:"+request.status+"\n"
		       // 		+"message:"+request.responseText+"\n"+"error:"+error);
		       alert("에러다!!!");
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
	<div align="center">
		<div id="header_day" class="btn-group btn-group-sm" role="group">
		</div>
		<table class="table">
			<tr>
				<td><span class="booking_title">영화</span>
					<div class="booking_list panel panel-default" align="left">
					  <div class="list-group">
					  	<c:if test="${!empty movielist }">
		                   <c:forEach items="${movielist }" var="mdto">
		                      <a href="#" class="list-group-item">${mdto.title_ko }</a>
		                   </c:forEach>
		                </c:if>
					  </div>
					</div>
				</td>
				<td><span class="booking_title">극장</span>
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
				<td rowspan="2"><span class="booking_title">시간</span>
					<div class="booking_list panel panel-default">
					  <div class="list-group">
					    영화와 극장을 선택하시면 상영시간표를 비교하여 볼 수 있습니다.
					  </div>
					</div>
				</td>
			</tr>
			<tr>
				<td id="select_movie">선택한 영화</td>
				<td id="select_cinema" colspan="2">선택한 극장</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>