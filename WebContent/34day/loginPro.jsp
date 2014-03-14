<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<h2>로그인 처리 완료</h2>
<font size="6">
id : ${id }
pw : ${pw }

check : ${check}
session : ${memId } <br />
<!-- 이름이 동일할 경우 request 정보가 우선한다.
이를 구별하기 위하여 아래와 같이 Scope를  이용한 구분을 해준다.-->
requestScope : ${requestScope.memId }
sessionScope : ${sessionScope.memId }
</font>