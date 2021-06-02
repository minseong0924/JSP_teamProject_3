<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

	*{margin: 0px; padding: 0px;}
	ul{list-style: none;}	/* .제거 */
	a{text-decoration: none;}	/* 밑줄 제거 */
	
	/* 상단 메뉴 */
	.top{
		padding-top: 10px;
		padding-bottom: 10px;
	}
	
	header{
		border-top: 3px solid gray;
		border-bottom: 3px solid gray;
		width: 100%;
		height: 94px;
		position: relative;
	}
	
	.top_nav{
		position: absolute;
		vertical-align: middle;
		font-size: 20px;
		left: 120px;
	}
	
	.top_nav ul li{
		vertical-align: middle;
		display: inline;
		padding-right: 140px;
	}
	
	
	/* 사이드 메뉴 */
	div#left{
		width: 15%;
		height: auto;
		border-right: 3px solid gray;
		float: left;
	}
	
	.side_nav{
		font-size: 20px;
	}
	
	.side_nav ul li{
		text-align: center;
		padding-top: 35px;
		padding-bottom: 35px;
	}
	
	div#content{
		width: 84.8%;
		height: auto;
		float: right;
		
	}
	
	div#top1{
		padding: 30px 0px 30px 80px;
		font-weight: bold;
		font-size: 25px;
	}
	
	
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="top" align="right">
		<a href="<%=request.getContextPath() %>/member_login.do">로그인</a>
			&nbsp;&nbsp;&nbsp;
		<a href="<%=request.getContextPath() %>/admin_login.do">회원가입</a>
			&nbsp;&nbsp;&nbsp;
	</div>
	
	<div>
		<header>
			<nav class="top_nav">
				<ul>
					<li><a href="#">메뉴</a></li>
					<li><img src="img/logo.png"></li>
					<li><a href="#">영화</a></li>
					<li><a href="#">예매</a></li>
					<li><a href="#">극장</a></li>
					<li><a href="#">사용자 관리</a></li>
					<li><a href="#">홈페이지 관리</a></li>
					<li><a href="#">마이페이지</a></li>
				</ul>
			</nav>
		</header>
	</div>
	
	
	<div id="left">
		<nav class="side_nav">
			<ul>
				<li><a href="#">서울</a></li>
				<li><a href="#">경기</a></li>
				<li><a href="#">인천</a></li>
				<li><a href="#">대전/충청/세종</a></li>
				<li><a href="#">부산/대구/경상</a></li>
				<li><a href="#">광주/전라</a></li>
				<li><a href="#">강원</a></li>
				<li><a href="#">제주</a></li>
			</ul>
		</nav>
	</div>
	
	<div id="content">
		<div id="top1">지점 관리</div>
		
		<div id="top2">
			지점명&nbsp;&nbsp;
			<input type="text" id="localname">
		</div>
	</div>
	
</body>
</html>