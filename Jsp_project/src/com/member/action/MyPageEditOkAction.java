package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.BookDAO;
import com.cinema.model.BookDTO;
import com.cinema.model.ReviewDAO;
import com.member.model.MemberDAO;

public class MyPageEditOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String userid = request.getParameter("memid").trim();
		String username = request.getParameter("username").trim();
		String userpwd = request.getParameter("userpwd").trim();
		String userphone = request.getParameter("userphone").trim();
		
		MemberDAO mdao = MemberDAO.getInstance();
		int res = mdao.memberEditOk(userid, username, userpwd, userphone);
		
		ReviewDAO rdao = ReviewDAO.getInstance();
		// 아이디가 id인 회원의 전체 리뷰 수를 확인하기
		int review_count = rdao.getReviewCount(userid);
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		request.setAttribute("review_count", review_count);

		BookDAO bdao = BookDAO.getInstance();
		// 아이디가 id인 회원의 전체 예매 수를 확인하기
		int booked_count = bdao.getBookedCount(userid);
		// 아이디가 id인 회원이 가장 좋아하는 극장 확인하기
		String like_cinema = bdao.getLikeCinema(userid);
		// 아이디가 id인 회원이 가장 좋아하는 극장 확인하기
		String like_genre = bdao.getLikeGenre(userid);
		// 아이디가 id인 회원의 전체 예매 목록 가져오기
		List<BookDTO> blist = bdao.BookingSearch(userid);
		
		request.setAttribute("booked_count", booked_count);
		request.setAttribute("like_cinema", like_cinema);
		request.setAttribute("like_genre", like_genre);
		request.setAttribute("blist", blist);
		
		if(res > 0) {
			forward.setRedirect(false);
			forward.setPath("view/myPageMain.jsp");
		} else {
			out.println("<script>");
			out.println("alert('회원정보 수정에 실패했습니다. 고객센터로 문의바랍니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
