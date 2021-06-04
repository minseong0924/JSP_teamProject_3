package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;

public class MovieDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int moviecode = Integer.parseInt(request.getParameter("movieCode"));
		
		MovieDAO dao = MovieDAO.getInstance();
		
		//영화를 삭제하는 메서드사용
		int res = dao.movieDelete(moviecode);
		
		//삭제한 영화보다 code값이 큰 영화들의 code값 -1해주는 메서드
		dao.movieCodeDown(moviecode);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res > 0) { 
			forward.setRedirect(true);
			forward.setPath("movieList.do");
		}else {
			out.println("<script>");
			out.println("alert('삭제 실패하였습니다.'");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
