<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("EUC-KR"); %>

<html>
<head>
	<title>������ ǥ����� ����</title>
</head>
<body>
<div class=d1>
<h2>������ ǥ����� ����</h2>
<table>
<thead><tr><td>ǥ����</th><td>��---!</th></tr></thead>
<tfoot><tr><td>ǥ����</td><td>---��</td></tr></tfoot>
<tbody>
<tr><td>\${2+5}</td><td>${2+5}</td></tr>
<tr><td>\${4/5}</td><td>${4/5}</td></tr>
<tr><td>\${4 div 5}</td><td>${4 div 5}</td></tr>
<tr><td>\${4 mod 5}</td><td>${4 mod 5}</td></tr>
<tr><td>\${4 < 5}</td><td>${4 < 5}</td></tr>
<tr><td>\${4 lt 5}</td><td>${4 lt 5}</td></tr>
<tr><td>\${4 > 5}</td><td>${4 > 5}</td></tr>
<tr><td>\${4 gt 5}</td><td>${4 gt 5}</td></tr>
<tr><td>\${4 <= 5}</td><td>${4 <= 5}</td></tr>
<tr><td>\${4 le 5}</td><td>${4 le 5}</td></tr>
<tr><td>\${4 >= 5}</td><td>${4 >= 5}</td></tr>
<tr><td>\${4 ge 5}</td><td>${4 ge 5}</td></tr>
<tr><td>\${(4 < 5 && 4 > 5) ? 4 : 5}</td><td>${(4 < 5 && 4 > 5) ? 4 : 5}</td></tr>
<tr><td>\${(4 < 5 || 4 > 5) ? 4 : 5}</td><td>${(4 < 5 || 4 > 5) ? 4 : 5}</td></tr>
<tr><td>\${header["host"]}</td><td>${header["host"]}</td></tr>
<tr><td>\${header['host']}</td><td>${header['host']}</td></tr>
<tr><td>\${header.host}</td><td>${header.host}</td></tr>
<tr><td>\${header["user-agent"]}</td><td>${header["user-agent"]}</td></tr>
</tbody>
</table>
</div class=d1>

</body>
</html>
