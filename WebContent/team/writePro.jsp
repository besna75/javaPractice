<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<%-- writeForm���� �Ѿ���� 9���� �Ķ���� ���� javaBean�� �̿��ؼ� DTO�� ������Ű��  name=article�� �Ӽ����� �����Ѵ�.  --%>
<jsp:useBean id="article" scope="page" class="board.BoardDataBean"> <!-- �ڹ� ��  ��ü ����  (�׼��±� <jsp:useBean>)--> 
   <jsp:setProperty name="article" property="*"/><!-- �ڹ� ���� �Ӽ����� ����(setProperty) -->
</jsp:useBean>

<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) ); //�ð��� ǥ���ϴ� ��ü���� �� ����
	article.setIp(request.getRemoteAddr()); // request�޼ҵ�(API����)�� ����Ͽ�  Ip����
	//�̷ν� Sequence�� ���� readcount��� ������ �����ϰ� ������ 11������ ��� ä����

    BoardDBBean dbPro = BoardDBBean.getInstance(); // DAO�� �̱� �ν��Ͻ��� ������ ��ü�� �������� dbPro ��ü����
    dbPro.insertArticle(article); //DAO�� insertArticle�޼ҵ带 ���� �����ͺ��̽��� �� ������

    response.sendRedirect("list.jsp"); //�Ϸ��� ������� ��!
%>
