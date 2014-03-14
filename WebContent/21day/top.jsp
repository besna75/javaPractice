<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<h2>top.jsp¿‘¥œ¥Ÿ</h2>
<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");
%>
<font size="5">
id => <%=id %><br />
pw => <%=pw %><br />
</font>
<hr color="red" />