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

public class CinemaListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		CinemaDAO cdao = CinemaDAO.getInstance();
		// 지점리스트를 localcode로 정렬하고 첫번째 localcode를 가져오기
		int localcode = cdao.firstLocalCode();
		List<CinemaDTO> clist = cdao.cinemaSearch(localcode);
		
		LocalDAO ldao = LocalDAO.getInstance();
		// 첫번째 지점을 우선으로 지역을 정렬하여 가져오기
		List<LocalDTO> list = ldao.firstlocalOpen(localcode);
		
		request.setAttribute("list", clist);
		request.setAttribute("List", list);

		ActionForward forward = new ActionForward();

		forward.setRedirect(false);
		forward.setPath("admin/cinemaManagement.jsp");

		return forward;
	}

}
