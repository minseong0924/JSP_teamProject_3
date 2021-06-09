package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.member.model.MemberDAO;

public class MemberPhoneChkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String phone = request.getParameter("paramPh").trim();
		System.out.println("Action:"+phone);
		MemberDAO dao = MemberDAO.getInstance();
		int res = dao.memPhoneCheck(phone);
		System.out.println(res);
		PrintWriter out = response.getWriter();
		
		out.println(res);
		
		return null;
	}

}
