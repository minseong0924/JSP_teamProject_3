<%@page import="com.cinema.model.ScreenDAO"%>
<%@page import="com.cinema.model.CinemaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String location = request.getParameter("location");
	String title = request.getParameter("title_ko");
			
	ScreenDAO dao = ScreenDAO.getInstance();
	
	String list = dao.ScreenList(location, title);
	System.out.println(list);
	out.print(list);
%>