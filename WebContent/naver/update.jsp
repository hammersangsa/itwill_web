<%@page import="com.naver.NaverDTO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.naver.NaverDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String userId = request.getParameter("userId");
	
	Connection conn = DBConn.getConnection();
	NaverDAO dao = new NaverDAO(conn);
	
	NaverDTO dto = dao.getReadData(userId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 수정</title>

<style type="text/css">

body {
	font-size: 9pt;
}

td {
	font-size: 9pt;
}

.txtField {
	font-size: 9pt;
	border: 1px solid;
}

.btn {
	font-size: 9pt;
	background: #e6e6e6;
}

</style>

<script type="text/javascript">
	function sendIt() {
		var f = document.myForm;

		f.action = "<%=cp%>/naver/update_ok.jsp";
		f.submit();
	}
</script>

</head>
<body>

<table width="500" cellpadding="0" cellspacing="3" align="center"
bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ffffff" style="padding-left: 10px">
	<b>회원정보 수정화면</b>
	</td>
</tr>	
</table>
<br/>

<form action="" method="post" name="myForm">

<table width="500" cellpadding="0" cellspacing="0" align="center">

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">아이디</td>
	<td td style="padding-left: 5px;">
	<%=dto.getUserId() %>
	</td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">비밀번호</td>
	<td style="padding-left: 5px;">
	<input type="text" name="userPwd" value="<%=dto.getUserPwd() %>" size="20" 
	maxlength="10" class="txtField"/>
	</td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이름</td>
	<td td style="padding-left: 5px;">
	<%=dto.getUserName() %>
	</td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">생년월일</td>
	<td style="padding-left: 5px;">
	<input type="text" name="year" value="<%=dto.getYear() %>" size="12" 
	maxlength="4" class="txtField"/>
	-
	<input type="text" name="month" value="<%=dto.getMonth() %>" size="12" 
	maxlength="4" class="txtField"/>
	-
	<input type="text" name="day" value="<%=dto.getDay() %>" size="12" 
	maxlength="4" class="txtField"/>
	</td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">성별</td>
	<td td style="padding-left: 5px;">
	<%=dto.getGender() %>
	</td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이메일</td>
	<td><%=dto.getEmail() %></td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">전화번호</td>
	<td>
	<input type="text" name="tel1" value="<%=dto.getTel1() %>" size="16" 
	maxlength="10" class="txtField"/>
	-
	<input type="text" name="tel2" value="<%=dto.getTel2() %>" size="16" 
	maxlength="8" class="txtField"/>
	</td>
</tr>

<tr height="35">
	<td align="center" colspan="2">
	
	<input type="hidden" name="userId" value="<%=dto.getUserId()%>"/>
	
	<input type="button" value="수정완료" 
	onclick="sendIt();"/>
	<input type="button" value="수정취소"
	onclick="javascript:location.href='<%=cp%>/naver/list.jsp';"/>
	</td>
</tr>	

</table>
</form>

</body>
</html>