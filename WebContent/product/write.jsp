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
<title>Add Product</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/product/oserafim//css/style.css"/>
<script type="text/javascript" src="<%=cp%>/product/oserafim/image.js"></script>

</head>
<body>
<br/>&nbsp;<br/>

<table width="560" border="2" cellspacing="0" cellpadding="0" 
borderColor="#D6D4A6" style="margin: auto;">
<tr height="40"> 
<td style="padding-left:20px;">
<b>Add Product</b>
</td>
</tr>
</table>
<br/>

<form name="myForm" method="post" action="" enctype="multipart/form-data">
  <table width="560" border="0" cellspacing="0" cellpadding="3" style="margin: auto;">
  
  <tr><td colspan="2" height="1"  bgcolor="#DBDBDB" align="center"></td></tr>
  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">Num</td>
      <td width="80%" style="padding-left:10px;"> 
        <input type="text" name="pNum" size="60" maxlength="100" class="boxTF"/>
      </td>
  </tr>	
  <tr><td colspan="2" height="1"  bgcolor="#DBDBDB" align="center"></td></tr>
  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">ProductNum</td>
      <td width="80%" style="padding-left:10px;"> 
        <input type="text" name="productNum" size="60" maxlength="100" class="boxTF"/>
      </td>
  </tr>		
  <tr><td colspan="2" height="3"  bgcolor="#DBDBDB" align="center"></td></tr>
  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">ProductName</td>
      <td width="80%" style="padding-left:10px;"> 
        <input type="text" name="productName" size="60" maxlength="100" class="boxTF"/>
      </td>
  </tr>	
  <tr><td colspan="2" height="3"  bgcolor="#DBDBDB" align="center"></td></tr>
  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">Category</td>
      <td width="80%" style="padding-left:10px;"> 
        <select name="category" class="boxTF" onfocus="none">
        	<option value="none">======</option>
        	<option value="Chair">Chair</option>
        	<option value="Bed">Bed</option>
        	<option value="Light">Light</option>
        	<option value="Desk">Desk</option>
        </select>
      </td>
  </tr>	
   <tr><td colspan="2" height="3"  bgcolor="#DBDBDB" align="center"></td></tr>
  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">Price</td>
      <td width="80%" style="padding-left:10px;"> 
        <input type="text" name="price" size="60" maxlength="100" class="boxTF"/>
      </td>
  </tr>	
   <tr><td colspan="2" height="3"  bgcolor="#DBDBDB" align="center"></td></tr>
  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">Description</td>
      <td width="80%" style="padding-left:10px;"> 
       	<textarea rows="12" cols="63" name="content" class="boxTA"></textarea>
      </td>
  </tr>		
  <tr><td colspan="2" height="1"  bgcolor="#DBDBDB"></td></tr>
  <tr> 
      <td width="20%" height="30" bgcolor="#EEEEEE" style="padding-left:20px;">Img</td>
      <td width="80%" style="padding-left:10px;"> 
       <input type="file" name="upload" size="60" maxlength="100" class="boxTF" onchange="readURL(this);"/>
     	<img id="preview"/>
      </td>
  </tr>		

  <tr><td colspan="2" height="3" bgcolor="#DBDBDB" align="center"></td></tr>

  </table>
  
  <table width="560" border="0" cellspacing="0" cellpadding="3" style="margin: auto;">
     <tr align="center"> 
      <td height="40">
        <input type="button" value=" Add " class="btn2"
			onclick="sendIt()"/>
		<input type="reset" value=" rewrite " class="btn2"
			onclick="document.myForm.productNum.focus();"/>
		<input type="button" value=" cancel " class="btn2"
			onclick="location='<%=cp%>/pdct/list.do';"/>
      </td>
    </tr>
  </table>
</form>

</body>
</html>