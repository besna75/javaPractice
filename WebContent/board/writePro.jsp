<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="ch11.logon.*"%>
<%@ page import="board.*"%>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<!-- BoardDataBean���� �۾������� �ʿ��� �͵��� ���� 
	1. useBean���� ��ü ����
	2. setProperty�� �Ӽ��� ��
	3. set�ʿ����� (Reg_date, Ip ��û) 
	4. BoardDBBean(DAO)�� ����� ���� ��ü ����
	5. list.jsp�� ���� ����
-->

<jsp:useBean id="article" scope="page" class="board.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	article.setIp(request.getRemoteAddr());

    BoardDBBean dbPro = BoardDBBean.getInstance();
    dbPro.insertArticle(article);

    response.sendRedirect("list.jsp");
%>
