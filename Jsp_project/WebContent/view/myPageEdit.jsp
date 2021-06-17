<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 개인정보수정</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div style="margin:20px;">
		<nav id="side_bar">
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageEdit.do?memid=${memSession.id }">개인정보 수정</a></li>
		</nav>
	</div>
	<div align="center">
		<form name="memJoin" method="post" onsubmit="return allCheck()" 
			action="<%=request.getContextPath() %>/memberEditOk.do">
		<div class="title">
			<br><br>
			<h2>개인정보 수정</h2>
			<br><br>
		</div>
			<c:set var="dto" value="${mlist }"/>
			<table class="memJoin">
				<tr>
					<td>아이디</td>
					<td>
						<input name="userid" id="userid" class="form-control" value="${dto.id }" placeholder="4자 이상 16자 이하" disabled>
					</td>
				</tr>
				
				<tr>
					<td>이름</td>
					<td><input id="username" name="username" class="form-control" value="${dto.name }" required></td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" id="userpwd" name="userpwd" class="form-control" value="${dto.pwd }" required></td>
				</tr>
				
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="userpwd_ok" name="userpwd_ok" class="form-control" value="${dto.pwd }" required></td>
				</tr>
				
				<tr>
					<td>생년월일</td>
					<td>
						<input id="userbirth" name="userbirth" class="form-control" maxlength="8" placeholder="생년월일 앞8자리 예)19901212" value="${dto.birth }" required>
						<span id="birthcheck"></span>
						<input type="hidden" id="birthcheck_hidden">
					</td>
				</tr>
				
				<tr>
					<td>연락처</td>
					<td>
						<input placeholder="'-' 제외 예) 01012341234" maxlength="11" id="userphone" name="userphone" class="form-control" value="${dto.phone }" required>
						<span id="phcheck"></span>
						<input type="hidden" id="phcheck_hidden">
					</td>
				</tr>
				<tr>
					  <td colspan="2" align="center">
						<button type="submit" class="btn btn-success">회원가입</button>
						<button type="button" class="btn btn-default" 
							onclick="history.back()">돌아가기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>