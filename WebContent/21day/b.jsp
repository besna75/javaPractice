<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
/* response.sendRedirect("c.jsp");  Redirect�� �ܼ��� �̵��� ��, �޾Ƽ� �ٷ� �Ѱ��ذ����� ������ ȭ����  c�� �ٷ� ����ó�� ���� */
%>


<jsp:forward page="c.jsp"> <!-- forward�� �� �����Ͱ� �Բ�  ��, ���� �޾Ƽ� �Բ� �Ѱ��ֹǷ� ���۵� �����Ͱ� ���� -->
<jsp:param value="java" name="id"/>
<jsp:param value="1234" name="pw"/>
</jsp:forward>
