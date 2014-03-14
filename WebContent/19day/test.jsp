<%@ page contentType="text/html;charset=EUC-KR" %>

<h2> test.jsp 입니다..!!</h2>

<%
	int x = 10;
	if(x > 0){ %>
		<font size="7">x는 0보다 크다.</font>
<% 	}else{%>
		<font size="7">x는 0보다 작다.</font>
<%	}%>