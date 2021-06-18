package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ReviewDAO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ReviewIdCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");
		String title_ko =request.getParameter("title_ko");
		
		ReviewDAO dao = ReviewDAO.getInstance();
		int res = dao.ReviewIdCheck(id, title_ko);
		
		System.out.println(res);
		
		PrintWriter out = response.getWriter();
		
		/*JSONObject obj = new JSONObject();
		
		JSONArray ja = JSONArray.fromObject(res);
		
		obj.put("list", ja);*/
		
		out.println(res);
		
		return null;
	}

}
