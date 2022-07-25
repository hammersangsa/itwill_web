<%@page import="com.guest.GuestDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.guest.GuestDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>
	
<%	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	Connection conn = DBConn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	
	dao.deleteData(num);
	
	DBConn.close();
	
	response.sendRedirect(cp + "/guest/guest.jsp");
%>

