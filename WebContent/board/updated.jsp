<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum	= request.getParameter("pageNum");
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	BoardDTO dto = dao.getReadData(num);
	
	DBConn.close();
	
	if(dto==null) {
		response.sendRedirect("list.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 판</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/board/css/style.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/board/css/created.css"/>

<script type="text/javascript" src="<%=cp%>/board/js/util.js"></script>
<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
		str = f.subject.value;
		str = str.trim();
		if(!str) {
			alert("\n제목을 입력하세요...");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		str = f.name.value;
		str = str.trim();
		if(!str) {
			alert("\n이름을 입력하세요...");
			f.name.focus();
			return;
		}
		
		/* if(!isValidKorean(str)){
			alert("\n이름을 다시 입력하세요...");
			f.name.focus();
			return;
		} */
	
		f.name.value = str;
		
		if(f.email.value){
			if(!isValidEmail(f.email.value)) {
				alert("\n이메일이 올바르지않습니다...");
				f.email.focus();
				return;
			}
		
		}
		
		str = f.content.value;
		str = str.trim();
		if(!str) {
			alert("\n내용을 입력하세요...");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		str = f.pwd.value;
		str = str.trim();
		if(!str) {
			alert("\n패스워드를 입력하세요...");
			f.pwd.focus();
			return;
		}
		f.pwd.value = str;
		
		f.action = "<%=cp%>/board/updated_ok.jsp";
		f.submit();
		
	}

</script>

</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	게 시 판
	</div>
	
	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
	
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
				<dd>
					<input type="text" name="subject" size="60"
					maxlength="100" class="boxTF" value="<%=dto.getSubject()%>"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd>
					<input type="text" name="name" size="35"
					maxlength="20" class="boxTF" value="<%=dto.getName()%>"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>E-Mail</dt>
				<dd>
					<input type="text" name="email" size="35"
					maxlength="50" class="boxTF" 
					value="<%=dto.getEmail()==null?"":dto.getEmail()%>"/>
				</dd>
			</dl>
		</div>
		
		<div id="bbsCreated_content">
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
					<textarea rows="12" cols="63" name="content" class="boxTA"><%=dto.getContent() %></textarea>
				</dd>
			</dl>
		</div>
	
		<div class="bbsCreated_noLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
					<input type="password" name="pwd" size="35" value="<%=dto.getPwd()%>"
					maxlength="7" class="boxTF"/>&nbsp;(게시물 수정 및 삭제 시 필요!!!)
				</dd>
			</dl>
		</div>
	
	</div>
	
	<div id="bbsCreated_footer">
		<input type="hidden" name="num" value="<%=dto.getNum()%>"/>
		<input type="hidden" name="pageNum" value="<%=pageNum%>"/>
		<input type="button" value=" 수정하기 " class="btn2"
			onclick="sendIt();"/>
		<input type="button" value=" 수정취소 " class="btn2"
			onclick="javascript:location.href='<%=cp%>/board/list.jsp?pageNum=<%=pageNum%>';"/>
	</div>
	</form>

</div>

</body>
</html>