package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.BookDAO;
import com.member.model.MemberDAO;

public class MemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String userid = request.getParameter("memid").trim();
		
		MemberDAO mdao = MemberDAO.getInstance();
		int res = mdao.memberDelete(userid);
		
		BookDAO bdao = BookDAO.getInstance();
		int res1 = bdao.bookedDelete(userid);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			forward.setRedirect(false);
			forward.setPath("memberLogout.do");
		} else {
			out.println("<script>");
			out.println("alert('회원탈퇴에 실패했습니다. 고객센터로 문의바랍니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
