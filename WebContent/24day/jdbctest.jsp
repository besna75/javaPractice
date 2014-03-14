<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import = " java.sql.DriverManager" %>
<%@ page import = " java.sql.Connection" %>
<%@ page import = " java.sql.PreparedStatement" %>
<%@ page import = " java.sql.ResultSet" %>
<%@ page import = " java.sql.Timestamp" %>

<%
//JDBC 1단계 드라이버 로딩
Class.forName("oracle.jdbc.driver.OracleDriver");
// 2단계 DB 연결
String path = "jdbc:oracle:thin:@220.86.7.141:1521:orcl";
Connection conn = DriverManager.getConnection(path,"JAVA05","JAVA05");
out.println(conn);
// 3단계 SQL 작성
PreparedStatement pstmt =
	conn.prepareStatement("select*from test");  // test 테이블을 검색하겠다는 쿼리
// 4단계 Query 실행
ResultSet rs = pstmt.executeQuery();
// 5단계 추출
while(rs.next()){ 
	String id = rs.getString("id");
	String pw = rs.getString("pw");
	int age = rs.getInt("age");
	Timestamp reg = rs.getTimestamp("reg");	
%> <%=id %><%=pw %><%=age %><%=reg %> <br />
<%}
// 마지막에는 연결을 끊어주기
rs.close();
pstmt.close();
conn.close();
%>