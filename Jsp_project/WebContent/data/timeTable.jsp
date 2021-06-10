<%@page import="com.cinema.model.MovieDTO"%>
<%@page import="com.cinema.model.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int moviecode = Integer.parseInt(request.getParameter("param"));
	MovieDAO dao = MovieDAO.getInstance();
	String list = dao.AMovieContent(moviecode);
	
	out.println(list);

%>