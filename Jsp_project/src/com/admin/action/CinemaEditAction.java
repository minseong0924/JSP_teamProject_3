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

public class CinemaEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int code = Integer.parseInt(request.getParameter("cinemaCode"));
		
		CinemaDAO cdao = CinemaDAO.getInstance();
		CinemaDTO cdto = cdao.cinemaDetailOpen(code);
		
		LocalDAO ldao = LocalDAO.getInstance();
		List<LocalDTO> llist = ldao.localOpen();

		request.setAttribute("List", cdto);
		request.setAttribute("locallist", llist);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/cinemaWrite.jsp");
		
		return forward;
	}

}
