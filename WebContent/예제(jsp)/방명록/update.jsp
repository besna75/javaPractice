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
		out.print("<script language=\"JavaScript\">\n\talert(\"�߸��� �����Դϴ�..\");\n\tlocation.href = \"list.jsp\";\n</script>");
	}
	GuestBookManager manager = GuestBookManager.getInstance();
	GuestBook oldBook = manager.getGuestBook(book.getId());
	if (book.getPassword().compareTo(oldBook.getPassword()) == 0) {
		manager.update(book);
		out.println("<script language=\"JavaScript\">\n\talert(\"���� �����Ͽ����ϴ�.\");\n\tlocation.href = \"list.jsp\";\n</script>");
	} else {
		out.println("<script language=\"JavaScript\">\n\talert(\"��ȣ�� �ٸ��ϴ�.\");\n\thistory.go(-1);\n</script>");
	}
%>
