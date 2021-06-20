<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ֿ�ڽ� : ȸ������ �Ϸ�</title>
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
		<h3>${name }��, �ֿ�ڽ��� ���� ���� ȯ���մϴ�!</h3>
		<h3>�����Ͻ� ���̵�� ��й�ȣ�� �α��� ���ּ���.</h3>
		<br>
		<input type="button" onclick="goMain()" value="��������" class="btn btn-default">
	</div>
</body>
</html>