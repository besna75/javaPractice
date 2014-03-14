<%@ page  contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<html>
<head><title>메인입니다..</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	try{
		if(session.getAttribute("memId")==null){
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
<script language="javascript">
<!--
function focusIt()
{      
   document.inform.id.focus();
}
 
 function checkIt()
 {
   inputForm=eval("document.inform");
   if(!inputForm.id.value){
     alert("아이디를 입력하세요..");
	 inputForm.id.focus();
	 return false;
   }
   if(!inputForm.passwd.value){
     alert("아이디를 입력하세요..");
	 inputForm.passwd.focus();
	 return false;
   }
 }
//-->
</script>
</head>

<body onLoad="focusIt();" bgcolor="<%=bodyback_c%>">
<table width=500 cellpadding="0" cellspacing="0"  align="center" border="1" >
<form name="inform" method="post" action="loginPro.jsp"  onSubmit="return checkIt();">
<tr>
	<td width="300" bgcolor="<%=bodyback_c%>" height="20">&nbsp;</td>
	<td bgcolor="<%=title_c%>"  width="100" align="right">아이디</td>
	<td width="100" bgcolor="<%=value_c%>"><input type="text" name="id" size="15" maxlength="10"></td>
</tr>
<tr>
	<td rowspan="3" bgcolor="<%=bodyback_c%>" width="300" >메인입니다.</td>
	<td bgcolor="<%=title_c%>"  width="100" align="right">패스워드</td>
	<td width="100" bgcolor="<%=value_c%>"><input type="password" name="passwd" size="15" maxlength="10"></td>
</tr>
<tr>
	<td colspan="2" bgcolor="<%=title_c%>" align="center">
		자동 로그인 체크 <input type="checkbox" name="auto" value="1" style="background:<%=title_c%>;" onClick="if(!confirm('자동 로그인 하시겠습니까?')){this.checked = false;}">
	</td>
</tr>
<tr>
	<td colspan="2" bgcolor="<%=title_c%>" align="center">
		<input type="submit" name="Submit" value="로그인">
		<input type="button"  value="회원가입" onclick="javascript:window.location='inputForm.jsp'">
	</td>
</tr>
</form>
</table>
<%
		}else{
%>
       <table width=500 cellpadding="0" cellspacing="0"  align="center" border="1" >
         <tr>
           <td width="300" bgcolor="<%=bodyback_c%>" height="20">하하하</td>

           <td rowspan="3" bgcolor="<%=value_c%>" align="center">
             <%=session.getAttribute("memId")%>님이 <br>
             방문하셨습니다
             <form  method="post" action="logout.jsp">  
             <input type="submit"  value="로그아웃">
             <input type="button" value="회원정보변경" onclick="javascript:window.location='modify.jsp'">
             </form>
         </td>
        </tr>
       <tr > 
         <td rowspan="2" bgcolor="<%=bodyback_c%>" width="300" >메인입니다.</td>
      </tr>
     </table>
     <br>
 <%
	 	}
	}catch(NullPointerException e){}
%>
 </body>
</html>
