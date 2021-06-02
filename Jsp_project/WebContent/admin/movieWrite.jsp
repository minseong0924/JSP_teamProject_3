<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.title {
	text-align: left;
	margin-left: 500px;
}
.movieWrite{
	border-spacing: 30px;
}
</style>

</head>
<body>	
	<jsp:include page="../include/mheader.jsp"/>
	
	<div align="center">
		<div class="title">
			<h2>영화 정보 등록/수정</h2>
			<br>
			<br>
		
		
		<form method="post" enctype="multipart/form-data" 
			action="<%=request.getContextPath() %>/movieWriteOk.do">
			<table class="movieWrite">
				<tr>
					<th>영화명(국문) : </th>
					<td><input name="movie_title_kor"></td>
				</tr>
				
				<tr>
					<th>영화명(영문) : </th>
					<td><input name="movie_title_eng"></td>
				</tr>
				
				<tr>
					<th>대표   포스터 : </th>
					<td rowspan="2" id="poster"></td>
					<td> <input type="file"  id="upload" name="movie_poster" 
							accept="image/*" onchange="setImg(event)"></td>
				</tr>
				
				<tr>
					<td></td>
					<td>jpg,png 파일만 첨부가 가능합니다.</td>
				</tr>
				
				<tr>
					<th>장   르 : </th>
					<td> 
						<select name="movie_genre">
							<option value="드라마">드라마</option>
							<option value="로맨스">로맨스</option>
							<option value="코미디">코미디</option>
							<option value="스릴러">스릴러</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>감   독 : </th>
					<td><input name="movie_director"></td>
				</tr>
				
				<tr>
					<th>출   연 : </th>
					<td><input name="movie_actor"></td>
				</tr>
				
				<tr>
					<th>줄 거 리 : </th>
					<td> <textarea rows="7" cols="30" name="movie_summary"></textarea></td>
				</tr>
				
				<tr>
					<th>상영시간 (분) : </th>
					<td> <input name="movie_runningtime"></td>
				</tr>
				
				<tr>
					<th>관람가  등급 : </th>
					<td> 
						<select name="movie_age">
							<option value="전체연령가">전체연령가</option>
							<option value="12세">12세</option>
							<option value="15세">15세</option>
							<option value="청소년 관람불가">청소년 관람불가</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>제작 국가 : </th>
					<td> <input name="movie_nation">
					</td>
				</tr>
				
				<tr>
					<th>개 봉 일 : </th>
					<td> <input type="date" name="movie_opendate">
					</td>	
				</tr>
				
				<tr>
					<th>상  태 : </th>
					<td> 
						<select name="movie_state">
							<option value="상영중">상영중</option>
							<option value="개봉 예정">개봉예정</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상영타입 : </th>
					<td>
						<select name="movie_type">
							<option value="2D">2D</option>
							<option value="3D">3D</option>
							<option value="4D">4D</option>
							<option value="IMAX">IMAX</option>
						</select>
					</td>
				</tr>	
				<tr>
					  <td colspan="4" align="center">
						<input type="submit" value="등록">
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
</html>




