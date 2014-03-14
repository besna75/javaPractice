<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="ch11.logon.*"%>
<%@ page import="board.*"%>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<!-- BoardDataBean에서 글쓰기폼에 필요한 것들을 수집 
	1. useBean으로 객체 생성
	2. setProperty로 속성값 셋
	3. set필요정보 (Reg_date, Ip 요청) 
	4. BoardDBBean(DAO)의 사용을 위한 객체 생성
	5. list.jsp에 정보 전송
-->

<jsp:useBean id="article" scope="page" class="board.BoardDataBean">
<!-- ↑ DTO(BoardDataBean)을 참조하여 article이라는 Bean을 생성 
	 ↓ article의 속성 set/get--> 
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	article.setIp(request.getRemoteAddr());

    BoardDBBean dbPro = BoardDBBean.getInstance();
    dbPro.insertArticle(article);  // DAO(BoardDBBean)의 메서드를 호출하여 DB에 저장 

    response.sendRedirect("list.jsp"); // 수행한 것에 대한 전달
%>
