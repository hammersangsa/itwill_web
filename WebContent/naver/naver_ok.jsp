<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.naver.NaverDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.naver.NaverDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	Connection conn = DBConn.getConnection();
	NaverDAO dao = new NaverDAO(conn);

	int result =  dao.insertData(dto);
	
	DBConn.close();
	
	if(result!=0){
		response.sendRedirect("list.jsp");
	}
	
%>
입력 오류입니다
<%=dto.getUserId() %>
<%=dto.getUserPwd() %>
<%=dto.getUserName() %>
<%=dto.getYear() %>-<%=dto.getMonth() %>-<%=dto.getDay() %>
<%=dto.getGender() %>
<%=dto.getEmail() %>
<%=dto.getTel1() %>-<%=dto.getTel2() %>