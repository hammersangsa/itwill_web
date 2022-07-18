<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  
MIME [Multipurpose Internet Mail Extensions]의 종류
메세지의 내용이 어떤 형식인지 알려주기위해 정의한 인터넷 표준

text/plain : 일반 텍스트문서
text/html : HTML 문서 
text/css  :CSS 문서
text/xml : XML 문서
image/jpeg,image/png : JPEG파일, PNG파일 
video/mpeg,audio/mp3 : MPEG 비디오파일, MP3 음악파일
application/zip : zip 압축파일
-->

<form action="hap_ok.jsp" method="post">

수1: <input type="text" name="su1"/><br/>
수2: <input type="text" name="su2"/><br/>
이름: <input type="text" name="name"/><br/>
<input type="submit" value="결과"/><br/>
<!-- 스크립트 사용시 버튼 사용 -->
<!-- submit: 액션의 주소로 넘어가서 데이터를 보낸다 -->

</form>

<a href="hap_ok.jsp?su1=100&su2=200&name=수지">GET방식</a>
<!-- 띄어쓰기 사용금지 -->

</body>
</html>