package com.member.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.member.model.MemberDAO;
import com.member.model.MemberDTO;

public class MyPageEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 현재 로그인한 회원의 아이디값 가져오기
		String id = request.getParameter("memid").trim();
		
		MemberDAO mdao = MemberDAO.getInstance();
		// 아이디가 id인 회원의 개인정보 가져오기
		MemberDTO mdto = mdao.memDetailOpen(id);
		
		request.setAttribute("mlist", mdto);
		
		ActionForward forward = new ActionForward();

		forward.setRedirect(false);
		forward.setPath("view/myPageEdit.jsp");

		return forward;
	}

}
