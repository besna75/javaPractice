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
<head><title>로그인</title>
<link href="style.css" rel="stylesheet" type="text/css">

   <script language="javascript">
     <!--
       function begin(){
         document.myform.id.focus();
       }
       function checkIt(){
         if(!document.myform.id.value){
           alert("이름을 입력하지 않으셨습니다.");
           document.myform.id.focus();
           return false;
         }
         if(!document.myform.passwd.value){
           alert("비밀번호를 입력하지 않으셨습니다.");
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
<TR height="30"><TD colspan="2" align="middle" bgcolor="<%=title_c%>"><STRONG>회원로그인</STRONG></TD></TR>
<TR height="30">
	<TD width="110" bgcolor="<%=title_c%>" align=center>아이디</TD>
	<TD width="150" bgcolor="<%=value_c%>" align=center><INPUT type="text" name="id" size="15" maxlength="12"></TD>
</TR>
<TR height="30">
	<TD width="110" bgcolor="<%=title_c%>" align=center>비밀번호</TD>
	<TD width="150" bgcolor="<%=value_c%>" align=center><INPUT type=password name="passwd"  size="15" maxlength="12"></TD>
</TR>
<TR height="30">
	<td colspan="2" bgcolor="<%=title_c%>" align="center">
		자동 로그인 체크 
		<input type="checkbox" name="auto" value="1" style="background:<%=title_c%>;" onClick="if(!confirm('자동 로그인 하시겠습니까?')){this.checked = false;}">
	</td>
</TR>
<TR height="30">
	<TD colspan="2" align="middle" bgcolor="<%=title_c%>" >
		<INPUT type=submit value="로그인">
		<INPUT type=reset value="다시입력">
		<input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'">
	</TD>
</TR>
</form>
</TABLE>

</BODY>
</HTML>