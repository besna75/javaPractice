<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import = " java.sql.*" %>
<%@ page import = " javax.sql.DataSource" %>
<%@ page import = " javax.naming.Context" %>
<%@ page import = " javax.naming.InitialContext" %>


<%
//Ŀ�ؼ�Ǯ
Context ctx = new InitialContext();
Context env = (Context)ctx.lookup("java:comp/env");
DataSource ds = (DataSource)env.lookup("jdbc/orcl");
Connection conn = ds.getConnection();

// 3�ܰ� SQL �ۼ�
PreparedStatement pstmt =
	conn.prepareStatement("select*from test");  // test ���̺��� �˻��ϰڴٴ� ����
// 4�ܰ� Query ����
ResultSet rs = pstmt.executeQuery();
// 5�ܰ� ����
while(rs.next()){ 
	String id = rs.getString("id");
	String pw = rs.getString("pw");
	int age = rs.getInt("age");
	Timestamp reg = rs.getTimestamp("reg");	
%> <%=id %><%=pw %><%=age %><%=reg %> <br />
<%}
// ���������� ������ �����ֱ�
rs.close();
pstmt.close();
conn.close();
%>