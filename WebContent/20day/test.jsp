<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String ip = request.getRemoteAddr();
	String uri = request.getRequestURI(); uri /* (ip와 port를 제외한 주소) */
	StringBuffer url = request.getRequestURL();	
%>

<font size="5">
ip => <%=ip%> <br />
uri => <%=uri%> <br />
url => <%=url%> <br />
</font>