package com.cinema.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.BookDAO;

public class MovieBookingCancelAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String bookingcode = request.getParameter("bookingcode");
		BookDAO bdao = BookDAO.getInstance();
		int res = bdao.bookingDelete(bookingcode);
		
		PrintWriter out = response.getWriter();
		
		out.println(res);
		
		return null;
	}

}
