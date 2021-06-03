package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.ScreenDAO;

public class ScreenDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int screencode = Integer.parseInt(request.getParameter("screencode").trim());
		ScreenDAO sdao = ScreenDAO.getInstance();
		int res = sdao.deleteScreen(screencode);
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("movieScreenSetting.do");
		} else {
			out.println("<script>");
			out.println("alert('상영 정보 삭제 실패했습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
