<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/view/color.jsp"%>
<%@ page import="ch11.logon.*"%>
<html>
<head>
<title>메인입니다..</title>
<link href="style.css" rel="stylesheet" type="text/css">
<!-- 스타일시트 링크 -->
</head>
<%
	String id = (String) session.getAttribute("memId"); //loginPro.jsp의 setAttribute("memId") 받기
	LogonDBBean manager = LogonDBBean.getInstance(); //DAO의 메소드 사용을 위한 인스턴스 생성
	LogonDataBean c = manager.getMember(id); // 로그인 되어 있는 사용자 정보 담기	

	try {		
		if (session.getAttribute("memId") == null) { /* 세션 체크 결과 로그인 전이면 : 1)로그인 전 화면 수행  2) 쿠키 체크 */
						/* 쿠키 체크 */
						Cookie[] coo = request.getCookies(); //배열로 쿠키 받기
						String passwd = null, auto = null;
						id = null;// 지역변수는 사용되기 전에 초기화 해주어야 함
						for (Cookie d : coo) {
							if (d.getName().equals("cooId"))
								id = d.getValue();
							if (d.getName().equals("cooPw"))
								passwd = d.getValue();
							if (d.getName().equals("cooAuto"))
								auto = d.getValue();
						}
						if (id != null && passwd != null && auto != null) { //쿠키값을 확인 →쿠키값이 있으면 loginPro.jsp로 정보 전송
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

	<!-- 로그인 전 : if{session.getAttribute("memId")==null -->
	<table width=500 cellpadding="0" cellspacing="0" align="center"	border="1">
	
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">&nbsp;</td>
			<form name="inform" method="post" action="loginPro.jsp"	onSubmit="return checkIt();">
				<td bgcolor="<%=title_c%>" width="100" align="right">아이디</td>
				<td width="100" bgcolor="<%=value_c%>">
				<input type="text" name="id" size="15" maxlength="10"></td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">메인입니다.</td>
			<td bgcolor="<%=title_c%>" width="100" align="right">패스워드</td>
			<td width="100" bgcolor="<%=value_c%>">
			<input type="password" name="passwd" size="15" maxlength="10"></td>
		</tr>
		<tr>
			<td colspan="3" bgcolor="<%=title_c%>" align="center">
				<input type="checkbox" name="auto" value="1">자동로그인 
				<input type="submit" name="Submit" value="로그인"> 
				<input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'"> 
				<input type="button" value="게시판" onclick="javascript:window.location='/jsp/board/list.jsp'">
			</td>
		</tr>
		</form>
	</table>
	
	<%}else	if (session.getAttribute("memId") != null) { /* 세션체크 결과 로그인 상태이면 : 1)회원의 등급을 가져오기 2)로그인 후 화면 표시 */		
		String grade = c.getGrade(); // 회원등급확인 %>
	<!-- 로그인 후 -->
	<table width=500 cellpadding="0" cellspacing="0" align="center"
		border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">로그인 성공</td>
			<td rowspan="3" bgcolor="<%=value_c%>" align="center"><%=session.getAttribute("memId")%> <%=grade%>님이 방문하셨습니다.
				<form method="post" action="logout.jsp">
					<input type="submit" value="로그아웃"> 
					<input type="button" value="회원정보변경" onclick="javascript:window.location='modify.jsp'">
					<input type="button" value="게시판" onclick="javascript:window.location='../board/list.jsp'">
					<input Type="button" value="나의 작성글" onclick="javascript:window.location='../board/mylist.jsp'">
					<%
						if(grade.equals("admin")){/* if (grade.equals("admin"))*/
					%>
							<input type="button" value="가입 회원 검색" onclick="javascript:window.location='member.jsp/">
					<%
						}else {		
					%>
						<!-- nothing -->
					<%
						}
					%>
				</form></td>
		</tr>
		<tr>			
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">관리자메뉴</td>
		</tr>
	</table>
	<br>
	<%}

 }catch(NullPointerException e){}
 %>
</body>
</html>
