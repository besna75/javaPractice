<%/*	[deleteForm.jsp]	*/%>
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page errorPage = "error.jsp" %>
<%
	int id = Integer.parseInt(request.getParameter("id"));
%>
<html>
<head><title>�ۻ���</title></head>
<body>
<table width="100%" border="1" cellpadding="0" cellspacing="0" align="center">
<form action="delete.jsp" method="post">
<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="mode" value="del">
<tr><td>��ȣ</td><td><input type="password" name="password" size="10"><br>���� ���� �Է��� ��ȣ�� �����ؾ� ���� �����˴ϴ�.</td></tr>
<tr><td colspan="2"><input type="submit" value="�ۻ����ϱ�"> <input type="button" value="���ư���" onclick="location.href('list.jsp');"></td></tr>
</form>
</table>
</body>
</html>
