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

<!--웹/앱 구별
<script type="text/javascript">
	//var userAgent = navigator.userAgent;
	//alert(userAgent);
	
	var smartPhones = [
		'iphone','android','ipod','windows ce','blackberry','nokia','webos',
		'opera mini','sonyericsson','opera mobi'
	];
	
	for(var i in smartPhones){
		
		if(navigator.userAgent.toLowerCase().match(new RegExp(smartPhones[i]))){
			alert('스마트 폰이네...?');
			document.location = 'http://m.naver.com';
		}
	}	
</script>
-->

</head>
<body>

<h1>메인 페이지</h1>

1. <a href="<%=cp%>/score/list.jsp">성적처리 게시판(JSP)</a><br/>
2. <a href="<%=cp%>/board/list.jsp">게시판(JSP)</a><br/>
3. <a href="<%=cp%>/guest/guest.jsp">방명록(JSP)</a><br/>


</body>
</html>