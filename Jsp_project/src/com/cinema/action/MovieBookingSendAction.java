package com.cinema.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.BookDAO;
import com.cinema.model.BookDTO;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

public class MovieBookingSendAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int screencode = Integer.parseInt(request.getParameter("screencode"));
		String select_seat = request.getParameter("select_seat");
		String userid = request.getParameter("userid");
		String credit = request.getParameter("credit");
		
		ScreenDAO sdao = ScreenDAO.getInstance();
		ScreenDTO sdto = sdao.bookingScreenDetailOpen(screencode);
		
		//시작 시간 문자열 셋팅
		int str_hour = 0;
		
		if(sdto.getStart_time() >= 1440) {
			str_hour = (sdto.getStart_time()-1440) / 60;
		} else {
			str_hour = sdto.getStart_time() / 60;
		}
		
		int str_min = sdto.getStart_time() % 60;
		
		if(str_min > 59) {
			str_hour++;
			str_min = str_min-60;
		}
		
		String str_time = "";
		
		if(str_hour < 10) {
			str_time = "0"+str_hour;
		} else {
			str_time = ""+str_hour;
		}
		
		if(str_min < 10) {
			str_time += ":0" + str_min;
		} else {
			str_time += ":" + str_min;
		}
		
		// 종료 시간 문자열 셋팅
		int end_hour = 0;
		
		if(sdto.getEnd_time() >= 1440) {
			end_hour = (sdto.getEnd_time()-1440) / 60;
		} else {
			end_hour = sdto.getEnd_time() / 60;
		}
		
		int end_min = sdto.getEnd_time() % 60;
		
		if(end_min > 59) {
			end_hour++;
			end_min = end_min-60;
		}
		
		String end_time = "";
		
		if(end_hour < 10) {
			end_time = "0"+end_hour;
		} else {
			end_time = ""+end_hour;
		}
		
		if(end_min < 10) {
			end_time += ":0" + end_min;
		} else {
			end_time += ":" + end_min;
		}
		
		BookDTO bdto = new BookDTO();
		
		bdto.setId(userid);
		bdto.setLocalcode(sdto.getLocalcode());
		bdto.setCinemaname(sdto.getCinemaname());
		bdto.setTitle_ko(sdto.getMoviename());
		bdto.setScreencode(screencode);
		bdto.setCincode(sdto.getCincode());
		bdto.setStart_date(sdto.getStart_date());
		bdto.setEnd_date(sdto.getEnd_date());
		bdto.setStart_time(str_time);
		bdto.setEnd_time(end_time);
		bdto.setSeat_no(select_seat);
		bdto.setCredit(credit);
		
		BookDAO bdao = BookDAO.getInstance();
		int res = bdao.bookingInsert(bdto);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("movieBookingComplete.do");
		}else {
			out.println("<script>");
			out.println("alert('예매 실패하였습니다.'");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
