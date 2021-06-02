<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">


	
	.dropdown:hover .dropdown-menu {
	    display: block;
	    margin-top: 0;
	}
	
	.dropdown-menu li{
		float: left;
	}
	
	.navbar-right li {
		margin-right: 5px;
		margin-top: 7px;
	}

</style>
</head>
<body>
	<div style="margin:20px;">
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
				<!-- �׺���̼�(nav)�� �⺻ �������� ������� ��, �޴� ��ư�� ���´�. -->
				<div class="navbar-header">
					<button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<!-- Ÿ��Ʋ��. -->
					<a class="navbar-brand" href="#"><img src="image/main_logo.png" width="25" height="25"></a>
				</div>
				
				<!-- �޴� ���� -->
				<div class="collapse navbar-collapse">
					<!-- �޴��� �������� �ΰ� ���� -->
					<ul class="nav navbar-nav">
						<li class="nav-item"> 
							<a class="nav-link active" href="#">Ȩ</a> 
						</li> 
						
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> ��ȭ </a> 
							<ul class="dropdown-menu"> 
								<li><a class="dropdown-item" href="#">��ü��ȭ</a></li>
								<li><a class="dropdown-item" href="#">N��ũ��</a></li>
								<li><a class="dropdown-item" href="#">��������Ʈ</a></li>
							</ul> 
						</li>
						
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> ���� </a> 
							<ul class="dropdown-menu"> 
								<li><a class="dropdown-item" href="#">��������</a></li>
								<li><a class="dropdown-item" href="#">�������̺� ����</a></li>
							</ul> 
						</li>
						
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> �󿵽ð�ǥ </a> 
						</li>
						
						
						<!-- �������� �� if�� �߰� -->
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath() %>/memberManagement.do"> ����ڰ��� </a> 
						</li>
						
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> Ȩ���������� </a> 
							<ul class="dropdown-menu"> 
								<li><a class="dropdown-item" href="#">��ü ��ȭ ���</a></li>
								<li><a class="dropdown-item" href="#">��ȭ ���</a></li>
								<li><a class="dropdown-item" href="<%=request.getContextPath() %>/screen_setting.do">��ȭ �� ����</a></li>
							</ul> 
						</li>
						
					</ul>
					
					<!-- �޴��� ������ ���ķ� ���� ���� -->
					<ul class="nav navbar-nav navbar-right">
					<!-- �޴� �̸��� Right!�� ���� �ɼ��� Test5�� Test6�� �ִ�. -->
						<c:if test="${!empty session_name }">
				   			<li class="nav-item"><a href="#">${session_name }�� ȯ���մϴ�.</a></li>
				   			<li class="nav-item"><a href="<%=request.getContextPath() %>/logout.do">�α׾ƿ�</a><li>
				   		</c:if>
				   		
				   		<c:if test="${empty session_name }">
				   			<!-- onClick()�޼ҵ� �߰��Ұ� -->
				   			<li class="nav-item"><button type="button" class="btn btn-outline-dark m-1">�α���</button></li>
				   			<li class="nav-item"><button type="button" class="btn btn-outline-dark m-1">ȸ������</button></li>
				   		</c:if>
					</ul>
				</div>
		</nav>
	</div>
</body>
</html>