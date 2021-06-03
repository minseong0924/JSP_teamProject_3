<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSANG YOUNG BOX</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<jsp:include page="include/mheader.jsp" />
	<div align="center" class="main_body_title">
		박스오피스
	</div>
	<div align="center" class="main_body_box">
		
		<div class="box_movie">
			<!-- db에서 가져온 값으로 for문 -->
			<ul>
				<li><img src="https://movie-phinf.pstatic.net/20210512_139/1620799657168vGIqq_JPEG/movie_image.jpg"
					width="200" height="300"></li>
				
				<li><button onclick="booking()" value="예매"></button></li>
			</ul>
		</div>
		
		<div class="box_movie">
			<ul>
				<li><img src="https://movie-phinf.pstatic.net/20210421_37/1618971733493B4ykS_JPEG/movie_image.jpg"
					width="200" height="300"></li>
				
				<li><button onclick="booking()" value="예매"></button></li>
			</ul>
		</div>
		
	</div>
	<jsp:include page="include/mfooter.jsp" />
</body>
</html>