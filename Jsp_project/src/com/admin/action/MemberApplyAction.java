package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.model.AdminDAO;
import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;

public class MemberApplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String id = request.getParameter("id");
		String per = request.getParameter("perchange");
		
		AdminDAO dao = AdminDAO.getInstance();
		
		int res = dao.memApply(id, per);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("memberManagement.do");
		}else {
			out.println("<script>");
			out.println("alert('변경 실패했습니다.)");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
		}
	}


