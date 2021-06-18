package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ReviewDAO;

public class ReviewUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		int point = Integer.parseInt(request.getParameter("point"));
		String text = request.getParameter("review-text");
		int moviecode =Integer.parseInt(request.getParameter("moviecode"));
		
		ReviewDAO dao = ReviewDAO.getInstance();
		int res = dao.UpdateReview(no, point, text);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("movieContent.do?moviecode="+moviecode);
		}else {
			out.println("<script>");
			out.println("alert('수정 실패하였습니다')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
