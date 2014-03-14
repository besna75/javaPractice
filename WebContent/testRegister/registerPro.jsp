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
String sql = "insert into members values(?,?,?,sysdate)"; // 쿼리 안의 ?를 위치홀더라 한다.미완성된 쿼리문인 위치홀더는 반드시 채워주어야 한다.
PreparedStatement pstmt = conn.prepareStatement(sql); 
pstmt.setString(1,id);
pstmt.setString(2,pw);
pstmt.setString(3,pwc);
pstmt.setString(4,name);
pstmt.setString(5,citynum);
pstmt.setString(6,email);
pstmt.setString(7,birth);
pstmt.setString(8,sex);
pstmt.setString(9,ph);
pstmt.setString(10,hp);
pstmt.setString(11,addr);
pstmt.setString(12,intField);
pstmt.setString(13,mailAlam);
pstmt.setString(14,joinMent);
		
		
/* JDBC 4단계 실행  */	
pstmt.executeUpdate();
out.println("insert Success");
pstmt.close();
conn.close();

%>