<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSANG YOUNG BOX</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style type="text/css">

	.box_movie {
		float: left;
	}
	
	.box_movie ul {
		list-style:none;
	}

</style>
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
			<li><img src="https://movie-phinf.pstatic.net/20210421_37/1618971733493B4ykS_JPEG/movie_image.jpg"
				width="200" height="300"></li>
			
			<li><button onclick="booking()" value="예매"></button></li>
		</div>
		
	</div>
	<jsp:include page="include/mfooter.jsp" />
</body>
</html>