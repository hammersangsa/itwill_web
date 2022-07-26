<%@page import="com.guest.GuestDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.util.MyPage"%>
<%@page import="com.guest.GuestDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

	Connection conn = DBConn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	
	MyPage myPage = new MyPage();
	
	List<GuestDTO> lists = null;

	//MyPage에서 넘어온 페이지 넘기기
	String pageNum	= request.getParameter("pageNum");
	int currentPage = 1;//처음실행값
	//처음실행을 검사
	if(pageNum!=null){
		currentPage = Integer.parseInt(pageNum);
	}
	
	//전체데이터개수 구하기
	int dataCount = dao.getDataCount();
	
	//하나의 페이지에 보여줄 데이터 개수
	int numPerPage = 3;
	
	//전체페이지 개수
	int totalPage = 0;
    
    if(dataCount != 0){  //페이징 작업
  	  totalPage = 
  	 	 myPage.getPageCount(numPerPage, dataCount);
    }
	
	//삭제 시의 페이지 수가 줄었을 때의 처리방법
	if(currentPage>totalPage){
		currentPage=totalPage;
	}
	//데이터베이스에서 가져올 rownum의 시작과 끝
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	
	lists = dao.getLists(start, end);
 
	//페이징 처리
	String listUrl = "guest.jsp";
	String pageIndexList = 
			myPage.pageIndexList(currentPage, totalPage, listUrl);
	
	DBConn.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>

<link rel="stylesheet" href="<%=cp%>/guest/data/style.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/guest/data/guest.js"></script>

<script type="text/javascript">
    function isDelete(num)  {
    	
		if (confirm("방명록을 삭제하시겠습니까 ?")) {
			location.href="<%=cp%>/guest/delete.jsp?num=" + num;
		}
    }
</script>

</head>
<body>
<br/>&nbsp;<br/>

<table width="560" border="2" cellspacing="0" cellpadding="0" 
borderColor="#D6D4A6" style="margin: auto;">
<tr height="40"> 
<td style="padding-left:20px;">
<b>방 명 록</b>
</td>
</tr>
</table>
<br/>

<form name="myForm" method="post" action="">
  <table width="560" border="0" cellspacing="0" cellpadding="3" style="margin: auto;">


  <tr><td colspan="2" height="3"  bgcolor="#DBDBDB" align="center"></td></tr>

  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">작성자</td>
      <td width="80%" style="padding-left:10px;"> 
        <input type="text" name="name" size="35" maxlength="20" class="boxTF"/>
      </td>
  </tr>

   <tr><td colspan="2" height="1"  bgcolor="#DBDBDB"></td></tr>

  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">E-Mail</td>
      <td width="80%" style="padding-left:10px;"> 
        <input type="text" name="email" size="35" maxlength="50" class="boxTF"/>
	 </td>
  </tr>

   <tr><td colspan="2" height="1"  bgcolor="#DBDBDB"></td></tr>

  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">홈페이지</td>
      <td width="80%" style="padding-left:10px;"> 
        <input type="text" name="homepage" size="35" maxlength="50" class="boxTF" value="http://"/>
	 </td>
  </tr>

   <tr><td colspan="2" height="1"  bgcolor="#DBDBDB"></td></tr>

  <tr> 
      <td width="20%" bgcolor="#EEEEEE" style="padding-left:20px; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
      <td width="80%" valign="top" style="padding-left:10px;"> 
        <textarea name="content" cols="60" rows="7" class="boxTA"></textarea>
      </td>
  </tr>

  <tr><td colspan="2" height="3" bgcolor="#DBDBDB" align="center"></td></tr>

  </table>

  <table width="560" border="0" cellspacing="0" cellpadding="3" style="margin: auto;">
     <tr align="center"> 
      <td height="40">
        <input type="button" value=" 등록하기 " onclick="sendIt()" class="btn2"/>
        <input type="reset"  value=" 다시입력 " onclick="document.myForm.name.focus();" class="btn2"/>
      </td>
    </tr>
  </table>
</form>

<table width="560" border="0" cellspacing="0" cellpadding="3" style="margin: auto;">

<tr><td colspan="2" height="3"  bgcolor="#DBDBDB" align="center"></td></tr>

<%for(GuestDTO dto : lists) { %>
<tr height="30">
	<td align="left" bgcolor="#EEEEEE">
	<strong>No <%=dto.getNum() %>.<%=dto.getName() %>(<%=dto.getEmail() %>)</strong>
	</td>
	<td align="right" bgcolor="#EEEEEE">홈페이지 :
		<a href="<%=dto.getHomepage() %>" target="_blank"><%=dto.getHomepage() %></a> </td>
</tr>
<tr height="30">	
	<td align="left" bgcolor="#EEEEEE">
	작성일 : <%=dto.getCreated() %>(<%=dto.getIpAddr() %>)
	</td>
	<td align="right" bgcolor="#EEEEEE">
	<a href="javascript:isDelete('<%=dto.getNum()%>')">삭제</a>
	</td>
</tr>
   <tr><td colspan="2" height="1"  bgcolor="#DBDBDB"></td></tr>
<tr>
	<td align="left" bgcolor="#ffffff"><%=dto.getContent() %></td>
</tr>
<tr><td><br></td></tr>
<tr><td colspan="2" height="3"  bgcolor="#DBDBDB" align="center"></td></tr>

<%} %>
</table>


<% if(dataCount == 0) { %>
  <table width="560" border="0" cellpadding="0" cellspacing="0" bgcolor="#EEEEEE" style="margin: auto;">
      <tr align="center" height="50"> 
       <td>
         <b>등록된 자료가 없습니다.</b>
       </td>
     </tr>
  </table>
  <table width="560" border="0" cellpadding="0" cellspacing="0" style="margin: auto;">
  <tr><td colspan="2" bgcolor="#DBDBDB" height="3"></td></tr>
  </table>
  
<%}else{%>
  <table width="560" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="margin: auto;">
      <tr align="center" height="30"> 
       <td>
         <%=pageIndexList%>
       </td>
     </tr>
  </table>
<%} %>

</body>
</html>