<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "db.LogonDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<jsp:useBean id="member" class="db.LogonDataBean">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
    member.setReg_date(new Timestamp(System.currentTimeMillis()) );
    LogonDBBean manager = LogonDBBean.getInstance();
    manager.insertMember(member);

	session.setAttribute("memId",member.getId());
	response.sendRedirect("main.jsp");
//    response.sendRedirect("loginForm.jsp");
%>