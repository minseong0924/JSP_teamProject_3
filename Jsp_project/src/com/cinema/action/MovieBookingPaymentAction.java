package com.cinema.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

public class MovieBookingPaymentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int screencode = Integer.parseInt(request.getParameter("0"));
		String select_seat = request.getParameter("1");
		int adult = Integer.parseInt(request.getParameter("2"));
		int junior = Integer.parseInt(request.getParameter("3"));
		int price = Integer.parseInt(request.getParameter("4"));
		
		System.out.println("예매요청:"+screencode+"/"+select_seat+"/"+adult+"/"+junior+"/"+price);
		
		ScreenDAO dao = ScreenDAO.getInstance();
		ScreenDTO dto = dao.bookingScreenDetailOpen(screencode);
		
		request.setAttribute("sdto", dto);
		request.setAttribute("select_seat", select_seat);
		request.setAttribute("adult", adult);
		request.setAttribute("junior", junior);
		request.setAttribute("price", price);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("movieBookingPaymentOk.do");
		
		return forward;
	}

}
