package com.admin.action;

import java.io.IOException;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.model.AdminDAO;
import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.member.model.MemberDTO;

public class MemberSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String search_field = request.getParameter("search_field");
		String search_name = request.getParameter("search_name").trim();
		
		// 페이징 작업
		int rowsize = 5;      // 한 페이지당 보여질 게시물의 수
		int block = 5;        // 아래에 보여질 페이지의 최대 수 - 예) [1][2][3] / [4][5][6]
		int totalRecord = 0;  // DB 상의 게시물 전체 수
		int allPage = 0;      // 전체 페이지 수
		
		int page = 0;         // 현재 페이지 변수
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page = 1;   // 처음으로 "전체 게시물" a 태그를 클릭한 경우
		}
		
		
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 마지막 번호
		int endNo = (page * rowsize);
		
		// 해당 페이지의 시작 블럭
		int startBlock = (((page - 1) / block) * block) + 1;
		
		// 해당 페이지의 마지막 블럭
		int endBlock = (((page - 1) / block) * block) + block;
		
		AdminDAO dao = AdminDAO.getInstance();
		
		// DB상의 전체 게시물의 수를 확인하는 메서드
		totalRecord = dao.getListCount();
		
		// 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 주어야 함.
		// 이 과정을 거치면 전체 페이지 수가 나오게 됨.
		// 전체 페이지 수가 나올 때 너머지가 있으면 무조건 페이지 수를 하나 올려주어야 함.
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		
		System.out.println("page >>> " + Math.ceil(totalRecord / (double)rowsize));
		
		if(endBlock > allPage) {
			endBlock = allPage;
		}
		
		// 페이지에 해당하는 게시물을 가져오는 메서드 호출
		List<MemberDTO> searchList = dao.searchMember(search_field, search_name);
		
		// 지금까지 페이징 처리 시 작업했던 모든 값들을 키로 저장하자.
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("List", searchList);
		if(searchList == null) {
			System.out.println("null");
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/memManagement.jsp");
		
		return forward;
	}

}
