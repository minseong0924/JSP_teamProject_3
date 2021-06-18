package com.cinema.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;

public class MovieSearch2Action implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String search_name = request.getParameter("search_name").trim();
		
		MovieDAO mdao = MovieDAO.getInstance();
		List<MovieDTO> mlist = mdao.mainMovieSearch(search_name);
		System.out.println(search_name);
		System.out.println(mlist.size());
		
		ActionForward forward = new ActionForward();
		int totalRecord = mdao.getSearchmovieCount(search_name);
		int allPage = (int)Math.ceil(totalRecord / 4.0);
		request.setAttribute("total", totalRecord);
		request.setAttribute("count", allPage);
		request.setAttribute("List", mlist);
		
		forward.setRedirect(false);
		forward.setPath("view/movieChart.jsp");
		
		return forward;
	}
}
