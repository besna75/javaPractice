<%@ page contentType="text/html; charset=EUC-KR"%>

<%
/* ���޵� ��Ű �޾ƿ��� */
Cookie [] coo = request.getCookies(); // ��Ű�� �迭�� �޾ƿ���
for(Cookie c : coo){ // ���׷��̵� for��
	String cookieName = c.getName();
	String cookieValue = c.getValue();
	%><%=cookieName %> = <%=cookieValue %><br />
	<%}%>