<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<h2> ORACLE SQL Äõ¸® ¼öÇà</h2>
<table border="1">
	<tr>
		<td>id </td> <td>pw</td> <td> name</td> <td> age </td> <td>reg</td>
	</tr>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try{
 	Context ct = new InitialContext();
 	Context cp = (Context)ct.lookup("java:comp/env");
 	DataSource ds = (DataSource)cp.lookup("jdbc/project");
 	conn = ds.getConnection();
 	

 	pstmt = conn.prepareStatement("select * from member1");
 	rs = pstmt.executeQuery();
 	while(rs.next()){
 		String id = rs.getString("id");
 		String pw = rs.getString("passwd");
 		String name = rs.getString("name");
 		String age = rs.getString("email");
 		Timestamp reg = rs.getTimestamp("reg_date");
%>
	<tr>
		<td><%=id%></td> <td><%=pw%></td> <td><%=name%></td> 
		<td> <%=age%></td> <td><%=reg%></td>
	</tr>	
<%}
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(rs != null) try{ rs.close(); }catch(SQLException se){}
	if(pstmt!= null) try{ pstmt.close(); }catch(SQLException se){}
	if(conn != null) try{ conn.close(); }catch(SQLException se){}
}
%>




	















