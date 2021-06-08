package com.member.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;

public class TimeTableAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		MovieDAO dao = MovieDAO.getInstance();
		List<MovieDTO> list = dao.movieOpen();
		
		request.setAttribute("List", list);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("view/movieTimeTable.jsp");
		
		return forward;
	}

}
