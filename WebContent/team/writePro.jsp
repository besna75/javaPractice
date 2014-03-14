<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<%-- writeForm에서 넘어오는 9개의 파라미터 값을 javaBean을 이용해서 DTO에 생성시키고  name=article로 속성값을 저장한다.  --%>
<jsp:useBean id="article" scope="page" class="board.BoardDataBean"> <!-- 자바 빈  객체 생성  (액션태그 <jsp:useBean>)--> 
   <jsp:setProperty name="article" property="*"/><!-- 자바 빈의 속성값을 저장(setProperty) -->
</jsp:useBean>

<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) ); //시간을 표현하는 객체생성 후 저장
	article.setIp(request.getRemoteAddr()); // request메소드(API참조)를 사용하여  Ip저장
	//이로써 Sequence를 쓰는 readcount라는 변수를 제외하고 나머지 11개값이 모두 채워짐

    BoardDBBean dbPro = BoardDBBean.getInstance(); // DAO의 싱글 인스턴스로 생성된 객체의 재사용으로 dbPro 객체생성
    dbPro.insertArticle(article); //DAO의 insertArticle메소드를 통해 데이터베이스에 글 저장함

    response.sendRedirect("list.jsp"); //완료후 목록으로 감!
%>
