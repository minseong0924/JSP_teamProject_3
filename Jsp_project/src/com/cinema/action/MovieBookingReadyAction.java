package com.cinema.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.BookDAO;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;
import com.cinema.model.SeatDAO;
import com.cinema.model.SeatDTO;

public class MovieBookingReadyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int screencode = Integer.parseInt(request.getParameter("screencode"));
		
		ScreenDAO sdao = ScreenDAO.getInstance();
		ScreenDTO sdto = sdao.bookingScreenDetailOpen(screencode);
		
		SeatDAO tdao = SeatDAO.getInstance();
		SeatDTO tdto = tdao.seatOpen(sdto.getCinemacode(), sdto.getCincode());
		
		BookDAO bdao = BookDAO.getInstance();
		String bookingSeat = bdao.bookingSeatOpen(screencode);
		String[] bookingSeatarr = bookingSeat.split("/");
		
		request.setAttribute("sdto", sdto);
		request.setAttribute("seat", tdto);
		request.setAttribute("bookseat", bookingSeatarr);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("movieBookingSelect.do");
		
		return forward;
	}

}
