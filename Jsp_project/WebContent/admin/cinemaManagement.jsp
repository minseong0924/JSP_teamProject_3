<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 지점 관리</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div class="man_all_div" align="center">
		<div class="my_title_div">
			<span>지점 목록</span>
		</div>
		<div class="man_s_div">
			<form method="post"
				action="<%=request.getContextPath() %>/cinemaSearch.do">
					<select name="local_code" required>
						<c:set var="llist" value="${List }" />
						<c:set var="clist" value="${list }" />
						<c:if test="${empty llist }">
							<option value="">:::저장된 지역 없음:::</option>
						</c:if>
		
						<c:if test="${!empty llist }">
							<c:forEach items="${llist }" var="dto">
								<option value="${dto.localcode }">${dto.localname }</option>
							</c:forEach>
						</c:if>
					</select>
					&nbsp;&nbsp;
					<input class="icon_btn" type="submit" value="&#xf002;">
			</form>
		</div>
		
		<div class="my_boo_div">
			<table class="table table-hover boo_table">
				<tr class="boo_table_tr">
					<th>지점이름</th>
					<th>주소</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<c:if test="${!empty clist}">
					<c:forEach items="${clist }" var="dto">
						<tr>
							<td>${dto.cinemaname }</td>
							<td>${dto.address }</td>
							<td><input type="button" value="수정" class="btn table_btn"
								onclick="location.href='cinemaEdit.do?cinemaCode=${dto.cinemacode }'"></td>
							<td><input type="button" value="삭제" class="btn table_btn"
								onclick="if(confirm('정말 삭제하시겠습니까?')){location.href='cinemaDelete.do?cinemaCode=${dto.cinemacode }'}
										else{return false}"></td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${empty clist}">
					<tr>
						<td colspan="4" align="center">검색된 데이터가 없습니다.</td>
					<tr>
				</c:if>
			</table>
		</div>
		
		<br><br>
		<div class="foot_div">
			<input type="button" value="지점등록" class="btn join_btn"
				onclick="location.href='<%=request.getContextPath()%>/cinemaWrite.do'">
		</div>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
	
</body>
</html>