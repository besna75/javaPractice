<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>�����Դϴ�..</title>
<link href="style.css" rel="stylesheet" type="text/css"> <!-- ��Ÿ�Ͻ�Ʈ ��ũ -->
</head>
<%
/* ȸ�����Ȯ��(������,�Ϲ���...��)  */
String id = (String)session.getAttribute("memId");  
LogonDBBean manager = LogonDBBean.getInstance();
LogonDataBean c = manager.getMember(id); // �α��� �Ǿ� �ִ� ����� ���� ���
String grade = c.getGrade();
                  //ȸ����� ������ ���� member.setGrade(rs.getString("grade"));�� LogonDBBean�� �߰���
                  
 try{
   if(session.getAttribute("memId")==null){// ���� ���� ��
   	
   %>
<script language="javascript">
<!--
function focusIt()
{      
   document.inform.id.focus();
}
 
 function checkIt()
 {
   inputForm=eval("document.inform");
   if(!inputForm.id.value){
     alert("���̵� �Է��ϼ���..");
	 inputForm.id.focus();
	 return false;
   }
   if(!inputForm.passwd.value){
     alert("���̵� �Է��ϼ���..");
	 inputForm.passwd.focus();
	 return false;
   }
 }
//-->
</script>
</head>

<body onLoad="focusIt();" bgcolor="<%=bodyback_c%>">

	<!-- �α��� �� : if{session.getAttribute("memId")==null -->
	<table width=500 cellpadding="0" cellspacing="0" align="center"
		border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">&nbsp;</td>

			<form name="inform" method="post" action="loginPro.jsp" onSubmit="return checkIt();">

				<td bgcolor="<%=title_c%>" width="100" align="right">���̵�</td>
				<td width="100" bgcolor="<%=value_c%>"><input type="text" name="id" size="15" maxlength="10"></td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">�����Դϴ�.</td>
			<td bgcolor="<%=title_c%>" width="100" align="right">�н�����</td>
			<td width="100" bgcolor="<%=value_c%>"><input type="password" name="passwd" size="15" maxlength="10"></td>
		</tr>
		<tr>
			<td colspan="3" bgcolor="<%=title_c%>" align="center">
				<input type="submit" name="Submit" value="�α���"> 
				<input type="button" value="ȸ������" onclick="javascript:window.location='inputForm.jsp'"> 
				<input type="button" value="�Խ���" onclick="javascript:window.location='/jsp/board/list.jsp'">
			</td>
			</form>
		</tr>
	</table>

<%}else{ /* session.getAttribute("memId")!=null */%>
	<!-- �α��� �� -->
	<table width=500 cellpadding="0" cellspacing="0" align="center"
		border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">�α��� ����</td>
			<td rowspan="3" bgcolor="<%=value_c%>" align="center"><%=session.getAttribute("memId")%>���� �湮�ϼ̽��ϴ�.
				<form method="post" action="logout.jsp">
					<input type="submit" value="�α׾ƿ�"> 
					<input type="button" value="ȸ����������" onclick="javascript:window.location='modify.jsp'">
					<input type="button" value="�Խ���" onclick="javascript:window.location='/jsp/board/list.jsp'">
				</form>
			</td>
		</tr>
		<tr>
		<%
		if (grade.equals("admin")) {%>
			<input type="button" value="���Ե� ȸ�� �˻�" onclick="javascript:window.location='../">
		<%
		}else {		
		%>
		<!-- nothing -->
		<%} %>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">�����ڸ޴�</td>
		</tr>
	</table>
	<br>
	<%}
 }catch(NullPointerException e){}
 %>
</body>
</html>
