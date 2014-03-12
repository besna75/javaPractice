<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>

<%
	/* 비밀번호 확인을 위한 num와 pageNum 값 받기 */
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	/* 관리자 확인  - 관리자일 경우 content.jsp로 정보 보내기*/
	String id = (String)session.getAttribute("memId");	
	if(id.equals("admin")){
		response.sendRedirect("content.jsp?num="+num+"&pageNum="+pageNum);
	}	
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script language="JavaScript">
<!--
	function deleteSave() {
		if (document.delForm.passwd.value == '') {
			alert("비밀번호를 입력하십시요.");
			document.delForm.passwd.focus();
			return false;
		}
	}
// -->
</script>
</head>

<body bgcolor="<%=bodyback_c%>">
	<center>
		<b>글삭제</b> <br>
		<form method="POST" name="delForm"
			action="pwchPro.jsp?pageNum=<%=pageNum%>"
			onsubmit="return deleteSave()">
			<table border="1" align="center" cellspacing="0" cellpadding="0"
				width="360">
				<tr height="30">
					<td align=center bgcolor="<%=value_c%>"><b>비밀번호를 입력해 주세요.</b></td>
				</tr>
				<tr height="30">
					<td align=center>비밀번호 : <input type="password" name="passwd"
						size="8" maxlength="12"> <input type="hidden" name="num"
						value="<%=num%>"></td>
				</tr>
				<tr height="30">
					<td align=center bgcolor="<%=value_c%>"><input type="submit"
						value="글읽기"> <input type="button" value="글목록"
						onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
					</td>
				</tr>
			</table>
		</form>
</body>
</html>
