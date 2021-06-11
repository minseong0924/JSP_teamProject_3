<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지점 등록</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">

	function fn_checkByte(obj) {
		var maxByte = 100; //최대 100바이트
		var text_val = obj.value; //입력한 문자
		var text_len = text_val.length; //입력한 문자수

		var totalByte = 0;
		for (let i = 0; i < text_len; i++) {
			var each_char = text_val.charAt(i);
			var uni_char = escape(each_char); //유니코드 형식으로 변환
			if (uni_char.length > 4) {
				// 한글 : 2Byte
				totalByte += 2;
			} else {
				// 영문,숫자,특수문자 : 1Byte
				totalByte += 1;
			}
		}

		if (totalByte > maxByte) {
			alert('최대 100Byte까지만 입력가능합니다.');
			document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "red";
		} else {
			document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "green";
		}
	}

	function test_checkbox() {
		var flag = false;
		var values = document.getElementsByName("cin_check");
		var count = 0;
		
		for(var i=0; i<values.length; i++) {
			if(values[i].checked) {
				count++;
			}
		}
		 
		if(count < 1) {
			alert("극장 1개 이상을 선택하셔야 합니다.");
		}else {
			flag = true;
		}
		return flag;
	}
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<br><br>
	<div align="center">
		<div class="title">
			<h2>지점 정보 등록/수정</h2>
			<br>
			<br>
			
		<form method="post" action="<%=request.getContextPath() %>/cinemaWriteOk.do"
			onsubmit="return test_checkbox()">
			<table class="localWrite">
				<tr>
					<th>분 류 : </th>
					<td>
						<select name="local_code">
							<c:set var="llist" value="${List }" />
							<c:if test="${empty llist }">
								<option value="">:::저장된 지역 없음:::</option>
				          	</c:if>
				          	
				          	<c:if test="${!empty llist }">
				          		<c:forEach items="${llist }" var="dto">
				          			<option value="${dto.localcode }">${dto.localname }</option>
				          		</c:forEach>
			             	</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>지 점 명 : </th>
					<td><input name="cinema_name" placeholder="내용을 입력하세요" required></td>
				</tr>
				
				<tr>
					<th>지점 소개 : <br><span id="nowByte">0</span>/100bytes</th>
					<td> <textarea rows="5" cols="50" name="cinema_intro"
						placeholder="내용을 입력하세요" onkeyup="fn_checkByte(this)" required></textarea> </td>
				</tr>
				
				<tr>
					<th>주 소 : </th>
					<td><input name="cinema_address" placeholder="내용을 입력하세요" required> </td>
				</tr>
				
				<tr>
					<th>사용할 관 : </th>
					<td>
						<input type="checkbox" name="cin_check" value="1"> 1관
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="cin_check" value="2"> 2관
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<input type="checkbox" name="cin_check" value="3"> 3관
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="cin_check" value="4"> 4관
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<input type="checkbox" name="cin_check" value="5"> 5관
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="cin_check" value="6"> 6관
					</td>
				</tr>
				
				<tr>
					<td colspan="4" align="right">
						<input type="submit" value="등록">
					</td>
				</tr>
				
			</table>
		</form>
		</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />

</body>
</html>