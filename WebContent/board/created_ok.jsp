<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.board.BoardDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%

	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	int maxNum = dao.getMaxNum();
	
	dto.setNum(maxNum + 1);//num코딩
	dto.setIpAddr(request.getRemoteAddr());//ipAddr코딩
	
	dao.insertData(dto);
	
	DBConn.close();
	
	response.sendRedirect(cp + "/board/list.jsp");

%>