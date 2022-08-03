<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>제품관리</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/boardTest/css/style.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/boardTest/css/created.css"/>

<script type="text/javascript">

	function sendIt() {
		
	    f = document.myForm;
		    
	    str = f.productNum.value;
	    str = str.trim();
	    if(!str) {
	        alert("※제품코드 입력");
	        f.productNum.focus();
	        return;
	    }
	    f.productNum.value = str;
	    
	    str = f.productName.value;
	    str = str.trim();
	    if(!str) {
	        alert("※제품명 입력");
	        f.productName.focus();
	        return;
	    }
	    f.productName.value = str;
	    
	    str = f.price.value;
	    str = str.trim();
	    if(!str) {
	        alert("※가격 입력");
	        f.price.focus();
	        return;
	    }
	    f.price.value = str;
	    
	    str = f.content.value;
	    str = str.trim();
	    if(!str) {
	        alert("※설명 입력");
	        f.content.focus();
	        return;
	    }
	    f.content.value = str;
	    
	    str = f.upload.value;
	    if(!str) {
	        alert("※이미지 파일 선택");
	        f.upload.focus();
	        return;
	    }
		
		f.action = "<%=cp%>/pdct/updated_ok.do";
		f.submit();
		
	}

</script>

</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	제품관리
	</div>
	
	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
	
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제품&nbsp;&nbsp;&nbsp;&nbsp;코드</dt>
				<dd>
					<input type="text" name="subject" size="60"
					maxlength="100" class="boxTF" value="${dto.productNum }"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제품명</dt>
				<dd>
					<input type="text" name="name" size="35"
					maxlength="20" class="boxTF" value="${dto.productName }"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>가격</dt>
				<dd>
					<input type="text" name="email" size="35"
					maxlength="50" class="boxTF" value="${dto.price }"/>
				</dd>
			</dl>
		</div>
		
		<div id="bbsCreated_content">
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
					<textarea rows="12" cols="63" name="content" 
					class="boxTA" >${dto.content }</textarea>
				</dd>
			</dl>
		</div>

		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이미지</dt>
				<dd>
				<img src="${imagePath }/${dto.img }" width="180" height="180"/>
				</dd>
			</dl>
		</div>
	
	</div>
	
	<div id="bbsCreated_footer">
	
	<input type="hidden" name="pNum" value="${dto.pNum }"/>
	<input type="hidden" name="pageNum" value="${pageNum }"/>
	<input type="hidden" name="searchKey" value="${searchKey }"/>
	<input type="hidden" name="searchValue" value="${searchValue }"/>

			<input type="button" value=" 수정 " class="btn2" 
			onclick="${updatePath }?pNum=${dto.pNum }&${params }'"/>
			<input type="button" value=" 삭제 " class="btn2" 
			onclick="${deletePath }?pNum=${dto.pNum }&${params }'"/>

			<input type="button" value=" 돌아가기 " class="btn2" 
			onclick="location='<%=cp%>/pdct/list.do?${params }';"/>

	</div>
	</form>
</div>

</body>
</html>