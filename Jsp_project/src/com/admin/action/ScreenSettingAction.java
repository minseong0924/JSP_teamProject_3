package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.CinemaDAO;
import com.cinema.model.CinemaDTO;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

public class ScreenSettingAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 페이징 작업
		int rowsize = 5;
		int block = 5;
		int totalRecord = 0;
		int allPage = 0;
		int page = 0;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page = 1;
		}
		
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		int startBlock = (((page - 1) / block) * block) + 1;
		int endBlock = (((page - 1) / block) * block) + block;
		
		MovieDAO mdao = MovieDAO.getInstance();
		List<MovieDTO> mlist = mdao.movieOpen();
		
		request.setAttribute("movielist", mlist);
		
		CinemaDAO cdao = CinemaDAO.getInstance();
		List<CinemaDTO> clist = cdao.cinemaOpen();
		
		request.setAttribute("cinemalist", clist);
		
		ScreenDAO sdao = ScreenDAO.getInstance();
		totalRecord = sdao.getListCount();
		
		allPage = (int) Math.ceil(totalRecord / (double)rowsize);
		
		if (endBlock > allPage) {
			endBlock = allPage;
		}
		
		List<ScreenDTO> slist = sdao.screenOpen(page, rowsize);
		
		request.setAttribute("screenlist", slist);
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/movieScreenSetting.jsp");
		
		return forward;
	}

}
