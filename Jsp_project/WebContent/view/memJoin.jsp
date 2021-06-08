<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>SSANG YOUNG BOX</title>
<link rel="stylesheet" href="./css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">

	function allCheck() {

		//아이디 비밀번호 동일 여부 체크
		if ($("#userid").val() == $("#userpwd").val()) {
            alert("아이디와 비밀번호가 같습니다.");
            $("#userpwd").focus();
            return false;
	    }
		 
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
	    
	    //연락처 형식 체크
	    for (var i = 0; i < $("#userphone").val().length; i++) {
            ch = $("#userphone").val().charAt(i)
            if (!(ch >= '0' && ch <= '9')) {
                alert("연락처는 숫자만 입력가능합니다.");
                $("#userphone").focus();
                $("#userphone").select();
                return false;
            }
        }
	    
	    //연락처 길이 체크
	    if ($("#userphone").val().length < 11) {
	        alert("연락처 길이가 올바르지 않습니다.");
	        $("#userphone").focus();
	        $("#userphone").select();
	        return false;
	    }

	    $("#idcheck").hide();
		let userId = $("#userid").val();
		
		//아이디 길이 체크(4자이상)
		if($.trim($("#userid").val()).length < 4) {
			let warningTxt = '<font color="red">아이디는 4자 이상이어야 합니다.</font>';
			$("#idcheck").text('');
			$("#idcheck").show();
			$("#idcheck").append(warningTxt);
			$("#userid").focus();
			return false;
		}
		
		//아이디 길이 체크(16자이하)
		if($.trim($("#userid").val()).length > 16) {
			let warningTxt = '<font color="red">아이디는 16자 이하여야합니다.</font>';
			$("#idcheck").text('');
			$("#idcheck").show();
			$("#idcheck").append(warningTxt);
			$("#userid").focus();
			return false;
		}
		
		//아이디에 공백 체크
        if (userId.indexOf(" ") >= 0) {
            alert("아이디에 공백을 사용할 수 없습니다.")
            $("#userid").focus();
            $("#userid").select();
            return false;
        }
		
		//아이디 형식 체크
		for (var i = 0; i < userId.length; i++) {
            ch = userId.charAt(i)
            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
                alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.")
                $("#userid").focus();
                $("#userid").select();
                return false;
            }
        }
		
		var idpass = false;
		
		//아이디 중복 체크
		$.ajax({
			type:"post",
			url: "data/memJoinCheck.jsp",
			data: {"paramId" : userId},
			success: function(data) {
				if($.trim(data) == 1) {
					let warningTxt = '<font color="red">이미 존재하는 아이디입니다.</font>';
					$("#idcheck").text("");
					$("#idcheck").show();
					$("#idcheck").append(warningTxt);
					$("member_id").val("").focus();
					idpass = false;
				} else {
					let warningTxt = '<font color="blue">사용가능한 아이디입니다.</font>';
					$("#idcheck").text("");
					$("#idcheck").show();
					$("#idcheck").append(warningTxt);
					idpass = true;
				}
			},
			error: function(request,status,error){
		        alert("code:"+request.status+"\n"
		        		+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		if(idpass == false) {
			return false;
		} else {
			return true;
		}
		
	}

	$(function idcheck() {
		$("#idcheck_btn").mousedown(function() {
			$("#idcheck").hide();
			let userId = $("#userid").val();
			
			//아이디 길이 체크
			if($.trim($("#userid").val()).length < 4) {
				let warningTxt = '<font color="red">아이디는 4자 이상이어야 합니다.</font>';
				$("#idcheck").text('');
				$("#idcheck").show();
				$("#idcheck").append(warningTxt);
				$("#userid").focus();
				return false;
			}
			
			//아이디 길이 체크
			if($.trim($("#userid").val()).length > 16) {
				let warningTxt = '<font color="red">아이디는 16자 이하여야합니다.</font>';
				$("#idcheck").text('');
				$("#idcheck").show();
				$("#idcheck").append(warningTxt);
				$("#userid").focus();
				return false;
			}
			
			//아이디에 공백 체크
	        if (userId.indexOf(" ") >= 0) {
	            alert("아이디에 공백을 사용할 수 없습니다.")
	            $("#userid").focus();
	            $("#userid").select();
	            return false;
	        }
			
			//아이디 형식 체크
			for (var i = 0; i < userId.length; i++) {
	            ch = userId.charAt(i)
	            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
	                alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.")
	                $("#userid").focus();
	                $("#userid").select();
	                return false;
	            }
	        }
			
			$.ajax({
				type:"post",
				url: "data/memJoinCheck.jsp",
				data: {"paramId" : userId},
				success: function(data) {
					if($.trim(data) == 1) {
						let warningTxt = '<font color="red">이미 존재하는 아이디입니다.</font>';
						$("#idcheck").text("");
						$("#idcheck").show();
						$("#idcheck").append(warningTxt);
						$("member_id").val("").focus();
						return false;
					} else {
						let warningTxt = '<font color="blue">사용가능한 아이디입니다.</font>';
						$("#idcheck").text("");
						$("#idcheck").show();
						$("#idcheck").append(warningTxt);
						return true;
					}
				},
				error: function(request,status,error){
			        alert("code:"+request.status+"\n"
			        		+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
	});
	
	$(document).ready(function() {
		$("#userbirth").val(new Date().toISOString().slice(0, 10));
		$("#userbirth").max(new Date().toISOString().slice(0, 10));
		
    });
</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp"/>
	<br><br>
	<div align="center">
		<form name="memJoin" method="post" onsubmit="return allCheck()" 
			action="<%=request.getContextPath() %>/memberJoin_ok.do" 
			onsubmit="return checkValue()">

			<table class="memJoin">
				<tr>
					<td colspan="2" align="center"><h3>회원가입</h3></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input id="username" name="username" required></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td>
						<input name="userid" id="userid" required>
						<input type="button" value="중복체크" id="idcheck_btn" class="btn btn-default">
						<br><span id="idcheck"></span>
					</td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" id="userpwd" name="userpwd" required></td>
				</tr>
				
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="userpwd_ok" name="userpwd_ok" required></td>
				</tr>
				
				<tr>
					<td>생년월일</td>
					<td><input type="date" id="userbirth" name="userbirth" required></td>
				</tr>
				
				<tr>
					<td>연락처</td>
					<td><input placeholder="예) 01012341234" maxlength="11" id="userphone" name="userphone" required></td>
				</tr>
				<tr>
					  <td colspan="2" align="center">
						<button type="submit" class="btn btn-success">회원가입</button>
						<button type="button" class="btn btn-default" 
							onclick="history.back()">돌아가기</button>
					</td>
				</tr>
			</table>			
		</form>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>