<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="calc_ok.jsp" method="post">

<input type="text" name="su1"/>

<select name="oper">
	<option value="+">덧셈</option>
	<option value="-">뺄셈</option>
	<option value="*">곱셈</option>
	<option value="/">나눗셈</option>
</select>

<input type="text" name="su2"/>

<input type="submit" value=" = "/>

</form>

</body>
</html>