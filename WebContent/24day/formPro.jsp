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
// Parameter는 무조건 문자로 넘어온다. 따라서 age의 경우는 숫자로 형변환을 하여 넣어준다.

/* JDBC 1,2단계 연결 및 사용 */
Class.forName("oracle.jdbc.driver.OracleDriver");
String path = "jdbc:oracle:thin:@220.86.7.141:1521:orcl";
Connection conn = DriverManager.getConnection(path,"JAVA05","JAVA05");

/* JDBC 3단계 쿼리  */
String sql = "insert into test values(?,?,?,sysdate)"; // 쿼리 안의 ?를 위치홀더라 한다.미완성된 쿼리문인 위치홀더는 반드시 채워주어야 한다.
PreparedStatement pstmt = conn.prepareStatement(sql); 
pstmt.setString(1,id); // 위치홀더의 1번째 ? 
pstmt.setString(2,pw); // 위치홀더의 2번째 ? 
pstmt.setInt(3,age); // 위치홀더의 3번째 ? 

/* JDBC 4단계 실행  */	
pstmt.executeUpdate();
out.println("insert Success");
pstmt.close();
conn.close();

%>