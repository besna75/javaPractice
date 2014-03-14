<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<% request.setCharacterEncoding("euc-kr");%>
<jsp:useBean id="article" scope="page" class="board.BoardDataBean">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	String pageNum = request.getParameter("pageNum");
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.updateArticle(article);
	if(check==1){
%>
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>" >
<%
	}else if(check==0){
%>
<script language="JavaScript">
<!--
alert("비밀번호가 맞지 않습니다");
history.go(-1);
-->
</script>
<%
	}else{
%>
<script language="JavaScript">
<!--
alert("DB 에러입니다.");
history.go(-1);
-->
</script>
<%
	}
%>