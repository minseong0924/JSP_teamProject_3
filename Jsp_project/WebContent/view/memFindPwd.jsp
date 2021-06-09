<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
	<div align="center">
	<jsp:include page="../include/mheader.jsp"/>
	<form method="post" action="<%=request.getContextPath()%>/memFindPwdOk.do">
		<table>
			<tr><td colspan="2" align="center"><h4>비밀번호 찾기</h4></td></tr>
			<tr>
				<td>아이디</td>
				<td><input name="id" class="form-control" placeholder="아이디" required></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input name="name" class="form-control" placeholder="이름" required></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input name="birth" class="form-control" placeholder="생년월일 앞8자리" required></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td><input name="phone" class="form-control" placeholder=" - 없이 입력" required></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit" class="btn btn-default">비밀번호 찾기</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>