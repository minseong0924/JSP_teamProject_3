package com.member.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.BookDAO;
import com.cinema.model.BookDTO;
import com.cinema.model.ReviewDAO;

public class MyPageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 현재 로그인한 회원의 아이디값 가져오기
		String id = request.getParameter("memid").trim();
		
		ReviewDAO rdao = ReviewDAO.getInstance();
		// 아이디가 id인 회원의 전체 리뷰 수를 확인하기
		int review_count = rdao.getReviewCount(id);
		
		request.setAttribute("review_count", review_count);
		
		BookDAO bdao = BookDAO.getInstance();
		// 아이디가 id인 회원의 전체 예매 수를 확인하기
		int booked_count = bdao.getBookedCount(id);
		// 아이디가 id인 회원이 가장 좋아하는 극장 확인하기
		String like_cinema = bdao.getLikeCinema(id);
		// 아이디가 id인 회원이 가장 좋아하는 극장 확인하기
		String like_genre = bdao.getLikeGenre(id);
		// 아이디가 id인 회원의 전체 예매 목록 가져오기
		List<BookDTO> blist = bdao.BookingSearch(id);
		
		request.setAttribute("booked_count", booked_count);
		request.setAttribute("like_cinema", like_cinema);
		request.setAttribute("like_genre", like_genre);
		request.setAttribute("blist", blist);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("view/myPageMain.jsp");
		
		return forward;
	}

}
