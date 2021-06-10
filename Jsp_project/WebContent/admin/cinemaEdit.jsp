<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/style.css">
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

	/* function test_checkbox() {
		var flag = false;
		var values = document.getElementsByName("cin_check");
		var count = 0;
		
		for(var i=0; i<values.length; i++) {
			if(values[i].checked) {
				count++;
		}
		 
		if(count < 1) {
			alert("극장 1개 이상을 선택하셔야 합니다.");
		}else {
			flag = true;
		}
		return flag;
	} */
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
			
		<form method="post" action="<%=request.getContextPath() %>/cinemaEditOk.do">
		<c:set var="dto" value="${List }"/>
		<c:set var="llist" value="${locallist }"/>
		
		<input type="hidden" name="cinemacode" value="${dto.getCinemacode() }">
			<table class="localWrite">
				<tr>
					<th>분 류 : </th>
					<td>
						<select name="local_code">
							<c:if test="${empty llist }">
								<option value="">:::저장된 지역 없음:::</option>
				          	</c:if>
				          	
				          	<c:if test="${!empty llist }">
				          		<c:forEach items="${llist }" var="i">
				          			<c:if test="${dto.getLocalcode() == i.getLocalcode() }">
				          				<option value="${i.getLocalcode() }" selected>${i.getLocalname() }</option>
				          			</c:if>
				          			
				          			<c:if test="${dto.getLocalcode() != i.getLocalcode() }">
				          				<option value="${i.getLocalcode() }">${i.getLocalname() }</option>
				          			</c:if>
				          		</c:forEach>
			             	</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>지 점 명 : </th>
					<td><input name="cinema_name" value="${dto.getCinemaname() }"
						placeholder="내용을 입력하세요" required></td>
				</tr>
				
				<tr>
					<th>지점 소개 : <br><span id="nowByte">0</span>/100bytes</th>
					<td> <textarea rows="5" cols="50" name="cinema_intro" value="${dto.getIntro() }"
						placeholder="내용을 입력하세요" onkeyup="fn_checkByte(this)" required>${dto.getIntro() }</textarea> </td>
				</tr>
				
				<tr>
					<th>주 소 : </th>
					<td><input name="cinema_address" value="${dto.getAddress() }"
						placeholder="내용을 입력하세요" required> </td>
				</tr>
				
				<tr>
					<th>사용할 관 : </th>
					<td>
						<c:if test="${dto.getOne_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="1" checked> 1관
						</c:if>
						<c:if test="${dto.getOne_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="1"> 1관
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<c:if test="${dto.getTwo_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="2" checked> 2관
						</c:if>
						<c:if test="${dto.getTwo_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="2"> 2관
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<c:if test="${dto.getThree_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="3" checked> 3관
						</c:if>
						<c:if test="${dto.getThree_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="3"> 3관
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<c:if test="${dto.getFour_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="4" checked> 4관
						</c:if>
						<c:if test="${dto.getFour_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="4"> 4관
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<c:if test="${dto.getFive_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="5" checked> 5관
						</c:if>
						<c:if test="${dto.getFive_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="5"> 5관
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<c:if test="${dto.getSix_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="6" checked> 6관
						</c:if>
						<c:if test="${dto.getFour_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="6"> 6관
						</c:if>
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