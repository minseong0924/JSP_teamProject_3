<%@page import="com.cinema.model.CinemaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String localname = request.getParameter("local");

	CinemaDAO dao = CinemaDAO.getInstance();
	
	String list = dao.LocalCinemaList(localname);
	
	out.print(list);

%>