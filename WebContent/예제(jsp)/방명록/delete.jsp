<%/*	[delete.jsp]	*/%>
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "madvirus.guestbook.GuestBookManager" %>
<%@ page import = "madvirus.guestbook.GuestBook" %>
<%@ page errorPage = "error.jsp" %>
<%	request.setCharacterEncoding("euc-kr");	%>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	String password = request.getParameter("password");
	String mode = request.getParameter("mode");
	if(!mode.equals("del")){
		out.print("<script language=\"JavaScript\">\n\talert(\"�߸��� �����Դϴ�..\");\n\tlocation.href = \"list.jsp\";\n</script>");
	}
	GuestBookManager manager = GuestBookManager.getInstance();
	GuestBook book = manager.getGuestBook(id);
	if (book.getPassword().compareTo(password) == 0) {
		manager.delete(id);
		out.println("<script language=\"JavaScript\">\n\talert(\"���� �����Ͽ����ϴ�.\");\n\tlocation.href = \"list.jsp\";\n</script>");
	} else {
		out.println("<script language=\"JavaScript\">\n\talert(\"��ȣ�� �ٸ��ϴ�.\");\n\thistory.go(-1);\n</script>");
	}
%>
