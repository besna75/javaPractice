<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/ch01/date.jsp" var="url" /> <!-- c:import�� include�� ����� -->

response.sendRedirect("");
<c:redirect url="/jsp/board/list.jsp"/>


<html>
<head><title>JSTL core ���� - import</title></head>
<body>

${url}

</body>
</html>