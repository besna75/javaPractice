<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>
<%!
	public static String checkMail(String mail){
		if(mail != null)
			if(mail.matches("^(?:\\w+\\.?)*\\w+@(?:\\w+\\.)+\\w+$"))
				mail = "<a href=\"mailto:"+mail+"\" title='"+mail+"'>";
			else
				mail = "<a title='메일주소가 이상해염'>";
		else
			mail = "<a title='메일 없어요'>";
		
		return mail;
	}
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean article =  dbPro.getArticle(num);

		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
%>
<body bgcolor="<%=bodyback_c%>">
<center><b>글내용 보기</b>
<br>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0"  bgcolor="<%=bodyback_c%>" align="center">
<tr height="30">
	<td align="center" width="125" bgcolor="<%=value_c%>" nowrap>글제목</td>
	<td align="center" width="375" align="center" colspan="3"><%=article.getSubject()%></td>
</tr>
<tr height="30">
	<td align="center" width="125" bgcolor="<%=value_c%>" nowrap>글번호</td>
	<td align="center" width="125" align="center"><%=article.getNum()%></td>
	<td align="center" width="125" bgcolor="<%=value_c%>" nowrap>조회수</td>
	<td align="center" width="125" align="center"><%=article.getReadcount()%></td>
</tr>
<tr height="30">
	<td align="center" width="125" bgcolor="<%=value_c%>" nowrap>작성자</td>
	<td align="center" width="125" align="center"><%=checkMail(article.getEmail())%><%=article.getWriter()%></a></td>
	<td align="center" width="125" bgcolor="<%=value_c%>" nowrap>작성일</td>
	<td align="center" width="125" align="center"><%= sdf.format(article.getReg_date())%></td>
</tr>
<tr height="30">
	<td align="center" width="125" bgcolor="<%=value_c%>" nowrap>작성자IP</td>
	<td align="left" width="375" colspan="3"><%=article.getIp()%></td>
</tr>
<tr>
	<td align="center" width="125" bgcolor="<%=value_c%>" nowrap>글내용</td>
	<td align="left" width="375" colspan="3"><%=article.getContent().replaceAll("\\n","\n<BR>")%></td>
</tr>
<tr height="30">
	<td colspan="4" bgcolor="<%=value_c%>" align="right" >
		<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="답글쓰기" onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
	</td>
</tr>
</table>
<%
	} catch(Exception e) {}
%>
</form>
</body>
</html>
