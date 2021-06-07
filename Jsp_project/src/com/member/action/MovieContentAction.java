package com.member.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDTO;
import com.member.model.MemberDAO;

public class MovieContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int moviecode = Integer.parseInt(request.getParameter("moviecode"));
		
		MemberDAO dao = MemberDAO.getInstance();
		MovieDTO dto = dao.MovieContent(moviecode);
		
		request.setAttribute("list", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("view/movieContent.jsp");
		
		return forward;
	}

}
