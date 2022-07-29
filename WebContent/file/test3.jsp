<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	//저장 위치 설정
	//String root = request.getRealPath("/");
	String root = pageContext.getServletContext().getRealPath("/");
	String path = root + "pds" + File.separator + "saveData";
	
	//폴더 생성
	File f = new File(path);
	if(!f.exists()){
		f.mkdirs();
	}
	
	String encType = "UTF-8";
	int maxFileSize = 10*1024*1024;//10mb
	
	try{
		
		//파일 전송
		MultipartRequest mr =
			new MultipartRequest(request,path,maxFileSize,encType,
					new DefaultFileRenamePolicy());
		
		//DB에 저장할 데이터 추출
		out.print("이름: " + mr.getParameter("subject") + "<br/>");
		out.print("서버에 저장된 파일명: " +
			mr.getFilesystemName("upload") + "<br/>");
		out.print("업로드한 파일명: " +
			mr.getOriginalFileName("upload") + "<br/>");
		out.print("파일 타입: " + mr.getContentType("upload") + "<br/>");
		
		File f1 = mr.getFile("upload");
		out.print("파일길이: " + f1.length()+ "<br/>");
		
	}catch(Exception e){
		System.out.print(e.toString());
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>




</body>
</html>