<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import ="java.util.regex.Matcher,java.util.regex.Pattern"%>


<%@ include file="/view/color.jsp"%>
<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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
<%
	String pageNum = request.getParameter("pageNum");
	String pageReturn = "";

//	/-검색 관련
//	검색 값이 있을때 처리 하는 부분.
	String skey = request.getParameter("skey");
	String sval = request.getParameter("sval");
	String sqry = "";
	if (pageNum == null)
		pageNum = "1";
	if (skey != null && sval != null){
		pageReturn = "&skey="+skey+"&sval="+sval;
		sqry = " where "+skey+" like '%"+sval+"%' ";
	}else{
		skey = "writer";
		sval = "";
	}
//	검색 관련-/

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number= 0;


	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();

	count = dbPro.getArticleCount(sqry);

//	/-검색 관련
//
	if (!sqry.equals("") && count<startRow){
		currentPage = count / pageSize + ((count%pageSize != 0)?1:0);
		startRow = (currentPage - 1) * pageSize + 1;
		endRow = currentPage * pageSize;
	}
//	검색 관련-/

	if (count > 0) {
		articleList = dbPro.getArticles(startRow, endRow, sqry);
	}

	number=count-(currentPage-1)*pageSize;


%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
<center><b>글목록(전체 글:<%=count%>)</b>
<table width="700"><tr><td align="right" bgcolor="<%=value_c%>"><a href="writeForm.jsp">글쓰기</a></td></tr></table>
<%
	if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr><td align="center">게시판에 저장된 글이 없습니다.</td>
</table>
<%
	} else {
%>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
<tr height="30" bgcolor="<%=value_c%>">
	<td align="center"  width="50"  >번 호</td>
	<td align="center"  width="250" >제   목</td>
	<td align="center"  width="100" >작성자</td>
	<td align="center"  width="150" >작성일</td>
	<td align="center"  width="50"  >조 회</td>
	<td align="center"  width="100" >IP</td>
</tr>
<%
		for (int i = 0 ; i < articleList.size() ; i++) {
			BoardDataBean article = (BoardDataBean)articleList.get(i);
%>
<tr height="30">
	<td align="center"  width="50" > <%=number--%></td>
	<td  width="250" >
<%
			int wid=0;
			if(article.getRe_level()>0){
				wid=5*(article.getRe_level());
%>
		<img src="images/level.gif" width="<%=wid%>" height="16">
		<img src="images/re.gif">
<%
			} else {
%>
		<img src="images/level.gif" width="<%=wid%>" height="16">
<%
			}
			int last = (article.getContent().length()<30)? article.getContent().length() : 30;
%>
		<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>" title="<%=article.getContent().substring(0,last)%>"><%=article.getSubject()%></a>
<%
			if(article.getReadcount()>=20) {
%>
		<img src="images/hot.gif" border="0"  height="16">
<%
			}
%>
	</td>
	<td align="center"  width="100"><%=checkMail(article.getEmail())%><%=article.getWriter()%></a></td>
	<td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
	<td align="center"  width="50"><%=article.getReadcount()%></td>
	<td align="center" width="100" ><%=article.getIp()%></td>
</tr>
<%
		}
%>
</table>
<%
	}
%>
<!-- //--검색염 -->
<script language="JavaScript">
function chkSch(form){
	if(form.sval.value){
		return true;
	}
	alert("검색하라며?");
	form.sval.focus();
	return false;
}
</script>
<table width="700">
<form method="get" action="list.jsp" name="searchForm" onSubmit="return chkSch(this);">
<input type="hidden" name="pageNum" value="<%=pageNum%>"">
<tr>
	<td align="right" bgcolor="<%=value_c%>">
		<select name="skey">
			<OPTION value="writer" <%=(skey.equals("writer"))?"selected":""%>>이름</OPTION>
			<OPTION value="subject" <%=(skey.equals("subject"))?"selected":""%>>제목</OPTION>
			<OPTION value="content" <%=(skey.equals("content"))?"selected":""%>>내용</OPTION>
		</select>
		<input type=text name="sval" value="<%=sval%>">
		<input type=submit value="검색">
		<%=(!sval.equals(""))?"<a href=\"list.jsp\">원래대로</a>":""%>
	</td>
</tr>
</form>
</table>
<!-- 검색염--// -->

<%
	if (count > 0) {
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);

		int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
		int endPage = startPage + pageBlock-1;
		if (endPage > pageCount)
			endPage = pageCount;
		if (startPage > 10) {
%>
<a href="list.jsp?pageNum=<%= startPage - 10 %><%=pageReturn%>">[이전]</a>
<%
		}
		for (int i = startPage ; i <= endPage ; i++) {
%>
	<a href="list.jsp?pageNum=<%= i %><%=pageReturn%>">[<%= i %>]</a>
<%
		}
		if (endPage < pageCount) {
%>
	<a href="list.jsp?pageNum=<%= startPage + 10 %><%=pageReturn%>">[다음]</a>
<%
		}
	}
%>
</center>
</body>
</html>