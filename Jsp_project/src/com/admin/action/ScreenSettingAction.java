package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.CinemaDAO;
import com.cinema.model.CinemaDTO;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;

public class ScreenSettingAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
		MovieDAO mdao = MovieDAO.getInstance();
		List<MovieDTO> mlist = mdao.movieOpen();
		
		request.setAttribute("movielist", mlist);
		
		CinemaDAO cdao = CinemaDAO.getInstance();
		List<CinemaDTO> clist = cdao.cinemaOpen();
		
		request.setAttribute("cinemalist", clist);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/movie_screen_setting.jsp");
		
		return forward;
	}

}
