package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.member.model.MemberDAO;
import com.member.model.MemberDTO;

public class MemberFindPwdOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("name").trim();
		String userbirth = request.getParameter("birth").trim();
		String userphone = request.getParameter("phone").trim();
		String userid = request.getParameter("id").trim();
		
		MemberDTO mdto = new MemberDTO();
		mdto.setId(userid);
		mdto.setName(username);
		mdto.setBirth(userbirth);
		mdto.setPhone(userphone);

		MemberDAO mdao = MemberDAO.getInstance();
		String res = mdao.memberFindPwd(mdto);
		String[] result = res.split(":");
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(result[0].equals("pwd")) {
			request.setAttribute("findPwd", result[1]);
			request.setAttribute("findName", username);
			
			forward.setRedirect(false);
			forward.setPath("memberFindPwdRes.do");
		} else if(result[0].equals("noExist")) {
			out.println("<script>");
			out.println("alert('해당 정보에 일치하는 회원이 없습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
