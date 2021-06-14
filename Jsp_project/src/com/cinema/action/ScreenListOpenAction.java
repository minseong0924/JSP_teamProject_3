package com.cinema.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ScreenDAO;
import com.cinema.model.ScreenDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ScreenListOpenAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String value = request.getParameter("value");
		String flag = request.getParameter("flag");
		
		System.out.println("sOpenAction:"+flag+"/"+value);
		
		ScreenDAO sdao = ScreenDAO.getInstance();
		List<ScreenDTO> slist = sdao.bookingScreenOpen(flag,value);

		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		
		JSONArray ja = JSONArray.fromObject(slist);
		obj.put("slist", ja);
		
		out.println(obj);
		
		return null;
	}

}
