<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<jsp:include page="include/mheader.jsp" />
	
	<div align="center">
		<div class="title">
			<h2>지점 정보 등록/수정</h2>
			<br>
			<br>
		<form method="post" action="<%=request.getContextPath() %>/cinemaWriteOk.do">
			<table class="movieWrite">
				<tr>
					<th>분 류 : </th>
					<td>
						<select name="local_code">
							<c:if test="${empty locallist }">
								<option value="">:::저장된 지역 없음:::</option>
				          	</c:if>
				          	
				          	<c:if test="${!empty locallist }">
				          		<c:forEach items="${locallist }" var="ldto">
				          			<option value="${ldto.localcode }">${ldto.localname }</option>
				          		</c:forEach>
			             	</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>지 점 명 : </th>
					<td><input type="text" name="cinema_name"></td>			
				</tr>
				
				<tr>
					<th>지점 소개 : </th>
					<td> <textarea rows="5" cols="50" name="cinema_intro"></textarea> </td>
				</tr>
				
				<tr>
					<th>주 소 : </th>
					<td><input type="text" name="cinema_address"> </td>
				</tr>
				
				<tr>
					<th>사용할 관 : </th>
					<td>
						<input type="checkbox" name="cin_check" value="1"> 1관
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="cin_check" value="2"> 2관
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<input type="checkbox" name="cin_check" value="3"> 3관
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="cin_check" value="4"> 4관
					</td>
				</tr>
				
				<tr>
					<th></th>
					<td>
						<input type="checkbox" name="cin_check" value="5"> 5관
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="cin_check" value="6"> 6관
					</td>
				</tr>
				
				<tr>
					<td colspan="4" align="right">
						<input type="submit" value="등록">
					</td>
				</tr>
				
			</table>
		</form>
		</div>
	</div>
	<jsp:include page="include/mfooter.jsp" />

</body>
</html>