<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style type="text/css">

	#head_inout {
		text-align: right;
	}

	#head_menu a {
		margin-left: 5%;
	}

	a { 
		color: #000;
		text-decoration:none;

	} 
	
	a:hover {
		color: #A566FF;
	}
	
</style>
</head>
<body>
	<div id="head">
	   	<section id="head_inout">
	   		<!-- 세션에 이름이 있으면 이름 출력 / 없으면 로그인 버튼 출력 -->
	   		
	   		<c:if test="${!empty session_name }">
	   			<a href="#">${session_name }님 환영합니다.</a>
	   			<a href="<%=request.getContextPath() %>/logout.do">로그아웃</a>
	   		</c:if>
	   		
	   		<c:if test="${empty session_name }">
	   			<a href="<%=request.getContextPath() %>/login.do">로그인</a>&nbsp;
	   			<a href="<%=request.getContextPath() %>/join.do">회원가입</a>
	   		</c:if>
	   	</section>
	   	
	   	<div id="head_menu">
	   		   <a id="menu" href="<%=request.getContextPath() %>/allmenu.do" >
	   		   		<img src="image/menu_icon.png" width="20" height="20"></a>
	   		   <a href="<%=request.getContextPath() %>/mian.do" >
	   		   		<img src="image/main_logo.png" width="50" height="50"></a>
	           <a href="<%=request.getContextPath() %>/movie.do" >영화</a>
	           <a href="<%=request.getContextPath() %>/booking.do">예매</a>
	           <a href="<%=request.getContextPath() %>/screen.do">시간표</a>
	           
	           <!-- 권한별 기능 추가 -->
	           
	           <span align="right">
		           <a href="<%=request.getContextPath() %>/mypage.do" >
		   		   		<img src="image/mypage_icon.png" width="20" height="20"></a>
	           </span>
	           
	    </div>
	    
	    
	     
	    <hr>
	           
	</div>
	         
</body>
</html>