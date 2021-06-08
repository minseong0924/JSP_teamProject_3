package com.member.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ReviewDAO;
import com.member.model.MemberDAO;

public class ReviewWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String cont = request.getParameter("review-text");
		int moviecode = Integer.parseInt(request.getParameter("moviecode"));
		String title_ko = request.getParameter("title_ko");
		String id = request.getParameter("id");
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		int res = dao.reviewWriteOk(moviecode, title_ko, cont, id);
		
		
		return null;
	}

}
