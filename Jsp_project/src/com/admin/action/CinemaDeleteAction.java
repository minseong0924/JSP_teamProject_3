package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.CinemaDAO;

public class CinemaDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int cinemacode = Integer.parseInt(request.getParameter("cinemaCode"));
		
		CinemaDAO dao = CinemaDAO.getInstance();
		
		// 지점을 삭제하는 메서드 사용
		int res = dao.cinemaDelete(cinemacode);
		
		// 삭제한 지점보다 code값이 큰 지점들의 code값 -1 해주는 메서드
		dao.cinemaCodeDown(cinemacode);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res > 0) { 
			forward.setRedirect(true);
			forward.setPath("cinemaList.do");
		}else {
			out.println("<script>");
			out.println("alert('삭제 실패하였습니다.'");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
