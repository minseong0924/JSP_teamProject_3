package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.member.model.MemberDAO;
import com.member.model.MemberSession;

public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id").trim();
		String pwd = request.getParameter("pwd").trim();
		String loginValue = request.getParameter("loginValue").trim();
		
		MemberDAO mdao = MemberDAO.getInstance();
		int res = mdao.memberLogin(id, pwd);
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		
		if(res > 0) {
			if(loginValue == "###") {
				forward.setRedirect(false);
				forward.setPath("main.do");
			} else {
				forward.setRedirect(false);
				forward.setPath("movieBookingReady.do?screencode="+loginValue);
			}
			MemberSession ms = new MemberSession();
			ms = mdao.getMember(id, pwd);
			session.setAttribute("memSession", ms);
		} else {
			out.println("<script>");
			out.println("alert('로그인에 실패했습니다. 고객센터로 문의바랍니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
