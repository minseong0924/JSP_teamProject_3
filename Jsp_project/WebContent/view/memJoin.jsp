<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍용박스 : 가입하기</title>
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
      	//연락처체크 여부
		if ($("#phcheck_hidden").val() != "1") {
			alert("연락처를 확인해주십시오.");
        	return false;
        }
      	
		//생년월일체크 여부
		if ($("#birthcheck_hidden").val() != "1") {
			alert("생년월일을 확인해주십시오.");
        	return false;
        }
	    
		//중복체크 여부
		if ($("#idcheck_hidden").val() == "1") {
            return true;
        } else {
        	alert("아이디 중복체크 해주십시오.");
        	return false;
        }
	}
	
	$(function () {
		$("#userid").keypress(function() {
			$("#idcheck_hidden").val("");
		});
	});
	
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

	$(function () {
		$("#idcheck_btn").mousedown(function() {
			$("#idcheck").hide();
			
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
	        if ($("#userid").val().indexOf(" ") >= 0) {
	            alert("아이디에 공백을 사용할 수 없습니다.")
	            $("#userid").focus();
	            $("#userid").select();
	            return false;
	        }
			
			//아이디 형식 체크
			for (var i = 0; i < $("#userid").val().length; i++) {
	            ch = $("#userid").val().charAt(i)
	            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
	                alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.")
	                $("#userid").focus();
	                $("#userid").select();
	                return false;
	            }
	        }
			
			$.ajax({
				type:"post",
				url: "/Jsp_project/memIdCheck.do",
				data: {"paramId" : $("#userid").val()},
				success: function(data) {
					if($.trim(data) == 1) {
						let warningTxt = '<font color="red">이미 존재하는 아이디입니다.</font>';
						$("#idcheck").text("");
						$("#idcheck").show();
						$("#idcheck").append(warningTxt);
						$("#userid").focus();
						$("#idcheck_hidden").val("");
					} else {
						let warningTxt = '<font color="blue">사용가능한 아이디입니다.</font>';
						$("#idcheck").text("");
						$("#idcheck").show();
						$("#idcheck").append(warningTxt);
						$("#idcheck_hidden").val("1");
					}
				},
				error: function(request,status,error){
			        alert("code:"+request.status+"\n"
			        		+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
	});
	
	//생년월일 유효성 체크
	function isValidDate(dateStr) {
	     var year = Number(dateStr.substr(0,4)); 
	     var month = Number(dateStr.substr(4,2));
	     var day = Number(dateStr.substr(6,2));
	     var today = new Date();
	     var yearNow = today.getFullYear();
	 
	     if (year < 1900){
	    	 $("#birthcheck").text("잘못된 연도입니다.");
	          return false;
	     }
	     if (month < 1 || month > 12) { 
	    	 $("#birthcheck").text("달은 1월부터 12월까지 입력 가능합니다.");
	          return false;
	     }
	     if (day < 1 || day > 31) {
	    	 $("#birthcheck").text("일은 1일부터 31일까지 입력가능합니다.");
	          return false;
	     }
	     if ((month==4 || month==6 || month==9 || month==11) && day==31) {
	    	 $("#birthcheck").text(month+"월은 31일이 존재하지 않습니다.");
	          return false;
	     }
	     if (month == 2) {
	          var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
	          if (day>29 || (day==29 && !isleap)) {
	        	  $("#birthcheck").text(year + "년 2월은  " + day + "일이 없습니다.");
	               return false;
	          }
	     }
	     return true;
	}
	
	$(function () {
		$("#userbirth").keyup(function() {
			//생년월일 유효성 체크
			if($.trim($("#userbirth").val()).length == 8) {
				if(isValidDate($("#userbirth").val()))	{
					$("#birthcheck").text('');
					$("#birthcheck").hide();
					$("#birthcheck_hidden").val("1");
				} else {
					$("#userbirth").focus();
					$("#birthcheck_hidden").val("");
				}
			} else {
				let warningTxt = '<font color="red">생년월일은 8자여야합니다.</font>';
				$("#birthcheck").text('');
				$("#birthcheck").show();
				$("#birthcheck").append(warningTxt);
				$("#userbirth").focus();
			}
		});
		
	});

</script>
</head>
<body>
	<jsp:include page="../include/mheader.jsp"/>
	<div class="join_all_div" align="center">
		<form name="memJoin" method="post" onsubmit="return allCheck()" 
			action="<%=request.getContextPath() %>/memberJoinOk.do">
			<div class="join_title_div">회원가입</div>
			<table class="memJoin">
				<tr>
					<td>이름</td>
					<td><input id="username" name="username" class="form-control" required></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td>
						<div class="input-group">
					      <input name="userid" id="userid" class="form-control" placeholder="4자 이상 16자 이하" required>
					      <span class="input-group-btn">
					        <button class="btn join_btn" type="button" value="중복체크" id="idcheck_btn">id check</button>
					      </span>
					    </div>
					    <span id="idcheck"></span>
						<input type="hidden" id="idcheck_hidden">
					</td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" id="userpwd" name="userpwd" class="form-control" required></td>
				</tr>
				
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="userpwd_ok" name="userpwd_ok" class="form-control" required></td>
				</tr>
				
				<tr>
					<td>생년월일</td>
					<td>
						<input id="userbirth" name="userbirth" class="form-control" maxlength="8" placeholder="생년월일 앞8자리 예)19901212" required>
						<span id="birthcheck"></span>
						<input type="hidden" id="birthcheck_hidden">
					</td>
				</tr>
				
				<tr>
					<td>연락처</td>
					<td>
						<input placeholder="'-' 제외 예) 01012341234" maxlength="11" id="userphone" name="userphone" class="form-control" required>
						<span id="phcheck"></span>
						<input type="hidden" id="phcheck_hidden">
					</td>
				</tr>
				<tr>
					  <td colspan="2" align="center">
						<button type="submit" class="btn join_btn">회원가입</button>
						<button type="button" class="btn" 
							onclick="history.back()">돌아가기</button>
					</td>
				</tr>
			</table>			
		</form>
	</div>
	<jsp:include page="../include/mfooter.jsp" />
</body>
</html>