<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <title>JSTL core ���� - forTokens</title>
</head>
<body>

<c:forTokens var="car" items="Sprinter Trueno AE86,RX-7 Savanna FC3S,Lancer Evolution III,RX-7 Efini FD3S" delims=","><!-- delims=������ -->
  �ڵ��� �̸�: <c:out value="${car}"/><br>
</c:forTokens>

<c:forTokens var="KoreaCar" items="Sonata, Perari, Tusan, Genesis, Granger" delims=",">
�ڵ���(����) : <c:out value="${KoreaCar}"/><br>
</c:forTokens>

</body>
</html>
