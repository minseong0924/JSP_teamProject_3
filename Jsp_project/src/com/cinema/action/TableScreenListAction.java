package com.cinema.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TableScreenListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String title_ko = request.getParameter("title_ko");

		ScreenDAO dao = ScreenDAO.getInstance();
		List<ScreenDTO> list = dao.TableScreenList(title_ko);
		
		request.setAttribute("list", list);
		
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		
		JSONArray ja = JSONArray.fromObject(list);
		obj.put("slist", ja);
		
		out.println(obj);
		return null;
	}

}
