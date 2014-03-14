<%@ page contentType="text/html; charset=EUC-KR"%>

<%
/* 파라미터의 type은 무조건 String으로 고정되어 있음. Attribute는 type을 자유 지정 가능(Attribute는 Object를 return) */
String sessionId =
	(String)session.getAttribute("sessionId");
String sessionPw =
	(String)session.getAttribute("sessionPw");
%>
<%=sessionId %> <br />
<%=sessionPw %> <br />