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
	   		<!-- ���ǿ� �̸��� ������ �̸� ��� / ������ �α��� ��ư ��� -->
	   		
	   		<c:if test="${!empty session_name }">
	   			<a href="#">${session_name }�� ȯ���մϴ�.</a>
	   			<a href="<%=request.getContextPath() %>/logout.do">�α׾ƿ�</a>
	   		</c:if>
	   		
	   		<c:if test="${empty session_name }">
	   			<a href="<%=request.getContextPath() %>/login.do">�α���</a>&nbsp;
	   			<a href="<%=request.getContextPath() %>/join.do">ȸ������</a>
	   		</c:if>
	   	</section>
	   	
	   	<div id="head_menu">
	   		   <a id="menu" href="<%=request.getContextPath() %>/allmenu.do" >
	   		   		<img src="image/menu_icon.png" width="20" height="20"></a>
	   		   <a href="<%=request.getContextPath() %>/mian.do" >
	   		   		<img src="image/main_logo.png" width="50" height="50"></a>
	           <a href="<%=request.getContextPath() %>/movie.do" >��ȭ</a>
	           <a href="<%=request.getContextPath() %>/booking.do">����</a>
	           <a href="<%=request.getContextPath() %>/screen.do">�ð�ǥ</a>
	           
	           <!-- ���Ѻ� ��� �߰� -->
	           
	           <span align="right">
		           <a href="<%=request.getContextPath() %>/mypage.do" >
		   		   		<img src="image/mypage_icon.png" width="20" height="20"></a>
	           </span>
	           
	    </div>
	    
	    
	     
	    <hr>
	           
	</div>
	         
</body>
</html>