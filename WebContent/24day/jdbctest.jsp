<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import = " java.sql.DriverManager" %>
<%@ page import = " java.sql.Connection" %>
<%@ page import = " java.sql.PreparedStatement" %>
<%@ page import = " java.sql.ResultSet" %>
<%@ page import = " java.sql.Timestamp" %>

<%
//JDBC 1�ܰ� ����̹� �ε�
Class.forName("oracle.jdbc.driver.OracleDriver");
// 2�ܰ� DB ����
String path = "jdbc:oracle:thin:@220.86.7.141:1521:orcl";
Connection conn = DriverManager.getConnection(path,"JAVA05","JAVA05");
out.println(conn);
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