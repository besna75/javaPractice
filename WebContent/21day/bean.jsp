<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    import="test.bean.Tv"
 %>

<jsp:useBean class="test.bean.Tv" id="t1"/>
<jsp:setProperty property="color" name="t1"/>  

<font size="5">
<jsp:getProperty property="color" name="t1"/>
</font>