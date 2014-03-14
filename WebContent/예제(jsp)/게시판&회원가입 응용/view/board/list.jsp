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
				mail = "<a title='�����ּҰ� �̻��ؿ�'>";
		else
			mail = "<a title='���� �����'>";
		return mail;
	}
%>
<%
	String pageNum = request.getParameter("pageNum");
	String pageReturn = "";

//	/-�˻� ����
//	�˻� ���� ������ ó�� �ϴ� �κ�.
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
//	�˻� ����-/

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number= 0;


	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();

	count = dbPro.getArticleCount(sqry);

//	/-�˻� ����
//
	if (!sqry.equals("") && count<startRow){
		currentPage = count / pageSize + ((count%pageSize != 0)?1:0);
		startRow = (currentPage - 1) * pageSize + 1;
		endRow = currentPage * pageSize;
	}
//	�˻� ����-/

	if (count > 0) {
		articleList = dbPro.getArticles(startRow, endRow, sqry);
	}

	number=count-(currentPage-1)*pageSize;


%>
<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
<center><b>�۸��(��ü ��:<%=count%>)</b>
<table width="700"><tr><td align="right" bgcolor="<%=value_c%>"><a href="writeForm.jsp">�۾���</a></td></tr></table>
<%
	if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr><td align="center">�Խ��ǿ� ����� ���� �����ϴ�.</td>
</table>
<%
	} else {
%>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
<tr height="30" bgcolor="<%=value_c%>">
	<td align="center"  width="50"  >�� ȣ</td>
	<td align="center"  width="250" >��   ��</td>
	<td align="center"  width="100" >�ۼ���</td>
	<td align="center"  width="150" >�ۼ���</td>
	<td align="center"  width="50"  >�� ȸ</td>
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
<!-- //--�˻��� -->
<script language="JavaScript">
function chkSch(form){
	if(form.sval.value){
		return true;
	}
	alert("�˻��϶��?");
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
			<OPTION value="writer" <%=(skey.equals("writer"))?"selected":""%>>�̸�</OPTION>
			<OPTION value="subject" <%=(skey.equals("subject"))?"selected":""%>>����</OPTION>
			<OPTION value="content" <%=(skey.equals("content"))?"selected":""%>>����</OPTION>
		</select>
		<input type=text name="sval" value="<%=sval%>">
		<input type=submit value="�˻�">
		<%=(!sval.equals(""))?"<a href=\"list.jsp\">�������</a>":""%>
	</td>
</tr>
</form>
</table>
<!-- �˻���--// -->

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
<a href="list.jsp?pageNum=<%= startPage - 10 %><%=pageReturn%>">[����]</a>
<%
		}
		for (int i = startPage ; i <= endPage ; i++) {
%>
	<a href="list.jsp?pageNum=<%= i %><%=pageReturn%>">[<%= i %>]</a>
<%
		}
		if (endPage < pageCount) {
%>
	<a href="list.jsp?pageNum=<%= startPage + 10 %><%=pageReturn%>">[����]</a>
<%
		}
	}
%>
</center>
</body>
</html>