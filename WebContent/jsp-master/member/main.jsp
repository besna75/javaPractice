<!-- 
	�α��� �� �۾��� ��� �߰��ϱ�
-->
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="team5.member.*"%>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>�����Դϴ�..</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%	
	String id = (String)session.getAttribute("memId");
	LogonDBBean manager = LogonDBBean.getInstance();

	try {
		if (session.getAttribute("memId") == null) { // ������ ���� ��
			
			String cooId = "";
			String cooPasswd = "";
		    
			try{
				Cookie[] cookies = request.getCookies(); // ��û���� ��Ű�� �����´�.
				
				if(cookies!=null){ // ID,PASSWD ��Ű�� ���� ��
					for(int i=0; i<cookies.length; i++){                        
						if(cookies[i].getName().equals("cooId")){  //cooId�� �޾ƿµ� id�� ����.
							cooId=cookies[i].getValue();
						}else if(cookies[i].getName().equals("cooPasswd")){
							cooPasswd=cookies[i].getValue();
						}
					}
				}
			}catch(Exception e){}
%>
<script language="javascript">
<!--
	function focusIt() {
		document.inform.id.focus();
	}

	function checkIt() {
		inputForm = eval("document.inform");
		if (!inputForm.id.value) {
			alert("���̵� �Է��ϼ���..");
			inputForm.id.focus();
			return false;
		}
		if (!inputForm.passwd.value) {
			alert("���̵� �Է��ϼ���..");
			inputForm.passwd.focus();
			return false;
		}
	}
//-->
</script>
</head>

<body onLoad="focusIt();" bgcolor="<%=bodyback_c%>">
	<table width=500 cellpadding="0" cellspacing="0" align="center" border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">&nbsp;</td>

			<form name="inform" method="post" action="loginPro.jsp" onSubmit="return checkIt();">

				<td bgcolor="<%=title_c%>" width="100" align="right">���̵�</td>
				<td width="100" bgcolor="<%=value_c%>"><input type="text" name="id" size="15" maxlength="10" value="<%=cooId%>"></td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">
				<!-- �����Դϴ�. : �α��� �� -->
				<input type="button" value="�Խ���" onclick="javascript:window.location='../board/list.jsp'">
			</td>
			<td bgcolor="<%=title_c%>" width="100" align="right">�н�����</td>
			<td width="100" bgcolor="<%=value_c%>"><input type="password" name="passwd" size="15" maxlength="10" value="<%=cooPasswd%>"></td>
		</tr>
		<tr>
			<td colspan="3" bgcolor="<%=title_c%>" align="center">
				<input type="submit" name="Submit" value="�α���">
				<input type="button" value="ȸ������" onclick="javascript:window.location='inputForm.jsp'">
			</td>
			</form>
		</tr>
	</table>
	<%
		} else {	// session.getAttribute("memId") != null : �α��� ��
		
		//������ ���� üũ		
		boolean isAdmin = manager.isAdmin(id);
	%>
	<table width=500 cellpadding="0" cellspacing="0" align="center"border="1">
		<tr>
			<td width="300" bgcolor="<%=bodyback_c%>" height="20">������</td>

			<td rowspan="3" bgcolor="<%=value_c%>" align="center">
				<%=session.getAttribute("memId")%>����<br>�湮�ϼ̽��ϴ�.
				<form method="post" action="logout.jsp">
					<input type="submit" value="�α׾ƿ�">
					<input type="button" value="ȸ����������" onclick="javascript:window.location='modify.jsp'">
				</form>
			</td>
		</tr>
		<tr>
			<td rowspan="2" bgcolor="<%=bodyback_c%>" width="300">
				<!-- �����Դϴ�. : �α��� �� -->
				<input type="button" value="�Խ���" onclick="javascript:window.location='../board/list.jsp'">
				<%
				if (isAdmin) {
				%>
					<input type="button" value="���Ե� ȸ�� �˻�" onclick="javascript:window.location='../board/readMemberAll.jsp'">
				<%
				} else {
				%>
					<!-- ���� -->
				<% } %>
			</td>
		</tr>
	</table>
	<br>
	<%
		}
		} catch (NullPointerException e) {
		}
	%>
</body>
</html>
