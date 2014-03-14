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
		out.print("<script language=\"JavaScript\">\n\talert(\"잘못된 접근입니다..\");\n\tlocation.href = \"list.jsp\";\n</script>");
	}
	book.setRegister(new Timestamp(System.currentTimeMillis()));
	GuestBookManager manager = GuestBookManager.getInstance();
	manager.insert(book);
	out.print("<script language=\"JavaScript\">\n\talert(\"방명록에 글을 등록하였습니다.\");\n\tlocation.href = \"list.jsp\";\n</script>");
%>
