<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<link rel="stylesheet" href="./css/style.css">

<div class="black_bg"></div>
<div class="modal_wrap">
    <div class="modal_close">
    	<a href="#">X</a>
    </div>
    <div align="center" class="login_title">
    	<h4>쌍용박스 로그인</h4>
    </div>
    <div align="center">
		<form method="post" action="<%=request.getContextPath() %>/memberLogin.do">
			<table border="0" cellspacing="1">
				<tr>
					<td><label for="id" class="col-sm-2 control-label">ID</label></td>
					<td><input type="text" name="id" class="form-control" id="id" required></td>
				</tr>
				
				<tr>
					<td><label for="pwd" class="col-sm-2 control-label">PASSWORD</label></td>
					<td><input type="password" name="pwd" class="form-control" id="pwd" required></td>
				</tr>
				
				<tr>
					<td align="center" colspan="2">
						<button type="submit" class="btn btn-default btn-block">LOGIN</button>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<a href="<%=request.getContextPath() %>/memberFindId.do">아이디 찾기</a>
						&nbsp;&nbsp;
						<a href="<%=request.getContextPath() %>/memberFindPwd.do">비밀번호 찾기</a>
						&nbsp;&nbsp;
						<a href="<%=request.getContextPath() %>/memberJoinReady.do">회원가입</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
