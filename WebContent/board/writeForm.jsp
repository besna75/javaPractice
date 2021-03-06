<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="ch11.logon.*"%>
<%@ page import="board.*"%>
<%@ include file="/view/color.jsp"%>

<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
	int num = 0, ref = 1, re_step = 0, re_level = 0; //변수 초기화
	try {
		if (request.getParameter("num") != null) {//글번호가 있을 경우 (글번호!=null)
			num = Integer.parseInt(request.getParameter("num")); //글번호
			ref = Integer.parseInt(request.getParameter("ref")); //글그룹 번호
			re_step = Integer.parseInt(request.getParameter("re_step")); //답글 달린 순서값
			re_level = Integer.parseInt(request.getParameter("re_level")); //작성글 종류 - 새글 0, 답변 1, 답변의 답변 2
		}
		
		/* 로그인 및 회원등급 체크 */   		
		String id = (String)session.getAttribute("memId"); //session이므로 별도의 requset 없이 사용 
	 	LogonDBBean manager = LogonDBBean.getInstance(); //DAO의 메소드 사용을 위한 인스턴스 생성
	 	LogonDataBean c = manager.getMember(id); // 로그인 되어 있는 사용자 정보 담기  		
	 	String grade =""; // 지역 변수는 초기화 해야된다.
	 	String writer =""; // 작성자
	 	String email =""; // 작성자 이메일
	 	
		boolean logged = false; 
		if (session.getAttribute("memId") != null) {
			logged = true;
			grade = c.getGrade();	//지역변수
			writer = c.getName();
			email = c.getEmail();
		}
	
%>

<body bgcolor="<%=bodyback_c%>">
<center>
<b>글쓰기</b> <br>
<!-- post send to writePro.jsp -->
<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
	<!-- 글 작성 시 생성되는 변수 : 글 고유번호, 글그룹번호, 답글순서값, 글종류 -->
	<input type="hidden" name="num" value="<%=num%>"> 
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="re_step" value="<%=re_step%>"> 
	<input type="hidden" name="re_level" value="<%=re_level%>">

	<table width="400" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c%>" align="center">
		<tr>
			<td align="right" colspan="2" bgcolor="<%=value_c%>">
				<a href="list.jsp"> 글목록</a></td>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">이 름</td>
			<td width="330"><input type="text" size="10" maxlength="10" name="writer" value="<%=writer%>" disabled>
				<input type="hidden" name="writer" value="<%=writer%>"> <!-- 작성자명 숨김처리로 정보보내기 -->
			</td> 
			<!-- 작성자명 가져오기, disabled로 이름변경막기 -->
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">제 목</td>
			<td width="330">
				<%
					if (request.getParameter("num") == null) { // 글번호 없음 = 새글일 때
				%> 		<input type="text" size="40" maxlength="50" name="subject">
			</td>
				<%
					} else { // 새글이 아닐 때 = 답글일때 [답변] 모양 달기
				%>
						<input type="text" size="40" maxlength="50" name="subject" value="[답변]">
			<%
				}
			%>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">Email</td>
			<td width="330"><input type="text" size="40" maxlength="30"	name="email" value="<%=email%>">
			<input type="hidden" name="writer" value="<%=email%>">
			</td>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">내 용</td>
			<td width="330"><textarea name="content" rows="13" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
			<td width="330"><input type="password" size="8" maxlength="12" name="passwd"></td>
		</tr>
		<tr>
			<td colspan=2 bgcolor="<%=value_c%>" align="center">
				<input type="submit" value="글쓰기"> 
				<input type="reset"	value="다시작성"> 
				<input type="button" value="목록보기" OnClick="window.location='list.jsp'"></td>
		</tr>
	</table>
	<%
		} catch (Exception e) {
		}
	%>
</form>
</body>
</html>
