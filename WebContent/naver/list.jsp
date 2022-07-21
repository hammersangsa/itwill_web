<%@page import="java.sql.Connection"%>
<%@page import="com.naver.NaverDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.util.DBConn"%>
<%@page import="com.naver.NaverDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	//Connection conn = DBConn.getConnection();

	NaverDAO dao = new NaverDAO(DBConn.getConnection());
	
	List<NaverDTO> lists = dao.getLists();
	
	DBConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

body{
    background-color: #f5f6f7;
}

table {
	border-spacing:10px;font-size: 11pt;font-family: 돋움; 
}

</style>

</head>
<body>

<br/><br/>

<table width="700" cellpadding="0" cellspacing="3" align="center"
bgcolor="#f5f6f7">
<tr height="50">
	<td bgcolor="#f5f6f7" style="padding-left: 10px;">
	<b>회원정보 리스트 화면</b>
	</td>
</tr>
</table>
<br/>

<table width="650" cellpadding="0" cellspacing="3" align="center">
<tr height="35">
	<td align="right">
	<input type="button" class="btn" value="가입하기 "
	onclick="location='<%=cp%>/naver/naver.jsp';"/>
	</td>
</tr>
</table>

<table>
<tr height="30">
	<td align="center" bgcolor="#e6e6e6" width="80">아이디</td>
	<td align="center" bgcolor="#e6e6e6" width="80">비밀번호</td>
	<td align="center" bgcolor="#e6e6e6" width="60">이름</td>
	<td align="center" bgcolor="#e6e6e6" width="60">생년월일</td>
	<td align="center" bgcolor="#e6e6e6" width="60">성별</td>
	<td align="center" bgcolor="#e6e6e6" width="60">이메일</td>
	<td align="center" bgcolor="#e6e6e6" width="200">전화번호</td>
	<td align="center" bgcolor="#e6e6e6" width="130">수정</td>
</tr>	

<%for(NaverDTO dto: lists) { %>
<tr height="30">
	<td align="center" bgcolor="#f5f6f7"><%=dto.getUserId() %></td>
	<td align="center" bgcolor="#f5f6f7"><%=dto.getUserPwd() %></td>
	<td align="center" bgcolor="#f5f6f7"><%=dto.getUserName() %></td>
	<td align="center" bgcolor="#f5f6f7"><%=dto.getYear() %>-<%=dto.getMonth() %>-<%=dto.getDay() %></td>
	<td align="center" bgcolor="#f5f6f7"><%=dto.getGender() %></td>
	<td align="center" bgcolor="#f5f6f7"><%=dto.getEmail() %></td>
	<td align="center" bgcolor="#f5f6f7"><%=dto.getTel1() %>-<%=dto.getTel2() %></td>
	<td align="center" bgcolor="#f5f6f7">
	<a href="<%=cp%>/naver/update.jsp?userId=<%=dto.getUserId() %>">수정</a>
	<a href="<%=cp%>/naver/delete_ok.jsp?userId=<%=dto.getUserId() %>">삭제</a>

	</td>
</tr>
<%} %>
</table>
</body>
</html>