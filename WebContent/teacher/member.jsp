<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="ch11.logon.*" %>
<%@ page import="java.util.*" %>
<h2> ���Ե� ȸ���˻�</h2>
<%
	LogonDBBean dao = LogonDBBean.getInstance();
	List<LogonDataBean> list = dao.getMember();
	for(LogonDataBean dto : list){
	%>	<%=dto.getId() %> 
		<%=dto.getName() %> 
		<%=dto.getReg_date() %> <br />
  <%}%>









