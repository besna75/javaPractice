<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <title>JSTL core 예제 - forEach</title>
</head>
<body>
<h3>Header 정보:</h3>

<c:forEach var="head" items="${headerValues}">
  param: <c:out value="${head.key}"/><br>
  values:
   <c:forEach var="val" items="${head.value}">
     <c:out value="${val}"/>
   </c:forEach>
   <p>
</c:forEach>
<!-- 반복되는 형태로 보여주기 -->
<c:forEach var="a" begin="1" end="10" setp="1">
${a}<br/>
</c:forEach>

	for(int a=0;a<10;a++){ System.out.println(a);}

</body>
</html>
