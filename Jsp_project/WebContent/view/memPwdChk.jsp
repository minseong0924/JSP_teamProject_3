<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 회원 확인</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
<!-- 	<div style="margin:20px;"> -->
		<nav id="side_bar">
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/memPwdChk.do?memid=${memSession.id }">개인정보 수정</a></li>
		</nav>
<!-- 	</div> -->
	<div class="my_all_div" align="center">
		<div class="my_title_div">
			<span>회원 확인</span>
		</div>
		<form method="post" action="<%=request.getContextPath() %>/myPageEdit.do?memid=${memSession.id }">
			<table width="400px" class="mypagepwd" border="0" cellspacing="1">
				<tr>
					<td><label>비밀번호</label></td>
					<td><input type="text" name="try_pwd" class="form-control" required></td>
				</tr>
				
				<tr>
					<td class="pwd_btn" align="center" colspan="2">
						<button type="submit" class="btn join_btn">확인</button>
						&nbsp;&nbsp;
						<button type="button" class="btn" 
							onclick="history.back()">돌아가기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>