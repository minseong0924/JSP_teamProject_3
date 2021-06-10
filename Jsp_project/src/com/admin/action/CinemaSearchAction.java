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

public class CinemaSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int local_code = Integer.parseInt(request.getParameter("local_code"));
		
		System.out.println(local_code);
		
		CinemaDAO cdao = CinemaDAO.getInstance();
		List<CinemaDTO> clist = cdao.cinemaSearch(local_code);
		
		request.setAttribute("local_code", local_code);
		request.setAttribute("List", clist);
		
		LocalDAO ldao = LocalDAO.getInstance();
		List<LocalDTO> llist = ldao.localOpen();
		
		request.setAttribute("locallist", llist);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/cinemaManagementSearch.jsp");
		
		return forward;
	}

}
