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
		String search_name = request.getParameter("search_name");
		
		
		// ����¡ �۾�
		int rowsize = 5;      // �� �������� ������ �Խù��� ��
		int block = 5;        // �Ʒ��� ������ �������� �ִ� �� - ��) [1][2][3] / [4][5][6]
		int totalRecord = 0;  // DB ���� �Խù� ��ü ��
		int allPage = 0;      // ��ü ������ ��
		
		int page = 0;         // ���� ������ ����
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page = 1;   // ó������ "��ü �Խù�" a �±׸� Ŭ���� ���
		}
		
		
		// �ش� ���������� ���� ��ȣ
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// �ش� ���������� ������ ��ȣ
		int endNo = (page * rowsize);
		
		// �ش� �������� ���� ��
		int startBlock = (((page - 1) / block) * block) + 1;
		
		// �ش� �������� ������ ��
		int endBlock = (((page - 1) / block) * block) + block;
		
		AdminDAO dao = AdminDAO.getInstance();
		
		// DB���� ��ü �Խù��� ���� Ȯ���ϴ� �޼���
		totalRecord = dao.getListCount();
		
		// ��ü �Խù��� ���� �� �������� ������ �Խù��� ���� ������ �־�� ��.
		// �� ������ ��ġ�� ��ü ������ ���� ������ ��.
		// ��ü ������ ���� ���� �� �ʸ����� ������ ������ ������ ���� �ϳ� �÷��־�� ��.
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		
		System.out.println("page >>> " + Math.ceil(totalRecord / (double)rowsize));
		
		if(endBlock > allPage) {
			endBlock = allPage;
		}
		
		List<MemberDTO> searchList = dao.searchMember(search_field, search_name);
		
		// ���ݱ��� ����¡ ó�� �� �۾��ߴ� ��� ������ Ű�� ��������.
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

		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/memManagement.jsp");
		
		return forward;
	}

}
