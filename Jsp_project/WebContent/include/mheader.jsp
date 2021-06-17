<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta charset="UTF-8">

<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>

	function onClick() {
	    document.querySelector('.modal_wrap').style.display ='block';
	    document.querySelector('.black_bg').style.display ='block';
	}
	
	function offClick() {
	    document.querySelector('.modal_wrap').style.display ='none';
	    document.querySelector('.black_bg').style.display ='none';
	}
	
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

<div style="margin:20px;">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
			<!-- 네비게이션(nav)의 기본 설정으로 모바일일 때, 메뉴 버튼이 나온다. -->
			<div class="navbar-header">
				<button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<!-- 타이틀임. -->
				<a class="navbar-brand" href="#">
					<img src="https://ifh.cc/g/d9o1KQ.png" width="25" height="25">
				</a>
			</div>
			
			<!-- 메뉴 설정 -->
			<div class="collapse navbar-collapse">
				<!-- 메뉴는 왼쪽으로 두개 설정 -->
				<ul class="nav navbar-nav">
					<li class="nav-item"> 
						<a class="nav-link active" href="<%=request.getContextPath()%>/mainList.do">홈</a> 
					</li> 
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> 영화 </a> 
						<ul class="dropdown-menu"> 
							<li><a class="dropdown-item" href="<%=request.getContextPath() %>/movieChart.do">전체영화</a></li>
							<li><a class="dropdown-item" href="#">N스크린</a></li>
							<li><a class="dropdown-item" href="#">무비포스트</a></li>
						</ul> 
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> 예매 </a> 
						<ul class="dropdown-menu"> 
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/movieQuickBooking.do">빠른예매</a></li>
							<li><a class="dropdown-item" href="#">더프라이빗 예매</a></li>
						</ul> 
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="<%=request.getContextPath() %>/timeTable.do">상영시간표 </a> 
					</li>
					
					
					<!-- 관리자일 때 if문 추가 -->
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/memberManagement.do"> 사용자관리 </a> 
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> 홈페이지관리 </a> 
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/cinemaList.do">전체 지점 목록</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/cinemaWrite.do">지점 등록</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/movieList.do">전체 영화 목록</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/movieWrite.do">영화 등록</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath() %>/movieScreenSetting.do">영화 상영 설정</a></li>
						</ul> 
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"> 마이페이지 </a> 
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/myPageEdit.do?memid=${memSession.id }">개인정보 수정</a></li>
						</ul> 
					</li>
					
				</ul>
				
				
				
				<!-- 메뉴를 오른쪽 정렬로 설정 가능 -->
				<ul class="nav navbar-nav navbar-right">

					<c:if test="${!empty memSession }">
			   			<li class="nav-item"><a href="#">${memSession.name }님 환영합니다.</a></li>
			   			<li class="nav-item"><a href="javascript:goLogout()">로그아웃</a><li>
			   		</c:if>
			   		

			   		<c:if test="${empty memSession }">
			   			<li class="nav-item"><a href="javascript:onClick()">로그인</a></li>
			   			<li class="nav-item"><a href="<%=request.getContextPath() %>/memberJoinReady.do">회원가입</a></li>
			   		</c:if>
				</ul>
			</div>
	</nav>
</div>
<jsp:include page="../view/memLogin.jsp"/>