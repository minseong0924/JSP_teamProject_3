package com.cinema.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

public class MovieBookingReadyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int screencode = Integer.parseInt(request.getParameter("screencode"));
		
		ActionForward forward = new ActionForward();
		
		ScreenDAO sdao = ScreenDAO.getInstance();
		ScreenDTO sdto = sdao.bookingScreenDetailOpen(screencode);
		
		request.setAttribute("sdto", sdto);
		
		forward.setRedirect(false);
		forward.setPath("movieBookingSelect.do");
		
		return forward;
	}

}
