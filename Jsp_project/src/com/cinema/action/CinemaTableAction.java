package com.cinema.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDTO;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class CinemaTableAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String cinemaname = request.getParameter("cinemaname");
		String today = request.getParameter("today");
		System.out.println("today>>> " + today);
		ScreenDAO dao = ScreenDAO.getInstance();
		List<ScreenDTO> list = dao.ScreenList(cinemaname, today);

		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		
		JSONArray ja = JSONArray.fromObject(list);
		obj.put("list", ja);
		
		out.println(obj);
		
		return null;
	}

}
