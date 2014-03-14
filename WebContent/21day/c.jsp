<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String msg = request.getParameter("msg");
String id = request.getParameter("id");
String pw = request.getParameter("pw");
%>
<font size="5">
msg => <%=msg %>
id => <%=id %>
pw => <%=pw %>
</font>