<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "test.bean.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<jsp:useBean id="article" scope="page" class="test.board.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
	String id = (String)session.getAttribute("memId");
	article.setWriter(id);
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	article.setIp(request.getRemoteAddr());

    BoardDBBean dbPro = BoardDBBean.getInstance();
    dbPro.insertArticle(article);

    response.sendRedirect("list.jsp");
%>
