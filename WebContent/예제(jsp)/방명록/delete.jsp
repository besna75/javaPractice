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
		out.print("<script language=\"JavaScript\">\n\talert(\"잘못된 접근입니다..\");\n\tlocation.href = \"list.jsp\";\n</script>");
	}
	GuestBookManager manager = GuestBookManager.getInstance();
	GuestBook book = manager.getGuestBook(id);
	if (book.getPassword().compareTo(password) == 0) {
		manager.delete(id);
		out.println("<script language=\"JavaScript\">\n\talert(\"글을 삭제하였습니다.\");\n\tlocation.href = \"list.jsp\";\n</script>");
	} else {
		out.println("<script language=\"JavaScript\">\n\talert(\"암호가 다릅니다.\");\n\thistory.go(-1);\n</script>");
	}
%>
