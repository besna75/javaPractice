<%@ page contentType="text/html; charset=EUC-KR"%>

<%
/* �Ķ������ type�� ������ String���� �����Ǿ� ����. Attribute�� type�� ���� ���� ����(Attribute�� Object�� return) */
String sessionId =
	(String)session.getAttribute("sessionId");
String sessionPw =
	(String)session.getAttribute("sessionPw");
%>
<%=sessionId %> <br />
<%=sessionPw %> <br />