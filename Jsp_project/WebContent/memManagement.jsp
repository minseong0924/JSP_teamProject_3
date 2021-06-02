<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.userList{
		text-align : left;
		margin-left : 400px;
	}
	.search{
		text-align :right;
		margin-right : 300px;
	}

</style>
</head>
<body>
	
	<div align="center">
		<div class="userList">
		<h2>사용자 목록</h2>
		<br><br>
		</div>
		<form method="post" action="<%=request.getContextPath() %>/memberSearch.do">
			<div class="search">
				<select name="search_member">
					<option value="member_id">ID</option>
					<option value="member_name">이름</option>
					<option value="member_phone">전화번호</option>
				</select>
			 <input name="search" value="검색할 내용을 입력하세요" >
			 <input type="submit" value="검색">
			</div>
		</form>
		<br><br><br>
		<c:set var="list" value="${List }"/>
		<table border="0" cellspacing="0" width="900">
			<tr>
				<th>ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>권한</th>
				<th>적용</th>
				<th>삭제</th>
			</tr>
			
			<%-- 
			<c:if test="${!empty List}"> 
			<c:forEach items="${List }" var="dto" begin="1" end="${totalRecord}">
				<tr>
					<td>${dto.getId() }</td>
					<td>${dto.getName() }</td>
					<td>${dto.getPhone() }</td>
					<td>
						<select name="perchange">
							<c:if test="${dto.getPermission() eq "관리자" }">
								<option value="관리자">관리자</option>
								<option value="회원">회원</option>
							</c:if>
							<c:if test="${dto.getPermission() eq "회원" }">
								<option value="회원">회원</option>
								<option value="관리자">관리자</option>
							</c:if>
						</select>
					<td> <input type="button" value="적용"
								onclick="location.href"='apply.do?id=${dto.getId()}'>
					</td>
					<td> <input type="button" value="삭제"
								onclick="location.href"='memDelete.do?id=${dto.getId()}'>
					</td>
				</tr>
			</c:forEach>
			</c:if>
			--%>
			
		</table>
	</div>

</body>
</html>