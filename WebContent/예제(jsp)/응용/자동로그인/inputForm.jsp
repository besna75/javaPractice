<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>ȸ������</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="common.js"></script>
<script language="JavaScript">
    
function checkIt(form) {
	if(form.passwd.value != form.passwd2.value)
	{
		alert("��й�ȣ�� �����ϰ� �Է��ϼ���");
		form.passwd.value = "";
		form.passwd2.value = "";
		form.passwd.focus();
		return false;
	}else if(document.getElementById('chk_id').value != 1){
		openConfirmid(form);
		return false;		
	}else{
		return validate(form);
	}
}


    // ���̵� �ߺ� ���θ� �Ǵ�
    function openConfirmid(userinput) {
        // ���̵� �Է��ߴ��� �˻�
        if (userinput.id.value == "") {
            alert("���̵� �Է��ϼ���");
            userinput.id.focus();
            return;
        }
        // url�� ����� �Է� id�� �����մϴ�.
        url = "confirmId.jsp?id=" + userinput.id.value ;
        
        // ���ο� �����츦 ���ϴ�.
        open(url, "confirm", "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");        
    }
    function zipCheck(){
		url="ZipCheck.jsp?check=y";
		open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
	}
</script>


<body bgcolor="<%=bodyback_c%>">
<form method="post" action="inputPro.jsp" name="userinput" onSubmit="return checkIt(this);">
  <table width="600" border="1" cellspacing="0" cellpadding="3" align="center" >
    <tr> 
    <td colspan="2" height="39" align="center" bgcolor="<%=value_c%>" >
       <font size="+1" ><b>ȸ������</b></font></td>
    </tr>
    <tr> 
      <td width="200" bgcolor="<%=value_c%>"><b>���̵� �Է�</b></td>
      <td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
    </tr>  

    <tr> 
      <td width="200"> <b>����� ID</b></td>
      <td width="400"> 
        <input type="text" name="id" size="10" maxlength="12" required="���̵�" option="alnumonly">
        <input type="button" name="confirm_id" value="ID�ߺ�Ȯ��" OnClick="openConfirmid(this.form)">
      </td>
    </tr>
    <tr> 
      <td width="200"> <b>��й�ȣ</b></td>
      <td width="400" > 
        <input type="password" name="passwd" size="15" maxlength="12" required="���" option="alnumonly">
      </td>
    <tr>  
      <td width="200"> <b>��й�ȣ Ȯ��</b></td>
      <td width="400"> 
        <input type="password" name="passwd2" size="15" maxlength="12" required="���" option="alnumonly">
      </td>
    </tr>
    
    <tr> 
      <td width="200" bgcolor="<%=value_c%>"><b>�������� �Է�</b></td>
      <td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
    <tr>  
    <tr> 
      <td width="200"> <b>����� �̸�</b></td>
      <td width="400"> 
        <input type="text" name="name" size="15" maxlength="10" required="����ڸ�" option="hangul">
      </td>
    </tr>
    <tr> 
      <td width="200"> <b>�ֹε�Ϲ�ȣ</b></td>
      <td width="400"> 
        <input type="text" name="jumin1" size="7" maxlength="6" required="�ֹε�Ϲ�ȣ" option="numberonly">
        -<input type="text" name="jumin2" size="7" maxlength="7" required="�ֹε�Ϲ�ȣ" option="numberonly">
      </td>
    </tr>
    <tr> 
      <td width="200"> <b>E-Mail</b></td>
      <td width="400"> 
        <input type="text" name="email" size="40" maxlength="30" required="E-Mail" option="email">
      </td>
    </tr>
    <tr> 
      <td width="200"> Blog</td>
      <td width="400"> 
        <input type="text" name="blog" size="60" maxlength="50">
      </td>
    </tr>
    <tr>  
      <td width="200">�����ȣ</td>
      <td width="400"> <input type="text" name="zipcode" size="7">
      <input type="button" value="�����ȣã��" onClick="zipCheck()"></td>
    </tr>
	<tr>  
      <td width="200">�ּ�</td>
      <td width="400"><input type="text" name="address" size="70"></td>
    </tr>
    <tr> 
      <td colspan="2" align="center" bgcolor="<%=value_c%>"> 
          <input type="submit" name="confirm" value="��   ��" >
          <input type="reset" name="reset" value="�ٽ��Է�">
          <input type="button" value="���Ծ���" onclick="javascript:window.location='main.jsp'">
      </td>
    </tr>
  </table>
</form>
<input type=hidden name="chk_id" id="chk_id" value='0'>
</body>
</html>
