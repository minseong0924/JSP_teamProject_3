package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.BookDAO;
import com.cinema.model.BookDTO;
import com.cinema.model.ReviewDAO;
import com.member.model.MemberDAO;
import com.member.model.MemberDTO;

public class MyPageEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 현재 로그인한 회원의 아이디값 가져오기
		String id = request.getParameter("memid").trim();
		String try_pwd = request.getParameter("try_pwd").trim();
		
		MemberDAO mdao = MemberDAO.getInstance();
		// 아이디가 id인 회원의 개인정보 가져오기
		MemberDTO mdto = mdao.memDetailOpen(id);
		
		request.setAttribute("mlist", mdto);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(try_pwd.equals(mdto.getPwd())) {
			forward.setRedirect(false);
			forward.setPath("view/myPageEdit.jsp");
		}else {
			out.println("<script>");
			out.println("alert('비밀번호가 틀렸습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
