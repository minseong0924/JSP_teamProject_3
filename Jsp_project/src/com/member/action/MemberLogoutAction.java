package com.member.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;

public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();

		forward.setRedirect(false);
		forward.setPath("main.do");
		
		session.invalidate(); //세션 초기화

		return forward;
	}

}
