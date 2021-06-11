<%@page import="com.cinema.model.LocalDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LocalDAO dao = LocalDAO.getInstance();

	String list = dao.LocalList();
	System.out.print(list);
	
	out.print(list);
%>