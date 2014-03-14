<%@ page contentType="text/html; charset=EUC-KR"%>

<%
/* 전달된 쿠키 받아오기 */
Cookie [] coo = request.getCookies(); // 쿠키를 배열로 받아오기
for(Cookie c : coo){ // 업그레이드 for문
	String cookieName = c.getName();
	String cookieValue = c.getValue();
	%><%=cookieName %> = <%=cookieValue %><br />
	<%}%>