<!-- 
	로그인 후 글쓰기 기능 추가하기
-->
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="team5.member.*"%>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>메인입니다..</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%	
	String id = (String)session.getAttribute("memId");
	LogonDBBean manager = LogonDBBean.getInstance();

	try {
		if (session.getAttribute("memId") == null) { // 세션이 없을 시
			
			String cooId = "";
			String cooPasswd = "";
		    
			try{
				Cookie[] cookies = request.getCookies(); // 요청에서 쿠키를 가져온다.
				
				if(cookies!=null){ // ID,PASSWD 쿠키가 있을 때
					for(int i=0; i<cookies.length; i++){                        
						if(cookies[i].getName().equals("cooId")){  //cooId를 받아온뒤 id에 저장.
							cooId=cookies[i].getValue();
						}else if(cookies[i].getName().equals("cooPasswd")){
							cooPasswd=cookies[i].getValue();
						}
					}
				}
			}catch(Exception e){}
%>
<script language="javascript">
<!--
	function focusIt() {
		document.inform.id.focus();
	}

	function checkIt() {
		inputForm = eval("document.inform");
		if (!inputForm.id.value) {
			alert("아이디를 입력하세요..");
			inputForm.id.focus();
			return false;
		}
		if (!inputForm.passwd.value) {
			alert("아이디를 입력하세요..");
			inputForm.passwd.focus();
			return false;
		}
	}
//-->
</script>
</head>

<body onLoad="focusIt();" bgcolor="<%=bodyback_c%>">
	<table width=500 cellpadding="0" cellspacing="0" align="center" border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">&nbsp;</td>

			<form name="inform" method="post" action="loginPro.jsp" onSubmit="return checkIt();">

				<td bgcolor="<%=title_c%>" width="100" align="right">아이디</td>
				<td width="100" bgcolor="<%=value_c%>"><input type="text" name="id" size="15" maxlength="10" value="<%=cooId%>"></td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">
				<!-- 메인입니다. : 로그인 전 -->
				<input type="button" value="게시판" onclick="javascript:window.location='../board/list.jsp'">
			</td>
			<td bgcolor="<%=title_c%>" width="100" align="right">패스워드</td>
			<td width="100" bgcolor="<%=value_c%>"><input type="password" name="passwd" size="15" maxlength="10" value="<%=cooPasswd%>"></td>
		</tr>
		<tr>
			<td colspan="3" bgcolor="<%=title_c%>" align="center">
				<input type="submit" name="Submit" value="로그인">
				<input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'">
			</td>
			</form>
		</tr>
	</table>
	<%
		} else {	// session.getAttribute("memId") != null : 로그인 후
		
		//관리자 여부 체크		
		boolean isAdmin = manager.isAdmin(id);
	%>
	<table width=500 cellpadding="0" cellspacing="0" align="center"border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">하하하</td>

			<td rowspan="3" bgcolor="<%=value_c%>" align="center">
				<%=session.getAttribute("memId")%>님이<br>방문하셨습니다.
				<form method="post" action="logout.jsp">
					<input type="submit" value="로그아웃">
					<input type="button" value="회원정보변경" onclick="javascript:window.location='modify.jsp'">
				</form>
			</td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">
				<!-- 메인입니다. : 로그인 후 -->
				<input type="button" value="게시판" onclick="javascript:window.location='../board/list.jsp'">
				<%
				if (isAdmin) {
				%>
					<input type="button" value="가입된 회원 검색" onclick="javascript:window.location='../board/readMemberAll.jsp'">
				<%
				} else {
				%>
					<!-- 공백 -->
				<% } %>
			</td>
		</tr>
	</table>
	<br>
	<%
		}
		} catch (NullPointerException e) {
		}
	%>
</body>
</html>
