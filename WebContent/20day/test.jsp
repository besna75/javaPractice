<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String ip = request.getRemoteAddr();
	String uri = request.getRequestURI(); uri /* (ip�� port�� ������ �ּ�) */
	StringBuffer url = request.getRequestURL();	
%>

<font size="5">
ip => <%=ip%> <br />
uri => <%=uri%> <br />
url => <%=url%> <br />
</font>