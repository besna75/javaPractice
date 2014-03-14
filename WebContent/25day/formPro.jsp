<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="test.db.*"%>


<jsp:useBean class="test.db.DTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<%
DAO dao = DAO.getInstance();
dao.insert(dto);
out.println("Insert Success");
%>