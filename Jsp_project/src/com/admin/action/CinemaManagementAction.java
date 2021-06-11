package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.LocalDAO;
import com.cinema.model.LocalDTO;

public class CinemaManagementAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		LocalDAO ldao = LocalDAO.getInstance();
		List<LocalDTO> llist = ldao.localOpen();
		
		request.setAttribute("locallist", llist);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/cinemaManagementSearch.jsp");
		
		return forward;
	}

}
