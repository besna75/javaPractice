<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import = " java.sql.*" %>
<%@ page import = " javax.sql.DataSource" %>
<%@ page import = " javax.naming.Context" %>
<%@ page import = " javax.naming.InitialContext" %>


<%
//커넥션풀
Context ctx = new InitialContext();
Context env = (Context)ctx.lookup("java:comp/env");
DataSource ds = (DataSource)env.lookup("jdbc/orcl");
Connection conn = ds.getConnection();

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