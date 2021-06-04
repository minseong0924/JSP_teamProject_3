package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;

public class MovieEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int code = Integer.parseInt(request.getParameter("movieCode"));

		MovieDAO dao = MovieDAO.getInstance();
		
		MovieDTO dto = dao.movieDetailOpen(code);
		System.out.println(dto.getOpendate());
		request.setAttribute("List", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/movieEdit.jsp");
		
		return forward;
	}

}
