<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="vo" class="com.calc.NaverVO" scope="page"/>
<jsp:setProperty property="*" name="vo"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">

body{
    background-color: #f5f6f7;
}

</style>

</head>
<body>

아이디: <%=vo.getUserId() %><br/>
패스워드: <%=vo.getUserPwd() %><br/>
이름: <%=vo.getUserName() %><br/>
생년월일: <%=vo.getYear()%>-<%=vo.getYear()%>-<%=vo.getYear()%><br/>
성별: <%=vo.getGender() %><br/>
이메일: <%=vo.getEmail()%><br/>
휴대전화: <%=vo.getTel1()%><%=vo.getTel2()%><br/>


</body>
</html>