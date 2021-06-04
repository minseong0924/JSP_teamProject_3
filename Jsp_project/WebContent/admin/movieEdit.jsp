<%@page import="com.cinema.model.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MovieDTO list = (MovieDTO)request.getAttribute("List");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/style.css">
<script>
function fn_checkByte(obj){
    var maxByte = 1000; //최대 1000바이트
    var text_val = obj.value; //입력한 문자
    var text_len = text_val.length; //입력한 문자수
    
    var totalByte=0;
    for(let i=0; i<text_len; i++){
    	var each_char = text_val.charAt(i);
        var uni_char = escape(each_char); //유니코드 형식으로 변환
        if(uni_char.length>4){
        	// 한글 : 2Byte
            totalByte += 2;
        }else{
        	// 영문,숫자,특수문자 : 1Byte
            totalByte += 1;
        }
    }
    
    if(totalByte>maxByte){
    	alert('최대 100Byte까지만 입력가능합니다.');
        	document.getElementById("nowByte").innerText = totalByte;
            document.getElementById("nowByte").style.color = "red";
        }else{
        	document.getElementById("nowByte").innerText = totalByte;
            document.getElementById("nowByte").style.color = "green";
        }
    }
</script>

</head>
<body>	
	<jsp:include page="../include/mheader.jsp"/>
	<br><br>
	<div align="center">
		<div class="title">
			<h2>영화 정보 등록/수정</h2>
			<br>
			<br>
			
		<form name="movieInfo" method="post" enctype="multipart/form-data" 
			action="<%=request.getContextPath() %>/movieEditOk.do" 
			onsubmit="return checkValue()">
		<c:set var="dto" value="${List }"/>

		<input type="hidden" name="moviecode" value="${dto.getMoviecode() }">
			<table class="movieWrite">
				<tr>
					<th>영화명(국문) : </th>
					<td><input name="movie_title_kor" value="${dto.getTitle_ko() }"
						placeholder="내용을 입력하세요" required pattern="^[가-힣1-50000]{1,30}$"></td>
				</tr>
				
				<tr>
					<th>영화명(영문) : </th>
					<td><input name="movie_title_eng" value="${dto.getTitle_en() }" 
						placeholder="내용을 입력하세요" placeholder="내용을 입력하세요" required pattern="^[a-zA-Z1-50000]{1,50}$"></td>
				</tr>
				
				<tr>
					<th>대표   포스터 : </th>
					<td><img src="" id="poster" alt="미리보기" width="200" height="200">
					<input type="file"  id="upload" name="movie_poster" 
							accept="image/*" required>jpg,png 파일만 첨부가 가능합니다.</td>
				</tr>
				
				<tr>
					<th>장   르 : </th>
					<td> 
						<select name="movie_genre" required>
							<option selected disabled value="">:::선택:::</option>
							<option value="드라마" <% if(list.getGenre().equals("드라마")) {%>selected<%} %>>드라마</option>
							<option value="로맨스" <% if(list.getGenre().equals("로맨스")) {%>selected<%} %>>로맨스</option>
							<option value="코미디" <% if(list.getGenre().equals("코미디")) {%>selected<%} %>>코미디</option>
							<option value="스릴러" <% if(list.getGenre().equals("스릴러")) {%>selected<%} %>>스릴러</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>감   독 : </th>
					<td><input name="movie_director" value="${dto.getDirector() }"
						placeholder="내용을 입력하세요" required></td>
				</tr>
				
				<tr>
					<th>출   연 : </th>
					<td><input name="movie_actor" value="${dto.getActor() }"
						placeholder="내용을 입력하세요" required></td>
				</tr>
				
				<tr>
					<th>줄 거 리 : <br><span id="nowByte">0</span>/1000bytes</th>
					<td> <textarea id="summary" rows="7" cols="30" name="movie_summary" 
						placeholder="내용을 입력하세요" onkeyup="fn_checkByte(this)" required></textarea></td>
				</tr>
				
				<tr>
					<th>상영시간 (분) : </th>
					<td> <input name="movie_runningtime" value="${dto.getRunning_time() }"
						placeholder="숫자만 입력해주세요" required pattern="^[1-50000]{1,3}$"></td>
				</tr>
				
				<tr>
					<th>관람가  등급 : </th>
					<td> 
						<select name="movie_age" required>
							<option selected disabled value="">:::선택:::</option>
							<option value="전체연령가" <% if(list.getAge().equals("전체연령가")) {%>selected<%} %>>전체연령가</option>
							<option value="12세" <% if(list.getAge().equals("12세")) {%>selected<%} %>>12세</option>
							<option value="15세" <% if(list.getAge().equals("전체연령가")) {%>selected<%} %>>15세</option>
							<option value="청소년 관람불가" <% if(list.getAge().equals("전체연령가")) {%>selected<%} %>>청소년 관람불가</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>제작 국가 : </th>
					<td> <input name="movie_nation" value="${dto.getNation() }"
						placeholder="내용을 입력하세요"></td>
				</tr>
				
				<tr>
					<th>개 봉 일 : </th>
					<td> <input type="date"
										value='${dto.getOpendate() }' name="movie_opendate" >
					</td>	
				</tr>
				
				<tr>
					<th>상  태 : </th>
					<td> 
						<select name="movie_state" required>
							<option selected disabled value="">:::선택:::</option>
							<option value="상영중" <% if(list.getMstate().equals("상영중")) {%>selected<%} %>>상영중</option>
							<option value="개봉 예정" <% if(list.getMstate().equals("상영중")) {%>selected<%} %>>개봉예정</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상영타입 : </th>
					<td>
						<select name="movie_type" required>
							<option selected disabled value="">:::선택:::</option>
							<option value="2D" <% if(list.getMtype().equals("2D")) {%>selected<%} %>>2D</option>
							<option value="3D" <% if(list.getMtype().equals("3D")) {%>selected<%} %>>3D</option>
							<option value="4D" <% if(list.getMtype().equals("4D")) {%>selected<%} %>>4D</option>
							<option value="IMAX" <% if(list.getMtype().equals("IMAX")) {%>selected<%} %>>IMAX</option>
						</select>
					</td>
				</tr>	
				<tr>
					  <td colspan="4" align="right">
						<button type="submit" class="btn btn-success">등록</button>
					</td>
				</tr>
			</table>			
		</form>
		
		</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
<script>	
	
	function setImg(event) {
		var reader = new FileReader();
		
		reader.onload = function(event) { 
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			document.querySelector("#poster").appendChild(img); 
		
		}; 
				reader.readAsDataURL(event.target.files[0]);	
	}

</script>
<script>
	function checkValue(){
		var opendate = movieInfo.movie_opendate.value;
		var state = movieInfo.movie_state.value;
		var type = movieInfo.movie_type.value;
		var today = new Date();
		var day = new Date(opendate);
		
		if(today < day) {
			if(state == '상영중') {
				alert('상영중이 아닙니다. 날짜를 확인해주세요');
				return false;
			}
		}
		if(today > day) {
			if(state == '개봉 예정') {
				alert('개봉예정이 아닙니다. 날짜를 확인해주세요');
				return false;
			}
		}
	}
</script>

</html>