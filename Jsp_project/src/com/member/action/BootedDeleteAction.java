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

public class BootedDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String bookingcode = request.getParameter("bookingcode").trim();
		
		BookDAO bdao = BookDAO.getInstance();
		String id = bdao.getId(bookingcode);
		
		// 예약을 삭제하는 메서드 사용
		int res = bdao.bookingDelete(bookingcode);
		// 아이디가 id인 회원의 전체 예매 목록 가져오기
		List<BookDTO> blist = bdao.BookingSearch(id);
		
		request.setAttribute("blist", blist);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("view/myPageBooked.jsp");
		
		return forward;
	}

}
