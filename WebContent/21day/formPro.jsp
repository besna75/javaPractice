<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<jsp:usebean class="test.bean.Bean" id="bean" />
<jsp:setProperty name="bean" property="*" /> <!-- ��� ���� ��� * Ȱ�� -->

id = > <jsp:getProperty name="bean" property="id" /> <br />
pw = > <jsp:getProperty name="bean" property="pw" /><br />
age = > <jsp:getProperty name="bean" property="age" /><br />
name = > <jsp:getProperty name="bean" property="name" />
