package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.CinemaDAO;
import com.cinema.model.CinemaDTO;

public class CinemaEditOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int local_code = Integer.parseInt(request.getParameter("local_code").trim());
		int cinemacode = Integer.parseInt(request.getParameter("cinemacode").trim());
		String cinema_name = request.getParameter("cinema_name").trim();
		String cinema_intro = request.getParameter("cinema_intro").trim();
		String cinema_address = request.getParameter("cinema_address").trim();
		String[] cin_check = request.getParameterValues("cin_check");
		int one_cin = 0, two_cin = 0, three_cin = 0,
				four_cin = 0, five_cin = 0, six_cin = 0;
		
		for(int i=0; i<cin_check.length; i++) {
			if(cin_check[i].equals("1")) {
				one_cin = 1;
			}else if(cin_check[i].equals("2")) {
				two_cin = 1;
			}else if(cin_check[i].equals("3")) {
				three_cin = 1;
			}else if(cin_check[i].equals("4")) {
				four_cin = 1;
			}else if(cin_check[i].equals("5")) {
				five_cin = 1;
			}else if(cin_check[i].equals("6")) {
				six_cin = 1;
			}
		}
		CinemaDTO dto = new CinemaDTO();
		
		dto.setLocalcode(local_code);
		dto.setCinemacode(cinemacode);
		dto.setCinemaname(cinema_name);
		dto.setIntro(cinema_intro);
		dto.setAddress(cinema_address);
		dto.setOne_cin(one_cin);
		dto.setTwo_cin(two_cin);
		dto.setThree_cin(three_cin);
		dto.setFour_cin(four_cin);
		dto.setFive_cin(five_cin);
		dto.setSix_cin(six_cin);
		
		CinemaDAO dao = CinemaDAO.getInstance();
		int res = dao.cinemaEditOk(dto);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("cinemaList.do");
		}else {
			out.println("<script>");
			out.println("alert('수정 실패하였습니다.'");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
