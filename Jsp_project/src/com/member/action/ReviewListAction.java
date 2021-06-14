package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ReviewDAO;
import com.cinema.model.ReviewDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String title_ko = request.getParameter("title_ko");
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		List<ReviewDTO> list = dao.ReviewList(title_ko);
		
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		
		JSONArray ja = JSONArray.fromObject(list);
		obj.put("list", ja);
		
		out.println(obj);
		
		return null;
	}

}
