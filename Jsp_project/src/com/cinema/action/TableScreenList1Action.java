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

public class TableScreenList1Action implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String title_ko2 = request.getParameter("title_ko2");
		
		ScreenDAO dao = ScreenDAO.getInstance();
		System.out.println(title_ko2);
		List<ScreenDTO> list = dao.TableScreenList1(title_ko2);
				
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		JSONArray ja = JSONArray.fromObject(list);
		obj.put("slist", ja);
		
		out.println(obj);
		return null;
	
	}

}
