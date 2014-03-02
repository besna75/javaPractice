<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>메인입니다..</title>
<link href="style.css" rel="stylesheet" type="text/css"> <!-- 스타일시트 링크 -->
</head>
<%
/* 회원등급확인(관리자,일반인...등)  */
String id = (String)session.getAttribute("memId");  
LogonDBBean manager = LogonDBBean.getInstance();
LogonDataBean c = manager.getMember(id); // 로그인 되어 있는 사용자 정보 담기
String grade = c.getGrade();
                  //회원등급 구분을 위해 member.setGrade(rs.getString("grade"));를 LogonDBBean에 추가함
                  
 try{
   if(session.getAttribute("memId")==null){// 세션 없을 시
   	
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

	<!-- 로그인 전 : if{session.getAttribute("memId")==null -->
	<table width=500 cellpadding="0" cellspacing="0" align="center"
		border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">&nbsp;</td>

			<form name="inform" method="post" action="loginPro.jsp" onSubmit="return checkIt();">

				<td bgcolor="<%=title_c%>" width="100" align="right">아이디</td>
				<td width="100" bgcolor="<%=value_c%>"><input type="text" name="id" size="15" maxlength="10"></td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">메인입니다.</td>
			<td bgcolor="<%=title_c%>" width="100" align="right">패스워드</td>
			<td width="100" bgcolor="<%=value_c%>"><input type="password" name="passwd" size="15" maxlength="10"></td>
		</tr>
		<tr>
			<td colspan="3" bgcolor="<%=title_c%>" align="center">
				<input type="submit" name="Submit" value="로그인"> 
				<input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'"> 
				<input type="button" value="게시판" onclick="javascript:window.location='/jsp/board/list.jsp'">
			</td>
			</form>
		</tr>
	</table>

<%}else{ /* session.getAttribute("memId")!=null */%>
	<!-- 로그인 후 -->
	<table width=500 cellpadding="0" cellspacing="0" align="center"
		border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">로그인 성공</td>
			<td rowspan="3" bgcolor="<%=value_c%>" align="center"><%=session.getAttribute("memId")%>님이 방문하셨습니다.
				<form method="post" action="logout.jsp">
					<input type="submit" value="로그아웃"> 
					<input type="button" value="회원정보변경" onclick="javascript:window.location='modify.jsp'">
					<input type="button" value="게시판" onclick="javascript:window.location='/jsp/board/list.jsp'">
				</form>
			</td>
		</tr>
		<tr>
		<%
		if (grade.equals("admin")) {%>
			<input type="button" value="가입된 회원 검색" onclick="javascript:window.location='../">
		<%
		}else {		
		%>
		<!-- nothing -->
		<%} %>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">관리자메뉴</td>
		</tr>
	</table>
	<br>
	<%}
 }catch(NullPointerException e){}
 %>
</body>
</html>
