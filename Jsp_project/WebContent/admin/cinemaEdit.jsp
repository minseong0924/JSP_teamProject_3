<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 지점 정보 수정</title>
<link rel="stylesheet" href="./css/style.css">
<script type="text/javascript">

	function textboxable1(frm) {
		if(frm.seat_no1.disabled == true) {
			frm.seat_no1.disabled = false;
		}else {
			frm.seat_no1.disabled = true;
		}
	}
	
	function textboxable2(frm) {
		if(frm.seat_no2.disabled == true) {
			frm.seat_no2.disabled = false;
		}else {
			frm.seat_no2.disabled = true;
		}
	}
	
	function textboxable3(frm) {
		if(frm.seat_no3.disabled == true) {
			frm.seat_no3.disabled = false;
		}else {
			frm.seat_no3.disabled = true;
		}
	}
	
	function textboxable4(frm) {
		if(frm.seat_no4.disabled == true) {
			frm.seat_no4.disabled = false;
		}else {
			frm.seat_no4.disabled = true;
		}
	}
	
	function textboxable5(frm) {
		if(frm.seat_no5.disabled == true) {
			frm.seat_no5.disabled = false;
		}else {
			frm.seat_no5.disabled = true;
		}
	}
	
	function textboxable6(frm) {
		if(frm.seat_no6.disabled == true) {
			frm.seat_no6.disabled = false;
		}else {
			frm.seat_no6.disabled = true;
		}
	}
	
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
	<div class="man_all_div_sm" align="center">
		<div class="my_title_div">
			<span>지점 정보 등록/수정</span>
		</div>
		<div class="my_boo_div">
		<form method="post" action="<%=request.getContextPath() %>/cinemaEditOk.do"
			onsubmit="return test_checkbox()">
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
							<input type="checkbox" name="cin_check" value="1" onclick="textboxable1(this.form)" checked> 1관
							<input type="text" name="seat_no1" placeholder="좌석 수" style="width:60px" value="${seat_no1 }">
						</c:if>
						<c:if test="${dto.getOne_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="1" onclick="textboxable1(this.form)"> 1관
							<input type="text" name="seat_no1" placeholder="좌석 수" style="width:60px" disabled>
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<c:if test="${dto.getTwo_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="2" onclick="textboxable2(this.form)" checked> 2관
							<input type="text" name="seat_no2" placeholder="좌석 수" style="width:60px" value="${seat_no2 }" >
						</c:if>
						<c:if test="${dto.getTwo_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="2" onclick="textboxable2(this.form)"> 2관
							<input type="text" name="seat_no2" placeholder="좌석 수" style="width:60px" disabled>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<c:if test="${dto.getThree_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="3" onclick="textboxable3(this.form)" checked> 3관
							<input type="text" name="seat_no3" placeholder="좌석 수" style="width:60px" value="${seat_no3 }">
						</c:if>
						<c:if test="${dto.getThree_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="3" onclick="textboxable3(this.form)"> 3관
							<input type="text" name="seat_no3" placeholder="좌석 수" style="width:60px" disabled>
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<c:if test="${dto.getFour_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="4" onclick="textboxable4(this.form)" checked> 4관
							<input type="text" name="seat_no4" placeholder="좌석 수" style="width:60px" value="${seat_no4 }">
						</c:if>
						<c:if test="${dto.getFour_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="4" onclick="textboxable4(this.form)"> 4관
							<input type="text" name="seat_no4" placeholder="좌석 수" style="width:60px" disabled>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<c:if test="${dto.getFive_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="5" onclick="textboxable5(this.form)" checked> 5관
							<input type="text" name="seat_no5" placeholder="좌석 수" style="width:60px" value="${seat_no5 }">
						</c:if>
						<c:if test="${dto.getFive_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="5" onclick="textboxable5(this.form)"> 5관
							<input type="text" name="seat_no5" placeholder="좌석 수" style="width:60px" disabled>
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<c:if test="${dto.getSix_cin() == 1 }">
							<input type="checkbox" name="cin_check" value="6" onclick="textboxable6(this.form)" checked> 6관
							<input type="text" name="seat_no6" placeholder="좌석 수" style="width:60px" value="${seat_no6 }">
						</c:if>
						<c:if test="${dto.getSix_cin() != 1 }">
							<input type="checkbox" name="cin_check" value="6" onclick="textboxable6(this.form)"> 6관
							<input type="text" name="seat_no6" placeholder="좌석 수" style="width:60px" disabled>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<td colspan="4" align="right">
						<input type="submit" value="등록" class="btn join_btn">
						<input type="submit" onclick="history.back()" value="취소" class="btn cancle_btn">
					</td>
				</tr>
				
			</table>
		</form>
		</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />

</body>
</html>