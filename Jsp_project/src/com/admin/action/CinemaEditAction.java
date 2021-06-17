package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.CinemaDAO;
import com.cinema.model.CinemaDTO;
import com.cinema.model.LocalDAO;
import com.cinema.model.LocalDTO;
import com.cinema.model.SeatDAO;
import com.cinema.model.SeatDTO;

public class CinemaEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int code = Integer.parseInt(request.getParameter("cinemaCode"));
		
		CinemaDAO cdao = CinemaDAO.getInstance();
		CinemaDTO cdto = cdao.cinemaDetailOpen(code);
		
		LocalDAO ldao = LocalDAO.getInstance();
		List<LocalDTO> llist = ldao.localOpen();
		
		SeatDAO sdao = SeatDAO.getInstance();
		int seat_no1 = sdao.seatDetailOpen(code, 1);
		int seat_no2 = sdao.seatDetailOpen(code, 2);
		int seat_no3 = sdao.seatDetailOpen(code, 3);
		int seat_no4 = sdao.seatDetailOpen(code, 4);
		int seat_no5 = sdao.seatDetailOpen(code, 5);
		int seat_no6 = sdao.seatDetailOpen(code, 6);

		request.setAttribute("List", cdto);
		request.setAttribute("locallist", llist);
		request.setAttribute("seat_no1", seat_no1);
		request.setAttribute("seat_no2", seat_no2);
		request.setAttribute("seat_no3", seat_no3);
		request.setAttribute("seat_no4", seat_no4);
		request.setAttribute("seat_no5", seat_no5);
		request.setAttribute("seat_no6", seat_no6);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/cinemaEdit.jsp");
		
		return forward;
	}

}
