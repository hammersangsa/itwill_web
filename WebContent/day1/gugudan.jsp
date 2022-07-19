<%@ page contentType="text/html; charset=UTF-8"%>
<%

	String userId = (String)session.getAttribute("userId");//downcast

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt(){
		
		var f=document.myForm;
		if(!f.dan.value){
			alert("단을 입력하세요!");
			f.dan.focus();
			return;
		}
		
		f.action = "gugudan_ok.jsp"
		f.submit();
	}

</script>

</head>
<body>
<%=userId %>가 구구단 한다<br/>
<form action="" method="post" name="myForm">

단:<input type="text" name="dan"/><br/>
<input type="button" value="결과" onclick="sendIt();"/><br/>
<!-- onclick으로 스크립트구현 -->

</form>

</body>
</html>