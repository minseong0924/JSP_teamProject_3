<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 사용자 관리</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
function getSelectValue(index)
{
	if(confirm('적용하시겠습니까?')){
		var p_id= $('#id'+index).text();
		var p_perchange = $('#perchange'+index).val();
		document.form.action='<%=request.getContextPath()%>/memApply.do?id='+p_id +'&perchange='+p_perchange;
		document.form.submit();
	}
}
</script>


</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	
	<div class="man_all_div" align="center">
		<div class="my_title_div">
			<span>사용자 목록</span>
		</div>
		<div class="man_s_div">
			<form method="post" name="submit"
				action="<%=request.getContextPath()%>/memberSearch.do">
					<select name="search_field">
						<option value="member_id">ID</option>
						<option value="member_name">이름</option>
						<option value="member_phone">전화번호</option>
					</select> <input name="search_name" placeholder="내용을 입력하세요">
						 <input class="icon_btn" type="submit" value="&#xf002;">
						 
			</form>
		</div>
		<form name="form" method="post"
			action="<%=request.getContextPath()%>/memApply.do">
		<div class="my_boo_div">
		<table class="table table-hover boo_table">
			<tr class="boo_table_tr">			
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
						<td><input type="button" class="btn table_btn" onclick="getSelectValue(${status.index})" value="적용"></td>
						<td><input type="button" value="삭제" class="btn table_btn"
							onclick="if(confirm('정말 삭제하시겠습니까?')) {
							location.href='memDelete.do?id=${dto.getId()}'}else{return;}"></td>
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

<%-- 				<c:if test="${page > block }">
			      <a href="memberManagement.do?page=1">[맨처음]</a>
			      <a href="memberManagement.do?page=${startBlock - 1 }">◀</a>
			   </c:if>
			   
			   <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			      <c:if test="${i == page }">
			         <b><a href="memberManagement.do?page=${i }">[${i }]</a></b>
			      </c:if>
			      
			      <c:if test="${i != page }">
			         <a href="memberManagement.do?page=${i }">[${i }]</a>
			      </c:if>
			   </c:forEach>
			   
			   <c:if test="${endBlock < allPage }">
			      <a href="memberManagement.do?page=${endBlock + 1 }">▶</a>
			      <a href="memberManagement.do?page=${allPage }">[마지막]</a>
			   </c:if> --%>
			   
			<nav>
			  <ul class="pagination">
			  	<c:if test="${page > block }">
				    <li>
				      <a href="memberManagement.do?page=${startBlock - 1 }" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
			    </c:if>
			    
			    <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
				    <c:if test="${i == page }">
						<li class="active"><a href="memberManagement.do?page=${i }">${i }</a></li>
					</c:if>
					
					<c:if test="${i != page }">
						<li><a href="memberManagement.do?page=${i }">${i }</a></li>
					</c:if>
			    </c:forEach>
			    
			    <c:if test="${endBlock < allPage }">
				    <li>
				      <a href="memberManagement.do?page=${endBlock + 1 }" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
			    </c:if>
			  </ul>
			</nav>
		</div>
		
		<jsp:include page="../include/mfooter.jsp" />
</body>
</html>