<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 비밀번호 찾기 결과</title>
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
	<div class="res_all_div" align="center">
		<div class="res_in_div">
			<c:set var="pwd" value="${findPwd }"/>
			<c:set var="name" value="${findName }"/>
			${name } 님의 비밀번호는 ${pwd } 입니다.
			<br><br><br><br>
			<input type="button" onclick="goMain()" value="메인으로" class="btn join_btn">
		</div>
	</div>
</body>
</html>