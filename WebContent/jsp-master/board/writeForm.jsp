<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
	int num = 0, ref = 1, re_step = 0, re_level = 0; // 변수 초기화
	try {
		if (request.getParameter("num") != null) { // 파라미터 값이 있을 시
			num = Integer.parseInt(request.getParameter("num")); // 글의 고유번호
			ref = Integer.parseInt(request.getParameter("ref")); // 글의 그룹 이름(번호)
			re_step = Integer.parseInt(request.getParameter("re_step")); // 같은 그룹 내에서의 작성입력순서값
			re_level = Integer.parseInt(request
					.getParameter("re_level")); // 글의 종류 : 0은 새 글, 1은  답변, 2는 답변의 답변
		}
		
	String writer = (String)session.getAttribute("memId");
%>

<body bgcolor="<%=bodyback_c%>">
	<center>
		<b>글쓰기</b> <br>
		<!-- post to writePro.jsp -->
		<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
			<!-- 글 작성시에 생성되는 변수 값 : 글의 고유번호, 그룹이름, 작성입력순서값, 글의 종류 -->
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="ref" value="<%=ref%>">
			<input type="hidden" name="re_step" value="<%=re_step%>">
			<input type="hidden" name="re_level" value="<%=re_level%>">

			<table width="400" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c%>" align="center">
				<tr>
					<td align="right" colspan="2" bgcolor="<%=value_c%>">
						<a href="list.jsp"> 글목록</a>
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">이 름</td>
					<td width="330">
						<input type="text" size="10" maxlength="10" value="<%=writer%>" disabled>
						<input type="hidden" name="writer" value="<%=writer%>"></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">제 목</td>
					<td width="330">
					<%
						// num(글의 고유번호) 파라미터 값이 없을 시 : 새 글일때
						if (request.getParameter("num") == null) {
					%>
						<input type="text" size="40" maxlength="50" name="subject">
					</td>
					<%
						// num(글의 고유번호) 파라미터 값이 있을 시 : 답글일때 -> 글 제목에 [답변]이 자동 기입된다.
						} else {
					%>
						<input type="text" size="40" maxlength="50" name="subject" value="[답변]">
					<%
						}
					%>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">Email</td>
					<td width="330"><input type="text" size="40" maxlength="30" name="email"></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">내 용</td>
					<td width="330">
						<textarea name="content" rows="13" cols="40"></textarea>
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
					<td width="330"><input type="password" size="8" maxlength="12" name="passwd"></td>
				</tr>
				<tr>
					<td colspan=2 bgcolor="<%=value_c%>" align="center">
						<input type="submit" value="글쓰기">
						<input type="reset" value="다시작성">
						<input type="button" value="목록보기" OnClick="window.location='list.jsp'"><!-- 목록보기 클릭 시 list.jsp -->
					</td>
				</tr>
			</table>
			<%
				} catch (Exception e) {}
			%>
		</form>
</body>
</html>
