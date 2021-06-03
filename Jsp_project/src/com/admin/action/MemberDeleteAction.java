package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.collections.SynchronizedStack;

import com.admin.model.AdminDAO;
import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;

public class MemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		System.out.println(id);
		AdminDAO dao = AdminDAO.getInstance();
		
		int res = dao.memDelete(id);
		
		ActionForward forward = new ActionForward();
		System.out.println(id);
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("memberManagement.do");
		}else {
			out.println("<script>");
			out.println("alert('삭제 실패했습니다.)");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
