<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<h2>�α��� ó�� �Ϸ�</h2>
<font size="6">
id : ${id }
pw : ${pw }

check : ${check}
session : ${memId } <br />
<!-- �̸��� ������ ��� request ������ �켱�Ѵ�.
�̸� �����ϱ� ���Ͽ� �Ʒ��� ���� Scope��  �̿��� ������ ���ش�.-->
requestScope : ${requestScope.memId }
sessionScope : ${sessionScope.memId }
</font>