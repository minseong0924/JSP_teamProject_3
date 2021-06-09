package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

public class ScreenUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int screencode = Integer.parseInt(request.getParameter("screencode").trim());
		String start_time = request.getParameter("start_time").trim();
		String end_time = request.getParameter("end_time").trim();
		
		ScreenDAO sdao = ScreenDAO.getInstance();
		ScreenDTO sdto = sdao.screenDetailOpen(screencode);
		
		System.out.println("스크린 수정:"+start_time+"/"+end_time);
		
		String[] stime = start_time.split(":");
		int shour = Integer.parseInt(stime[0]);
		int strat_min = Integer.parseInt(stime[1]);
		strat_min = (shour * 60) + strat_min;
		
		
		String[] etime = end_time.split(":");
		int ehour = Integer.parseInt(etime[0]);
		int end_min = Integer.parseInt(etime[1]);
		end_min = (ehour * 60) + end_min;
		
		System.out.println("스크린 수정 시간:"+strat_min+"/"+end_min); 
		
		sdto.setStart_time(strat_min);
		sdto.setEnd_time(end_min);
		
		int res = sdao.updateScreen(sdto);
		
		PrintWriter out = response.getWriter();

		out.println(res);
		
		return null;
	}

}
