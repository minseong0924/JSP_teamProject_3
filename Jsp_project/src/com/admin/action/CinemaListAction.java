package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.LocalDAO;
import com.cinema.model.LocalDTO;

public class CinemaListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		LocalDAO ldao = LocalDAO.getInstance();
		
		// 페이지에 해당하는 게시물을 가져오는 메서드 호출
		List<LocalDTO> list = ldao.localOpen();
		
		request.setAttribute("List", list);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);
		forward.setPath("admin/cinemaManagement.jsp");

		return forward;
	}

}
