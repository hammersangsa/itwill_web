<%@page import="java.net.URLDecoder"%>
<%@page import="com.util.MyPage"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	MyPage myPage = new MyPage();
	
	//MyPage에서 넘어온 페이지 넘기기
	String pageNum	= request.getParameter("pageNum");
	int currentPage = 1;//처음실행값
	
	//처음실행을 검사
	if(pageNum!=null){
		currentPage = Integer.parseInt(pageNum);
	}
	//검색--------------------------------------
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	if(searchValue!=null){//검색을 했을 경우
		//GET 방식은 한글 인코딩 해서 보낸다
		if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
	}else{
		searchKey = "subject";
		searchValue = "";		
	}
	
	//검색--------------------------------------

	//전체데이터개수 구하기
	int dataCount = dao.getDataCount(searchKey, searchValue);
	//하나의 페이지에 보여줄 데이터 개수
	int numPerPage = 5;
	//전체페이지 개수
	int totalPage = myPage.getPageCount(numPerPage, dataCount);
	//삭제 시의 페이지 수가 줄었을 때의 처리방법
	if(currentPage>totalPage){
		currentPage=totalPage;
	}
	//데이터베이스에서 가져올 rownum의 시작과 끝
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	
	List<BoardDTO> lists = dao.getLists(start, end, searchKey, searchValue);
	//페이징 처리
	String listUrl = "list.jsp";
	String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);
	
	DBConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 판</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/board/css/style.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/board/css/list.css"/>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.searchForm;
		
		f.action = "<%=cp%>/board/list.jsp";
		f.submit();
	}

</script>

</head>
<body>

<div id="bbsList">

	<div id="bbsList_title">
	게 시 판
	</div>

	<div id="bbsList_header">
		<div id="leftHeader">
			<form action="" method="post" name="searchForm">
				<select name="searchKey" class="selectField">
					<option value="subject">제목</option>
					<option value="name">작성자</option>
					<option value="content">내용</option>
				</select>
				
				<input type="text" name="searchValue" class="textField"/>
				<input type="button" value=" 검 색 " class="btn2" onclick="sendIt();"/>
			</form>		
		</div>
		<div id="rightHeader">
			<input type="button" value=" 글올리기 " class="btn2"
				onclick="javascript:location.href='<%=cp%>/board/created.jsp';"/>
		</div>
	</div>

	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="num">번호</dt>
				<dt class="subject">제목</dt>
				<dt class="name">작성자</dt>
				<dt class="created">작성일</dt>
				<dt class="hitCount">조회수</dt>
			</dl>
		</div>
		<div id="lists">
		<%for(BoardDTO dto : lists){ %>
			<dl>
				<dd class="num"><%=dto.getNum() %></dd>				
				<dd class="subject">
				<a href="<%=cp%>/board/article.jsp?num=<%=dto.getNum() %>&pageNum=<%=currentPage%>">
				<%=dto.getSubject() %>
				</a>
				</dd>			
				<dd class="name"><%=dto.getName() %></dd>				
				<dd class="created"><%=dto.getCreated() %></dd>				
				<dd class="hitCount"><%=dto.getHitCount() %></dd>				
			</dl>
		<%} %>
		</div>
		<div id="footer">
			<p>
				<%=pageIndexList %>
			</p>
		</div>
	</div>
	
</div>


</body>
</html>