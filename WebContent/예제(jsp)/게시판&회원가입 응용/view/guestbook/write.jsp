<%/*	[write.jsp]	*/%>
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "madvirus.guestbook.GuestBookManager" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page errorPage = "error.jsp" %>
<%	request.setCharacterEncoding("euc-kr");	%>
<jsp:useBean id="book" class="madvirus.guestbook.GuestBook">
	<jsp:setProperty name="book" property="*" />
</jsp:useBean>
<%
	if(!book.getMode().equals("add")){
		out.print("<script language=\"JavaScript\">\n\talert(\"�߸��� �����Դϴ�..\");\n\tlocation.href = \"list.jsp\";\n</script>");
	}
	book.setRegister(new Timestamp(System.currentTimeMillis()));
	GuestBookManager manager = GuestBookManager.getInstance();
	manager.insert(book);
	out.print("<script language=\"JavaScript\">\n\talert(\"���Ͽ� ���� ����Ͽ����ϴ�.\");\n\tlocation.href = \"list.jsp\";\n</script>");
%>
