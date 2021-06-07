package com.cinema.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.CinemaDTO;

public class CinemaWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		CinemaDTO dto = new CinemaDTO();
		
		int local_code = Integer.parseInt(request.getParameter("local_code").trim());
		// int cinema_code = Integer.parseInt(request.getParameter("cinema_code").trim());
		String cinema_name = request.getParameter("cinema_name").trim();
		String cinema_intro = request.getParameter("cinema_intro").trim();
		String cinema_address = request.getParameter("cinema_address").trim();
		
		
		
		
		return null;
	}

}
