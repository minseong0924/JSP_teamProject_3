package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

public class ScreenInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String[] moviecodeStr = request.getParameter("movie_code").trim().split(":");
		int moviecode = Integer.parseInt(moviecodeStr[0]);
		
		String[] cinemacodeStr = request.getParameter("cinema_code").trim().split(":");
		int cinemacode = Integer.parseInt(cinemacodeStr[0]);
		
		int cincode = Integer.parseInt(request.getParameter("cinema_cin").trim());
		
		String start_time = request.getParameter("start_time").trim();
		String[] time = start_time.split(":");
		int hour = Integer.parseInt(time[0]);
		int strat_min = Integer.parseInt(time[1]);
		strat_min = (hour * 60) + strat_min;
		
		System.out.println("스크린 추가:"+cincode+"/"+start_time);
		
		MovieDAO mdao = MovieDAO.getInstance();
		MovieDTO mdto = mdao.movieDetailOpen(moviecode);
		int end_min = strat_min + mdto.getRunning_time();
		
		ScreenDTO sdto = new ScreenDTO();
		sdto.setMoviecode(moviecode);
		sdto.setCinemacode(cinemacode);
		sdto.setCincode(cincode);
		sdto.setStart_time(strat_min);
		sdto.setEnd_time(end_min);
		
		ScreenDAO sdao = ScreenDAO.getInstance();
		int res = sdao.insertScreen(sdto);
		
		PrintWriter out = response.getWriter();
		
		out.println(res);
		
		return null;
	}

}
