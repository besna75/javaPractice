<%/*	[list.jsp]	*/%>
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "madvirus.guestbook.GuestBookManager" %>
<%@ page import = "madvirus.guestbook.GuestBook" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%!
	int PAGE_SIZE = 3;
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<%
	String pageNum = request.getParameter("num");
	if (pageNum == null) {	pageNum = "1";	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * PAGE_SIZE + 1;
	int endRow = currentPage * PAGE_SIZE;
	int count = 0;
	List bookList = null;
	GuestBookManager manager = GuestBookManager.getInstance();
	count = manager.getCount();
	if (count > 0) {	bookList = manager.getList(startRow, endRow);	}
%>
<html>
<head><title>글목록</title></head>
<body>
<table width="100%" align=center>
<tr><td><a href="writeForm.jsp">글쓰기</a></td></tr>
</table>
<%
	if (count == 0) {
%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" align="center">
<tr><td bgcolor="#e9e9e9">방명록에 저장된 글이 없습니다.</td>
</table>
<%
	} else {
%>
<table width="100%" border="1" cellpadding="0" cellspacing="0">
<%
		for (int i = 0 ; i < bookList.size() ; i++) {
			GuestBook book = (GuestBook)bookList.get(i);
%>
<tr>
	<td bgcolor="#e9e9e9">
		<b><%= book.getName() %>(<%= book.getEmail() %>)</b>
		- <font size="2"> <%= formatter.format(book.getRegister()) %>
<%
			if (book.getPassword() != null && !book.getPassword().equals(""))
			{
%>
		<a href="updateForm.jsp?id=<%= book.getId() %>">[수정]</a>
		<a href="deleteForm.jsp?id=<%= book.getId() %>">[삭제]</a>
<%
			}
%>
		</font>
	</td>
</tr>
<tr><td><%= book.getContent() %></td></tr>
<%
		}
%>
</table>
<%
	}

	if (count > 0)
	{
		int pageCount = count / PAGE_SIZE + ( count % PAGE_SIZE == 0 ? 0 : 1);
		int startPage = currentPage / PAGE_SIZE + 1;
		int endPage = startPage + 10;
		if (endPage > pageCount) endPage = pageCount;
		if (startPage > 10) {
%>
<a href="list.jsp?num=<%= startPage - 10 %>">[이전]</a>
<%
		}
		for (int i = startPage ; i <= endPage ; i++) {
%>
<a href="list.jsp?num=<%= i %>">[<%= i %>]</a>
<%
		}
		if (endPage < pageCount)
		{
%>
<a href="list.jsp?num=<%= startPage + 10 %>">[다음]</a>
<%
		}
	}
%>
</body>
</html>
<%
/**/
//페이징 기능이 들어가 있는 아주 중요한 문서입니다/
//GuestBookManager클래스의 getList()메소드와 연관해서
//한페이지에 정해진 숫자만큼의 테이블행을 보여주는
//로직입니다....분석하고 발표준비 하세요!!!
/**/
%>
