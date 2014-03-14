<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("euc-kr");
String name = request.getParameter("name");
%>
<font size="6">
name => <%=name %><br />
</font>


<!-- post 방식으로 한글을 받을 때 깨져 나오는 현상 처리하기
1. 인코딩 방식의 이해
요청 인코딩 Client -> Server
응답 인코딩 Server -> Client

2. 한글 인코딩 처리해 주기
요청 인코딩 처리를 해 주지 않았을 겨우 한글은 깨져서 나오게 된다. (ISO-8805로 기본 인식되기 때문에) 
 Client (pageEncoding="EUC-KR"으로 페이지 내 선언하였어도) 
 ==요청 과정에서 ISO-8805 인식=> Server는...한글을 이해할 수 없다...
따라서 받는 쪽에서 request.setCharacterEncoding("euc-kr");를 활용하여 한글을 볼 수 있도록 처리해 주어야한다-->