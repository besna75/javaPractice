<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="ch11.logon.*"%>
<%@ page import="board.*"%>
<%@ include file="/view/color.jsp"%>

<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
	int num = 0, ref = 1, re_step = 0, re_level = 0; //���� �ʱ�ȭ
	try {
		if (request.getParameter("num") != null) {//�۹�ȣ�� ���� ��� (�۹�ȣ!=null)
			num = Integer.parseInt(request.getParameter("num")); //�۹�ȣ
			ref = Integer.parseInt(request.getParameter("ref")); //�۱׷� ��ȣ
			re_step = Integer.parseInt(request.getParameter("re_step")); //��� �޸� ������
			re_level = Integer.parseInt(request.getParameter("re_level")); //�ۼ��� ���� - ���� 0, �亯 1, �亯�� �亯 2
		}
		
		/* �α��� �� ȸ����� üũ */   		
		String id = (String)session.getAttribute("memId"); //session�̹Ƿ� ������ requset ���� ��� 
	 	LogonDBBean manager = LogonDBBean.getInstance(); //DAO�� �޼ҵ� ����� ���� �ν��Ͻ� ����
	 	LogonDataBean c = manager.getMember(id); // �α��� �Ǿ� �ִ� ����� ���� ���  		
	 	String grade =""; // ���� ������ �ʱ�ȭ �ؾߵȴ�.
	 	String writer =""; // �ۼ���
	 	String email =""; // �ۼ��� �̸���
	 	
		boolean logged = false; 
		if (session.getAttribute("memId") != null) {
			logged = true;
			grade = c.getGrade();	//��������
			writer = c.getName();
			email = c.getEmail();
		}
	
%>

<body bgcolor="<%=bodyback_c%>">
<center>
<b>�۾���</b> <br>
<!-- post send to writePro.jsp -->
<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
	<!-- �� �ۼ� �� �����Ǵ� ���� : �� ������ȣ, �۱׷��ȣ, ��ۼ�����, ������ -->
	<input type="hidden" name="num" value="<%=num%>"> 
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="re_step" value="<%=re_step%>"> 
	<input type="hidden" name="re_level" value="<%=re_level%>">

	<table width="400" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c%>" align="center">
		<tr>
			<td align="right" colspan="2" bgcolor="<%=value_c%>">
				<a href="list.jsp"> �۸��</a></td>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">�� ��</td>
			<td width="330"><input type="text" size="10" maxlength="10" name="writer" value="<%=writer%>" disabled>
				<input type="hidden" name="writer" value="<%=writer%>"> <!-- �ۼ��ڸ� ����ó���� ���������� -->
			</td> 
			<!-- �ۼ��ڸ� ��������, disabled�� �̸����渷�� -->
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">�� ��</td>
			<td width="330">
				<%
					if (request.getParameter("num") == null) { // �۹�ȣ ���� = ������ ��
				%> 		<input type="text" size="40" maxlength="50" name="subject">
			</td>
				<%
					} else { // ������ �ƴ� �� = ����϶� [�亯] ��� �ޱ�
				%>
						<input type="text" size="40" maxlength="50" name="subject" value="[�亯]">
			<%
				}
			%>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">Email</td>
			<td width="330"><input type="text" size="40" maxlength="30"	name="email" value="<%=email%>">
			<input type="hidden" name="writer" value="<%=email%>">
			</td>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">�� ��</td>
			<td width="330"><textarea name="content" rows="13" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td width="70" bgcolor="<%=value_c%>" align="center">��й�ȣ</td>
			<td width="330"><input type="password" size="8" maxlength="12" name="passwd"></td>
		</tr>
		<tr>
			<td colspan=2 bgcolor="<%=value_c%>" align="center">
				<input type="submit" value="�۾���"> 
				<input type="reset"	value="�ٽ��ۼ�"> 
				<input type="button" value="��Ϻ���" OnClick="window.location='list.jsp'"></td>
		</tr>
	</table>
	<%
		} catch (Exception e) {
		}
	%>
</form>
</body>
</html>
