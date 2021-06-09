package com.cinema.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;
import com.cinema.model.ReviewDAO;
import com.cinema.model.ReviewDTO;

public class MovieContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int moviecode = Integer.parseInt(request.getParameter("moviecode"));
		
		MovieDAO dao = MovieDAO.getInstance();
		ReviewDAO rdao = ReviewDAO.getInstance();
		//moviecode가 ?인 영화정보를 가져오는 메서드
		MovieDTO dto = dao.MovieContent(moviecode);
		List<ReviewDTO> list = rdao.ReviewList(moviecode);
		
		request.setAttribute("List", dto);
		request.setAttribute("reviewList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("view/movieContent.jsp");
		
		return forward;
	}

}