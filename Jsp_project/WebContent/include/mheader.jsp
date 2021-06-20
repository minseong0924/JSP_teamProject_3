<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta charset="UTF-8">

<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="./js/loginout.js"></script>
<script>
	
    window.onload = function() {
	    //document.getElementById('modal_btn').addEventListener('click', onClick);
	    document.querySelector('.modal_close').addEventListener('click', offClick);

	};
	
	function goLogout() {
		var con_res = confirm("로그아웃 하시겠습니까?");
		
		if(con_res == true){
			location.href = "<%=request.getContextPath() %>/memberLogout.do";
		}
	}
</script>

<div style="border-bottom: 1px solid #474747;">
	
	<div align="right">
		<nav class="navbar navbar-expand-sm">
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<c:if test="${memSession.permission == '관리자'}">
						<li class="nav-item">
							<a class="nav-link nav_a_color" href="<%=request.getContextPath() %>/memberManagement.do">사용자관리</a> 
						</li>
						
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle nav_a_color" href="#" data-toggle="dropdown">홈페이지관리</a> 
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="<%=request.getContextPath()%>/cinemaList.do">전체 지점 목록</a></li>
								<li><a class="dropdown-item" href="<%=request.getContextPath()%>/cinemaWrite.do">지점 등록</a></li>
								<li><a class="dropdown-item" href="<%=request.getContextPath()%>/movieList.do">전체 영화 목록</a></li>
								<li><a class="dropdown-item" href="<%=request.getContextPath()%>/movieWrite.do">영화 등록</a></li>
								<li><a class="dropdown-item" href="<%=request.getContextPath() %>/movieScreenSetting.do">영화 상영 설정</a></li>
							</ul> 
						</li>
					</c:if>
	
					<c:if test="${!empty memSession }">
			   			<li class="nav-item"><a href="#" class="nav_a_color">${memSession.name }님 환영합니다.</a></li>
			   			<li class="nav-item"><a href="javascript:goLogout()" class="nav_a_color">로그아웃</a><li>
			   		</c:if>
			   		
	
			   		<c:if test="${empty memSession }">
			   			<li class="nav-item"><a href="javascript:onClick()" class="nav_a_color">로그인</a></li>
			   			<li class="nav-item"><a href="<%=request.getContextPath() %>/memberJoinReady.do" class="nav_a_color">회원가입</a></li>
			   		</c:if>
				</ul>
			</div>
		</nav>
	</div>
	
	<div align="center" class="nav_bg">
		<nav class="navbar navbar-expand-sm">
			<!-- 메뉴 설정 -->
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="nav-item"> 
						<a class="nav-link nav_a" href="<%=request.getContextPath()%>/mainList.do">홈</a> 
					</li> 
					
					<li class="nav-item dropdown">
						<a class="nav-link nav_a" href="<%=request.getContextPath() %>/movieChart.do">전체영화 </a> 
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link nav_a" href="<%=request.getContextPath()%>/movieQuickBooking.do">예매</a>  
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link nav_a" href="<%=request.getContextPath() %>/timeTable.do">상영시간표 </a> 
					</li>
				</ul>
				
				<ul class="nav navbar-nav navbar-right">
					<c:if test="${!empty memSession }">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle nav_a" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }" data-toggle="dropdown"><i class='glyphicon glyphicon-user'></i> MY</a> 
							<ul class="dropdown-menu">
								 <li><a class="dropdown-item" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
                            	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역 관리</a></li>
                            	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/memPwdChk.do?memid=${memSession.id }">개인정보 수정</a></li>
							</ul> 
						</li>
					</c:if>
				</ul>
			</div>
		</nav>
	</div>
</div>
<jsp:include page="../view/memLogin.jsp"/>