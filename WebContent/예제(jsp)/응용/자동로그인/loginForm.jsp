<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<%
    String id = null;
	String passwd  = null;
	String auto = null;

	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c: cookies){
			if(c.getName().equals("AuthSid")) auto = c.getValue();
			if(c.getName().equals("AuthId")) id = c.getValue();
			if(c.getName().equals("AuthPw")) passwd = c.getValue();
		}
	}
	if(auto != null && id != null && passwd != null){
		response.sendRedirect("loginPro.jsp");
	}	
%>
<html>
<head><title>�α���</title>
<link href="style.css" rel="stylesheet" type="text/css">

   <script language="javascript">
     <!--
       function begin(){
         document.myform.id.focus();
       }
       function checkIt(){
         if(!document.myform.id.value){
           alert("�̸��� �Է����� �����̽��ϴ�.");
           document.myform.id.focus();
           return false;
         }
         if(!document.myform.passwd.value){
           alert("��й�ȣ�� �Է����� �����̽��ϴ�.");
           document.myform.passwd.focus();
           return false;
         }
         
       }
     -->
   </script>
</head>
<BODY onload="begin()" bgcolor="<%=bodyback_c%>">
<TABLE cellSpacing=1 cellPadding=1 width="260" border=1 align="center" >
<form name="myform" action="loginPro.jsp" method="post" onSubmit="return checkIt()">
<TR height="30"><TD colspan="2" align="middle" bgcolor="<%=title_c%>"><STRONG>ȸ���α���</STRONG></TD></TR>
<TR height="30">
	<TD width="110" bgcolor="<%=title_c%>" align=center>���̵�</TD>
	<TD width="150" bgcolor="<%=value_c%>" align=center><INPUT type="text" name="id" size="15" maxlength="12"></TD>
</TR>
<TR height="30">
	<TD width="110" bgcolor="<%=title_c%>" align=center>��й�ȣ</TD>
	<TD width="150" bgcolor="<%=value_c%>" align=center><INPUT type=password name="passwd"  size="15" maxlength="12"></TD>
</TR>
<TR height="30">
	<td colspan="2" bgcolor="<%=title_c%>" align="center">
		�ڵ� �α��� üũ 
		<input type="checkbox" name="auto" value="1" style="background:<%=title_c%>;" onClick="if(!confirm('�ڵ� �α��� �Ͻðڽ��ϱ�?')){this.checked = false;}">
	</td>
</TR>
<TR height="30">
	<TD colspan="2" align="middle" bgcolor="<%=title_c%>" >
		<INPUT type=submit value="�α���">
		<INPUT type=reset value="�ٽ��Է�">
		<input type="button" value="ȸ������" onclick="javascript:window.location='inputForm.jsp'">
	</TD>
</TR>
</form>
</TABLE>

</BODY>
</HTML>