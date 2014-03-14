<%@ page  contentType="text/html; charset=EUC-KR"%>
<%@ page import = "test.db.DAO"%>
<%@ page import="test.db.DTO"%>
<%@ page import="java.util.ArrayList"%>

<%
//DAO dao = new DAO();
DAO dao = DAO.getInstance();
ArrayList<DTO> list = dao.select();
for(DTO dto : list){
	%> <%=dto.getId() %>
	<%=dto.getPw() %>
	<%=dto.getAge() %>
	<%=dto.getReg() %> <br />
<% }%>
