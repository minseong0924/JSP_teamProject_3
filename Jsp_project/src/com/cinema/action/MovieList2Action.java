package com.cinema.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class MovieList2Action implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		MovieDAO dao = MovieDAO.getInstance();
		List<MovieDTO> list = dao.movieList();

		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		
		JSONArray ja = JSONArray.fromObject(list);
		obj.put("list", ja);
		
		out.println(obj);
		
		return null;
	
	}

}
