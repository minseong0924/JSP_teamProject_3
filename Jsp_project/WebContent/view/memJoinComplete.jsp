<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>쌍용박스 : 회원가입 완료</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">

	function goMain() {
		location.href="<%=request.getContextPath()%>/main.do";
	}

</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp"/>
	<br><br>
	<div align="center">
		<c:set var="name" value="${username }"/>
		<h3>${name }님, 쌍용박스에 오신 것을 환영합니다!</h3>
		<h3>가입하신 아이디와 비밀번호로 로그인 해주세요.</h3>
		<br>
		<input type="button" onclick="goMain()" value="메인으로" class="btn btn-default">
	</div>
</body>
</html>