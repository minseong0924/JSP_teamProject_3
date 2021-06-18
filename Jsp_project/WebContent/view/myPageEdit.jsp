<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 개인정보수정</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">

	function allCheck() {
		
		//비밀번호 길이 체크(4~12자 까지 허용)
	    if ($("#userpwd").val().length < 4 || $("#userpwd").val().length > 12) {
	        alert("비밀번호를 4~12자까지 입력해주세요.");
	        $("#userpwd").focus();
	        $("#userpwd").select();
	        return false;
	    }
	    
	    //비밀번호와 비밀번호 확인 일치여부 체크
	    if ($("#userpwd").val() != $("#userpwd_ok").val()) {
	        alert("비밀번호가 일치하지 않습니다.");
	        $("#userpwd_ok").val("");
	        $("#userpwd_ok").focus();
	        return false;
	    }
	    
	    //이름 길이 체크
        if($("#username").val() < 2){
            alert("이름을 2자 이상 입력해주십시오.");
            $("#username").focus();
            return false;
        }
      	//연락처체크 여부
		if ($("#phcheck_hidden").val() != "1") {
			alert("연락처를 확인해주십시오.");
        	return false;
        }
	}
	
	$(function () {
		$("#userphone").keyup(function() {
			$("#phcheck_hidden").val("");
			
			//연락처 형식 체크
		    for (var i = 0; i < $("#userphone").val().length; i++) {
	            ch = $("#userphone").val().charAt(i)
	            if (!(ch >= '0' && ch <= '9')) {
	                let warningTxt = '<font color="red">연락처는 숫자만 입력가능합니다.</font>';
					$("#phcheck").text("");
					$("#phcheck").show();
					$("#phcheck").append(warningTxt);
					$("#phcheck_hidden").val("");
	            }
	        }
		    
		    //연락처 길이 체크
		    if ($("#userphone").val().length < 11) {
		        let warningTxt = '<font color="red">연락처 길이가 올바르지 않습니다.</font>';
				$("#phcheck").text("");
				$("#phcheck").show();
				$("#phcheck").append(warningTxt);
				$("#phcheck_hidden").val("");
		    }
			
		    if ($("#userphone").val().length >= 11) {
				$.ajax({
					type:"post",
					url: "/Jsp_project/memPhoneCheck.do",
					data: {"paramPh" : $("#userphone").val()},
					success: function(data) {
						if($.trim(data) == 1) {
							let warningTxt = '<font color="red">이미 존재하는 연락처입니다.</font>';
							$("#phcheck").text("");
							$("#phcheck").show();
							$("#phcheck").append(warningTxt);
							$("#phcheck_hidden").val("");
						} else {
							let warningTxt = '<font color="blue">사용가능한 연락처입니다.</font>';
							$("#phcheck").text("");
							$("#phcheck").show();
							$("#phcheck").append(warningTxt);
							$("#phcheck_hidden").val("1");
						}
					},
					error: function(request,status,error){
				        alert("code:"+request.status+"\n"
				        		+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
				
		    }
		});
	});
	
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp" />
	<div style="margin:20px;">
		<nav id="side_bar">
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageMain.do?memid=${memSession.id }">마이페이지</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageBooked.do?memid=${memSession.id }">예매내역</a></li>
			<li><a class="side_menu" href="<%=request.getContextPath()%>/myPageEdit.do?memid=${memSession.id }" onclick="pwdCheck()">개인정보 수정</a></li>
		</nav>
	</div>
	<div align="center">
		<form name="memJoin" method="post" onsubmit="return allCheck()" 
			action="<%=request.getContextPath() %>/myPageEditOk.do?memid=${memSession.id }">
		<div class="title">
			<br><br>
			<h2>개인정보 수정</h2>
			<br><br><br><br>
		</div>
			<c:set var="dto" value="${mlist }"/>
			<table class="memJoin">
				<tr>
					<td>아이디</td>
					<td>
						<input name="userid" id="userid" class="form-control" value="${dto.id }" placeholder="4자 이상 16자 이하" disabled>
					</td>
				</tr>
				
				<tr>
					<td>이름</td>
					<td><input id="username" name="username" class="form-control" value="${dto.name }" required></td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" id="userpwd" name="userpwd" class="form-control" value="${dto.pwd }" required></td>
				</tr>
				
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="userpwd_ok" name="userpwd_ok" class="form-control" value="${dto.pwd }" required></td>
				</tr>
				
				<tr>
					<td>생년월일</td>
					<td>
						<input id="userbirth" name="userbirth" class="form-control" maxlength="8" placeholder="생년월일 앞8자리 예)19901212" value="${dto.birth }" disabled>
						<span id="birthcheck"></span>
						<input type="hidden" id="birthcheck_hidden">
					</td>
				</tr>
				
				<tr>
					<td>연락처</td>
					<td>
						<input placeholder="'-' 제외 예) 01012341234" maxlength="11" id="userphone" name="userphone" class="form-control" value="${dto.phone }" required>
						<span id="phcheck"></span>
						<input type="hidden" id="phcheck_hidden">
					</td>
				</tr>
				<tr>
					  <td colspan="2" align="center">
						<button type="submit" class="btn btn-success">수정</button>
						<button type="button" class="btn btn-default" 
							onclick="history.back()">돌아가기</button>
						&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default"
							onclick="if(confirm('정말 탈퇴하시겠습니까?')){location.href='memberDelete.do?memid=${memSession.id }'}
										else{return false}">탈퇴하기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>