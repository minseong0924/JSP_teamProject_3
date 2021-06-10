package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.LocalDAO;
import com.cinema.model.LocalDTO;

public class LocalSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		LocalDAO dao = LocalDAO.getInstance();
		List<LocalDTO> llist = dao.localOpen();
		
		request.setAttribute("locallist", llist);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("cinema_2.do");
		
		return forward;
	}

}
