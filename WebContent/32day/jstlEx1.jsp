<%@ page  contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

id 변수값 설정
<!-- 
1. 자바식 표현
request.setAttribute("id","admin");  
2. JSTL 표현-->
<c:set var="id" value="admin"/><br /> <!-- var (이름 지정) -->

<c:out value="${id}"/><br />
${id} <!-- 표현언어만 쓴 경우 '' 안은 변수, 따옴표 없으면 값 출력--><br />

<c:out value="id"/> <!-- id 값이 아닌 id를 출력 --><br />

broeser 변수값 제거 후
<c:remove var="id"/>
<c:out value="${id}"/>
