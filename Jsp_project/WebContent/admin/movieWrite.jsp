<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 영화 등록</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
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
    	alert('최대 1000Byte까지만 입력가능합니다.');
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
	<div class="man_all_div" align="center">
		<div class="my_title_div">
			<span>영화 정보 등록/수정</span>
		</div>
		<div class="my_boo_div">
		<form name="movieInfo" method="post" enctype="multipart/form-data" 
			action="<%=request.getContextPath() %>/movieWriteOk.do"
			onsubmit="return checkValue()">
			<table class="movieWrite">
				<tr>
					<th>영화명(국문) : </th>
					<td><input name="movie_title_kor" placeholder="내용을 입력하세요" required pattern="^[가-힣0-9\s\d,;:!@#$%^*+=-]{1,50}$">
					 <div class="valid-feedback">
					      Looks good!
					    </div>
					</td>
				</tr>
				
				<tr>
					<th>영화명(영문) : </th>
					<td><input name="movie_title_eng" placeholder="내용을 입력하세요"></td>
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
							<option value="드라마">드라마</option>
							<option value="멜로/로맨스">멜로/로맨스</option>
							<option value="코미디">코미디</option>
							<option value="스릴러">스릴러</option>
							<option value="가족">가족</option>
							<option value="애니메이션">애니메이션</option>
							<option value="공포">공포</option>
							<option value="액션">액션</option>
							<option value="모험">모험</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>감   독 : </th>
					<td><input name="movie_director" placeholder="내용을 입력하세요" required></td>
				</tr>
				
				<tr>
					<th>출   연 : </th>
					<td><input name="movie_actor" placeholder="내용을 입력하세요" required></td>
				</tr>
				
				<tr>
					<th>줄 거 리 : <br><span id="nowByte">0</span>/1000bytes</th>
					<td> <textarea id="summary" rows="7" cols="30" name="movie_summary" 
						placeholder="내용을 입력하세요" onkeyup="fn_checkByte(this)" required></textarea></td>
				</tr>
				
				<tr>
					<th>상영시간 (분) : </th>
					<td> <input name="movie_runningtime" placeholder="숫자만 입력해주세요" required pattern="^[0-9]+$"></td>
				</tr>
				
				<tr>
					<th>관람가  등급 : </th>
					<td> 
						<select name="movie_age" required>
							<option selected disabled value="">:::선택:::</option>
							<option value="전체연령가">전체연령가</option>
							<option value="12세">12세</option>
							<option value="15세">15세</option>
							<option value="청소년 관람불가">청소년 관람불가</option>
						</select>
					</td>
				</tr> 
				
				<tr>
					<th>제작 국가 : </th>
					<td> <input name="movie_nation" placeholder="내용을 입력하세요" required>
					</td>
				</tr>
				
				<tr>
					<th>개 봉 일 : </th>
					<td> <input type="date" name="movie_opendate" required>
					</td>	
				</tr>
				
				<tr>
					<th>상  태 : </th>
					<td> 
						<select name="movie_state" required>
							<option selected disabled value="">:::선택:::</option>
							<option value="상영중">상영중</option>
							<option value="개봉 예정">개봉예정</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상영타입 : </th>
					<td>
						<select name="movie_type" required>
							<option selected disabled value="">:::선택:::</option>
							<option value="2D">2D</option>
							<option value="3D">3D</option>
							<option value="4D">4D</option>
							<option value="IMAX">IMAX</option>
						</select>
					</td>
				</tr>	
				<tr>
					  <td colspan="4" align="center">
						<button type="submit" class="btn join_btn">등록</button>
						<button type="button" class="btn cancle_btn" 
							onclick="history.back()">취소</button>
					</td>
				</tr>
			</table>			
		</form>
		
		</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
<script>	
	
	$('#upload').change(function(){
	    setImageFromFile(this, '#poster');
	});
	
	function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $(expression).attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	function checkValue(){
		var opendate = movieInfo.movie_opendate.value;
		var state = movieInfo.movie_state.value;
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




