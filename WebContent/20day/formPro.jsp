<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("euc-kr");
String name = request.getParameter("name");
%>
<font size="6">
name => <%=name %><br />
</font>


<!-- post ������� �ѱ��� ���� �� ���� ������ ���� ó���ϱ�
1. ���ڵ� ����� ����
��û ���ڵ� Client -> Server
���� ���ڵ� Server -> Client

2. �ѱ� ���ڵ� ó���� �ֱ�
��û ���ڵ� ó���� �� ���� �ʾ��� �ܿ� �ѱ��� ������ ������ �ȴ�. (ISO-8805�� �⺻ �νĵǱ� ������) 
 Client (pageEncoding="EUC-KR"���� ������ �� �����Ͽ��) 
 ==��û �������� ISO-8805 �ν�=> Server��...�ѱ��� ������ �� ����...
���� �޴� �ʿ��� request.setCharacterEncoding("euc-kr");�� Ȱ���Ͽ� �ѱ��� �� �� �ֵ��� ó���� �־���Ѵ�-->