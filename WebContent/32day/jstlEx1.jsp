<%@ page  contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

id ������ ����
<!-- 
1. �ڹٽ� ǥ��
request.setAttribute("id","admin");  
2. JSTL ǥ��-->
<c:set var="id" value="admin"/><br /> <!-- var (�̸� ����) -->

<c:out value="${id}"/><br />
${id} <!-- ǥ���� �� ��� '' ���� ����, ����ǥ ������ �� ���--><br />

<c:out value="id"/> <!-- id ���� �ƴ� id�� ��� --><br />

broeser ������ ���� ��
<c:remove var="id"/>
<c:out value="${id}"/>
