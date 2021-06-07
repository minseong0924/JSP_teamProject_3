package com.member.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;
import com.member.model.MemberDAO;

public class MainListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		MemberDAO dao = MemberDAO.getInstance();
		
		List<MovieDTO> list = dao.movieList();
		
		request.setAttribute("List", list);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("main.jsp");
		
		return forward;
	}

}
