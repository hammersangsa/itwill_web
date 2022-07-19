<%@page import="com.calc.Calc"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

/* 	java형
	Calc ob = new Calc();//Calc를 import해서 객체 생성 후 사용
	ob.setSu1(su1);
	ob.setSu2(su2);
	ob.setOper(oper);
	
	String str = ob.result(); */
	
	//액션형
	//useBean
	//property가 *를 사용하여 추적하려면 변수와 name이 같아야한다
	//같으면 추가로 데이터를 안받아도 된다
%>

<jsp:useBean id="ob" class="com.calc.Calc" scope="page"/>
<jsp:setProperty property="*" name="ob"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

결과: <%=ob.result() %><br/>

</body>
</html>