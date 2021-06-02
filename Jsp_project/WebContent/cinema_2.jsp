<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.selectbox {
		width: 10em;
	}
	
	.wrap {
		margin: 30px;
	}
	
	textarea {
		resize: none;
	}
	
	#intro-text {
		width: 300px;
		height: 100px;
	}
	
	#address-text {
		width: 300px;
	}
	
	#name-text {
		width: 300px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="wrap">
		<form>
			<h1>지점 정보 등록/수정</h1>
			<br>
			<div class="wrap2">
				<div>
					분류 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select
						class="selectbox">
						<option>서울</option>
						<option>경기</option>
						<option>인천</option>
					</select>
				</div>
				<br>
				<div>
					<label>지점명 :</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
						type="text" id="name-text">
				</div>
				<br> <label id="intro-label">지점 소개 :</label>&nbsp;&nbsp; <input
					type="text" id="intro-text" placeholder="TextArea"> <br>
				<br>
				<div>
					<label>주소 :</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="address-text">
				</div>
				<br>
				<div>
					사용할 관 :&nbsp;&nbsp;&nbsp; <input type="checkbox"> 1관 <input
						type="checkbox"> 2관<br>
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox">
					3관 <input type="checkbox"> 4관<br>
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox"> 5관 <input
						type="checkbox"> 6관
				</div>
			</div>
		</form>
	</div>

</body>
</html>