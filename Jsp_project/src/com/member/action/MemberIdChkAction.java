package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.member.model.MemberDAO;

public class MemberIdChkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("paramId").trim();
		MemberDAO dao = MemberDAO.getInstance();
		int res = dao.memJoinIdCheck(id);
		PrintWriter out = response.getWriter();
		
		out.println(res);
		
		return null;
	}

}
