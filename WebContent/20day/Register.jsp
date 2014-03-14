<%@ page contentType="text/html;charset=UTF-8" %>
<%
request.setCharacterEncoding("euc-kr");
%>
    
<html>
<head>
  <meta content="text/html; charset=UTF-8" />
  <title>Register</title>
 <style type="text/css">
 table {
 font : "dotum";
 font-size : 13px; }
 td.col { 
    font : "돋움";
    font-size : 15px; 
    font-weight: bold;
    line-hight: 2em;
    text-align : "center";
   	background-color:#F6F6F6; 
	}	
 </style>
</head>

<body>
<form method="post" action="registerPro.jsp">

<table border="0" width="800" height="650">
<tr><td colspan="2"><font size="7" face="맑은고딕"><b> 회원가입 </b></font></td></tr>

<tr><td class="col" width="200">아이디</td>
<td><input type="text" name="ID"> <input type="button" value="중복확인"></td>
</tr>

<tr><td class="col">비밀번호</td>
<td><input type="text" name="PW"></td>
</tr>

<tr><td class="col">비밀번호 확인</td>
<td><input type="text" name="PWC"></td>
</tr>

<tr><td class="col">이름</td>
<td><input type="text" name="name"></td>
</tr>

<tr><td class="col">별명</td>
<td><input type="text" name="nickname"></td>
</tr>

<tr><td class="col">E-mail</td>
<td><input type="text" name="E-mail"> @ <input type="text" name="E-mail"></td>
</tr>

<tr><td class="col">생일</td>
<td><input type="text" name="birthY" size="4"> 년 <input type="text" name="birthM" size="4"> 월 <input type="text" name="birthD" size="4"> 일 
</td></tr>
<tr>
<td class="col">성별</td>
<td><input type="radio" name="sex">남<input type="radio" name="sex">여</td>
</tr>

<tr><td class="col">전화번호</td>
<td> <select name="ph">
	<option value="">-선택-</option>
	<option value="02">02</option>
	<option value="032">032</option>
	<option value="042">042</option>
	</select>
-<input type="text" size="4" name="ph">-<input type="text" size="4" name="ph"></td>
</tr>

<tr><td class="col">핸드폰번호</td>
<td><select name="hp">
	<option value="">-선택-</option>
	<option value="010">010</option>
	<option value="011">011</option>
	</select>
-<input type="text" size="4" name="hp">-<input type="text" size="4" name="hp"></td>
</tr>

<tr><td class="col">주소</td>
<td>
<input type="text" size="3" >-<input type="text" size="3" >&nbsp<input type="button" value="우편번호"><br />
<input type="text" size="70" ><br /><input type="text" size="70" >(동이하 주소 입력)
</td></tr>

<tr><td class="col">관심분야</td>
<td><input type="checkbox" name="interest">java <input type="checkbox" name="interest">jsp <input type="checkbox" name="interest">frame <input type="checkbox" name="interest">css <input type="radio" name="interest">oracle</td>
</tr>

<tr><td class="col">메일알림서비스 및 SMS 수신</td>
<td><input type="checkbox" name="alram" value="aa" />메일알림 서비스를 받겠습니다.<br />
	<input type="checkbox" name="alram" value="aa" />SMS를 수신하겠습니다.
</td></tr>

<tr><td class="col">가입인사</td>
<td><textarea style="width:600px; height:50px;"></textarea>
</td></tr>

<tr><td colspan="2" align="center"><input type="button" value="취소"> &nbsp <input type="button" value="회원가입"></font></td></tr>

</table>
</form>

</body>
</html>

