<%@page import="java.sql.Connection"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="com.util.DBConn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
		
	String userId = request.getParameter("userId");
	
	Connection conn = DBConn.getConnection();
	NaverDAO dao = new NaverDAO(conn);
	
	int result = dao.deleteData(userId);
	
	DBConn.close();
	
	response.sendRedirect("list.jsp");
%>
