<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import = " java.sql.DriverManager" %>
<%@ page import = " java.sql.Connection" %>
<%@ page import = " java.sql.PreparedStatement" %>
<%@ page import = " java.sql.ResultSet" %>
<%@ page import = " java.sql.Timestamp" %>
<%

String id = request.getParameter("id");
String pw = request.getParameter("pw");
int age = Integer.parseInt(request.getParameter("age"));
// Parameter�� ������ ���ڷ� �Ѿ�´�. ���� age�� ���� ���ڷ� ����ȯ�� �Ͽ� �־��ش�.

/* JDBC 1,2�ܰ� ���� �� ��� */
Class.forName("oracle.jdbc.driver.OracleDriver");
String path = "jdbc:oracle:thin:@220.86.7.141:1521:orcl";
Connection conn = DriverManager.getConnection(path,"JAVA05","JAVA05");

/* JDBC 3�ܰ� ����  */
String sql = "insert into test values(?,?,?,sysdate)"; // ���� ���� ?�� ��ġȦ���� �Ѵ�.�̿ϼ��� �������� ��ġȦ���� �ݵ�� ä���־�� �Ѵ�.
PreparedStatement pstmt = conn.prepareStatement(sql); 
pstmt.setString(1,id); // ��ġȦ���� 1��° ? 
pstmt.setString(2,pw); // ��ġȦ���� 2��° ? 
pstmt.setInt(3,age); // ��ġȦ���� 3��° ? 

/* JDBC 4�ܰ� ����  */	
pstmt.executeUpdate();
out.println("insert Success");
pstmt.close();
conn.close();

%>