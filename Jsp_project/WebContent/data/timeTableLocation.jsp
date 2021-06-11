<%@page import="com.cinema.model.ScreenDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String location = request.getParameter("location");
	String title = request.getParameter("title_ko");
			
	String today = request.getParameter("today");
	
	ScreenDAO dao = ScreenDAO.getInstance();
	String list = dao.ScreenList(location, title, today);

	System.out.println(list);
	out.print(list);
%>