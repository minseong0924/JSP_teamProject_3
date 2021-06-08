package com.cinema.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.member.model.MemberDAO;
import com.member.model.MemberDTO;

public class MemberJoinOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("username").trim();
		String userid = request.getParameter("userid").trim();
		String userpwd = request.getParameter("userpwd").trim();
		String userbirth = request.getParameter("userbirth").trim();
		String userphone = request.getParameter("userphone").trim();
		
		MemberDTO mdto = new MemberDTO();
		mdto.setName(username);
		mdto.setId(userid);
		mdto.setPwd(userpwd);
		mdto.setBirth(userbirth);
		mdto.setPhone(userphone);

		MemberDAO mdao = MemberDAO.getInstance();
		int res = mdao.insertMember(mdto);
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		request.setAttribute("username", username);
		
		if(res > 0) {
			forward.setRedirect(false);
			forward.setPath("view/memJoinComplete.jsp");
		} else {
			out.println("<script>");
			out.println("alert('회원가입에 실패했습니다. 고객센터로 문의바랍니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
