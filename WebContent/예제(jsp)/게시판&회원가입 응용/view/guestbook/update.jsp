<%/*	[update.jsp]	*/%>
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "madvirus.guestbook.GuestBookManager" %>
<%@ page import = "madvirus.guestbook.GuestBook" %>
<%@ page errorPage = "error.jsp" %>
<%	request.setCharacterEncoding("euc-kr");	%>
<jsp:useBean id="book" class="madvirus.guestbook.GuestBook">
	<jsp:setProperty name="book" property="*" />
</jsp:useBean>
<%
	if(!book.getMode().equals("mod")){
		out.print("<script language=\"JavaScript\">\n\talert(\"잘못된 접근입니다..\");\n\tlocation.href = \"list.jsp\";\n</script>");
	}
	GuestBookManager manager = GuestBookManager.getInstance();
	GuestBook oldBook = manager.getGuestBook(book.getId());
	if (book.getPassword().compareTo(oldBook.getPassword()) == 0) {
		manager.update(book);
		out.println("<script language=\"JavaScript\">\n\talert(\"글을 수정하였습니다.\");\n\tlocation.href = \"list.jsp\";\n</script>");
	} else {
		out.println("<script language=\"JavaScript\">\n\talert(\"암호가 다릅니다.\");\n\thistory.go(-1);\n</script>");
	}
%>
