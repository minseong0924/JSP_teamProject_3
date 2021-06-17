<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
function getSelectValue(index)
{
	if(confirm('적용하시겠습니까?')){
		var p_id= $('#id'+index).text();
		var p_perchange = $('#perchange'+index).val();
		document.form.action='<%=request.getContextPath()%>/memberSearch.do?id='+p_id +'&perchange='+p_perchange;
		document.form.submit();
	}
}
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	
	<div align="center">
		<div class="title">
			<h2>사용자 목록</h2>
			<br>
			<br>
		</div>
		<form method="post"
			action="<%=request.getContextPath()%>/memberSearch.do">
			<div class="search">
				<select name="search_field">
					<option value="member_id">ID</option>
					<option value="member_name">이름</option>
					<option value="member_phone">전화번호</option>
				</select> <input name="search_name" placeholder="내용을 입력하세요">
					 <input type="submit" value="검색">
			</div>
		</form>
		<br>
		<br>
		<br>
		
		<form name="form" method="post"
			action="<%=request.getContextPath()%>/memApply.do">
		<div style="width:900px;" align="center">
		<table class="table table-striped table-hover">
			<tr >			
				<th>ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>권한</th>
				<th>적용</th>
				<th>삭제</th>
			</tr>
						
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list}">
				<c:forEach items="${list }" var="dto" varStatus="status">
				<input type="hidden" name="search_field" value="${search_field}">
				<input type="hidden" name="search_name" value="${search_name}">
					<tr>
						<td id="id${status.index}">${dto.getId() }</td>
						<td>${dto.getName() }</td>
						<td>${dto.getPhone() }</td>
						<td><select id="perchange${status.index}" name="perchange">
								<c:if test="${dto.getPermission() == '관리자' }">
									<option value="관리자">관리자</option>
									<option value="회원">회원</option>
								</c:if>
								<c:if test="${dto.getPermission() == '회원' }">
									<option value="회원">회원</option>
									<option value="관리자">관리자</option>
								</c:if>
						</select></td>
						<td><input type="button" onclick="getSelectValue(${status.index})" value="적용"></td>
						<td><input type="button" value="삭제"
							onclick="location.href='memDelete.do?id=${dto.getId()}'"></td>
					</tr>
					
				</c:forEach>
			</c:if>

			<c:if test="${empty List}">
				<tr>
					<td colspan="7" align="center">검색된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</table>
		</div>
		</form>
		
		<br><br>

			<c:if test="${page > block }">
				<a href="memberSearch.do?page=1&search_field=${search_field }&search_name=${search_name }">[맨처음]</a>
				<a href="memberSearch.do?page=${startBlock - 1 }&search_field=${search_field }&search_name=${search_name }">◀</a>
			</c:if>

			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
				<c:if test="${i == page }">
					<b><a href="memberSearch.do?page=${i }&search_field=${search_field }&search_name=${search_name }">[${i }]</a></b>
				</c:if>

				<c:if test="${i != page }">
					<a
						href="memberSearch.do?page=${i }&search_field=${search_field }&search_name=${search_name }">[${i }]</a>
				</c:if>
			</c:forEach>

			<c:if test="${endBlock < allPage }">
				<a href="memberSearch.do?page=${endBlock + 1 }&search_field=${search_field }&search_name=${search_name }">▶</a>
				<a href="memberSearch.do?page=${allPage }&search_field=${search_field }&search_name=${search_name }">[마지막]</a>
			</c:if>
		</div>
		
		<jsp:include page="../include/mfooter.jsp" />
		
		
</body>
</html>