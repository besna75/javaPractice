<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
/* response.sendRedirect("c.jsp");  Redirect는 단순히 이동만 함, 받아서 바로 넘겨준것으로 가시적 화면은  c로 바로 간것처럼 보임 */
%>


<jsp:forward page="c.jsp"> <!-- forward는 그 데이터가 함께  감, 값을 받아서 함께 넘겨주므로 전송된 데이터가 보임 -->
<jsp:param value="java" name="id"/>
<jsp:param value="1234" name="pw"/>
</jsp:forward>
