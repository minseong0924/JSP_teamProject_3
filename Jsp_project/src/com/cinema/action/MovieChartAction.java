package com.cinema.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;

public class MovieChartAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		MovieDAO dao = MovieDAO.getInstance();
		
		// 현재 상영중인 영화 리스트를 가져오는 메서드
		List<MovieDTO> list = dao.NowmovieList();
		
		MovieDAO mdao = MovieDAO.getInstance();
		
		// DB상의 전체 게시물의 수를 확인하는 메서드
		int totalRecord = mdao.getNowmovieCount();
		int allPage = (int)Math.ceil(totalRecord / 4.0);
		request.setAttribute("total", totalRecord);
		request.setAttribute("count", allPage);
		request.setAttribute("List", list);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("view/movieChart.jsp");
		
		return forward;
	}

}
