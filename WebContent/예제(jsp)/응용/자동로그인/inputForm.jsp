<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="common.js"></script>
<script language="JavaScript">
    
function checkIt(form) {
	if(form.passwd.value != form.passwd2.value)
	{
		alert("비밀번호를 동일하게 입력하세요");
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


    // 아이디 중복 여부를 판단
    function openConfirmid(userinput) {
        // 아이디를 입력했는지 검사
        if (userinput.id.value == "") {
            alert("아이디를 입력하세요");
            userinput.id.focus();
            return;
        }
        // url과 사용자 입력 id를 조합합니다.
        url = "confirmId.jsp?id=" + userinput.id.value ;
        
        // 새로운 윈도우를 엽니다.
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
       <font size="+1" ><b>회원가입</b></font></td>
    </tr>
    <tr> 
      <td width="200" bgcolor="<%=value_c%>"><b>아이디 입력</b></td>
      <td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
    </tr>  

    <tr> 
      <td width="200"> <b>사용자 ID</b></td>
      <td width="400"> 
        <input type="text" name="id" size="10" maxlength="12" required="아이디" option="alnumonly">
        <input type="button" name="confirm_id" value="ID중복확인" OnClick="openConfirmid(this.form)">
      </td>
    </tr>
    <tr> 
      <td width="200"> <b>비밀번호</b></td>
      <td width="400" > 
        <input type="password" name="passwd" size="15" maxlength="12" required="비번" option="alnumonly">
      </td>
    <tr>  
      <td width="200"> <b>비밀번호 확인</b></td>
      <td width="400"> 
        <input type="password" name="passwd2" size="15" maxlength="12" required="비번" option="alnumonly">
      </td>
    </tr>
    
    <tr> 
      <td width="200" bgcolor="<%=value_c%>"><b>개인정보 입력</b></td>
      <td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
    <tr>  
    <tr> 
      <td width="200"> <b>사용자 이름</b></td>
      <td width="400"> 
        <input type="text" name="name" size="15" maxlength="10" required="사용자명" option="hangul">
      </td>
    </tr>
    <tr> 
      <td width="200"> <b>주민등록번호</b></td>
      <td width="400"> 
        <input type="text" name="jumin1" size="7" maxlength="6" required="주민등록번호" option="numberonly">
        -<input type="text" name="jumin2" size="7" maxlength="7" required="주민등록번호" option="numberonly">
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
      <td width="200">우편번호</td>
      <td width="400"> <input type="text" name="zipcode" size="7">
      <input type="button" value="우편번호찾기" onClick="zipCheck()"></td>
    </tr>
	<tr>  
      <td width="200">주소</td>
      <td width="400"><input type="text" name="address" size="70"></td>
    </tr>
    <tr> 
      <td colspan="2" align="center" bgcolor="<%=value_c%>"> 
          <input type="submit" name="confirm" value="등   록" >
          <input type="reset" name="reset" value="다시입력">
          <input type="button" value="가입안함" onclick="javascript:window.location='main.jsp'">
      </td>
    </tr>
  </table>
</form>
<input type=hidden name="chk_id" id="chk_id" value='0'>
</body>
</html>
