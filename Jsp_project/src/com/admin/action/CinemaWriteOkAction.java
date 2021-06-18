package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.CinemaDAO;
import com.cinema.model.CinemaDTO;
import com.cinema.model.SeatDAO;
import com.cinema.model.SeatDTO;

public class CinemaWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int local_code = Integer.parseInt(request.getParameter("local_code").trim());
		// int cinema_code = Integer.parseInt(request.getParameter("cinema_code").trim());
		String cinema_name = request.getParameter("cinema_name").trim();
		String cinema_intro = request.getParameter("cinema_intro").trim();
		String cinema_address = request.getParameter("cinema_address").trim();
		String[] cin_check = request.getParameterValues("cin_check");
		int one_cin = 0, two_cin = 0, three_cin = 0,
				four_cin = 0, five_cin = 0, six_cin = 0;
		int seat_no1 = 0, seat_no2 = 0, seat_no3 = 0,
				seat_no4 = 0, seat_no5 = 0, seat_no6 = 0;
		
		for(int i=0; i<cin_check.length; i++) {
			if(cin_check[i].equals("1")) {
				one_cin = 1;
				seat_no1 = Integer.parseInt(request.getParameter("seat_no1").trim());
			}else if(cin_check[i].equals("2")) {
				two_cin = 1;
				seat_no2 = Integer.parseInt(request.getParameter("seat_no2").trim());
			}else if(cin_check[i].equals("3")) {
				three_cin = 1;
				seat_no3 = Integer.parseInt(request.getParameter("seat_no3").trim());
			}else if(cin_check[i].equals("4")) {
				four_cin = 1;
				seat_no4 = Integer.parseInt(request.getParameter("seat_no4").trim());
			}else if(cin_check[i].equals("5")) {
				five_cin = 1;
				seat_no5 = Integer.parseInt(request.getParameter("seat_no5").trim());
			}else if(cin_check[i].equals("6")) {
				six_cin = 1;
				seat_no6 = Integer.parseInt(request.getParameter("seat_no6").trim());
			}
		}
		
		CinemaDTO dto = new CinemaDTO();
		
		dto.setLocalcode(local_code);
		dto.setCinemaname(cinema_name);
		dto.setIntro(cinema_intro);
		dto.setAddress(cinema_address);
		dto.setOne_cin(one_cin);
		dto.setTwo_cin(two_cin);
		dto.setThree_cin(three_cin);
		dto.setFour_cin(four_cin);
		dto.setFive_cin(five_cin);
		dto.setSix_cin(six_cin);
		
		CinemaDAO cdao = CinemaDAO.getInstance();
		int res = cdao.cinemaWriteOk(dto);
		
		int cinemacode = cdao.cinemaGetCode(cinema_name);
		
		SeatDAO sdao = SeatDAO.getInstance();
		int res1 = sdao.seatWrite(seat_no1, cinemacode, 1);
		int res2 = sdao.seatWrite(seat_no2, cinemacode, 2);
		int res3 = sdao.seatWrite(seat_no3, cinemacode, 3);
		int res4 = sdao.seatWrite(seat_no4, cinemacode, 4);
		int res5 = sdao.seatWrite(seat_no5, cinemacode, 5);
		int res6 = sdao.seatWrite(seat_no6, cinemacode, 6);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res>0 && res1>0 && res2>0 && res3>0 && res4>0 && res5>0 && res6>0) {
			forward.setRedirect(true);
			forward.setPath("cinemaList.do");
		}else {
			out.println("<script>");
			out.println("alert('등록 실패하였습니다.'");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
