<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "board.*" %>
<%@ page import = "ch11.logon.*"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   /* �α��� �� ȸ����� üũ */   		
	String id = (String)session.getAttribute("memId"); //session�̹Ƿ� ������ requset ���� ��� 
 	LogonDBBean manager = LogonDBBean.getInstance(); //DAO�� �޼ҵ� ����� ���� �ν��Ͻ� ����
 	LogonDataBean c = manager.getMember(id); // �α��� �Ǿ� �ִ� ����� ���� ���  		
 	String grade =""; // ���� ������ �ʱ�ȭ �ؾߵȴ�.
 	
	boolean logged = false; 
	if (session.getAttribute("memId") != null) {
		logged = true;
		grade = c.getGrade();	//��������
	}

   try{
      BoardDBBean dbPro = BoardDBBean.getInstance();
      BoardDataBean article = dbPro.getArticle(num); //�۹�ȣ�� ������ �Ͽ� �� �ҷ�����
  
	  int ref=article.getRef();
	  int re_step=article.getRe_step();
	  int re_level=article.getRe_level();
%>
<body bgcolor="<%=bodyback_c%>">  
<center><b>�۳��� ����</b>
<!-- �α��� ���� ǥ�� -->
<table width="700">
	<tr>
	<%
	if (logged) { // �α��� ���¸�
		if (grade.equals("admin")) {
		%>
			<td><%=id%> <%=grade%>�� ������ <br /> �۳��뺸��</td>
		<%}else if(grade.equals("grade1")){%>
			<td><%=id%> <%=grade%>�� ������ <br /> ���ȸ��(grade1) �۳��뺸��</td>
			
		<%}else if(grade.equals("grade2")){%>
		<td><%=id%> <%=grade%>�� ������ <br /> ��ȸ��(grade2)�۳��뺸��</td>		
		
	<%}else {// �α��λ��� �ƴϸ�
 	%> <td>guest ������ <br /> �۳����� ������ ��й�ȣ�� Ȯ�����ּ���.</td>
	<%
		}
	%>
	</tr>
</table>

<form>
<table width="500" border="1" cellspacing="0" cellpadding="0"  bgcolor="<%=bodyback_c%>" align="center">  
  <tr height="30">
    <td align="center" width="125" bgcolor="<%=value_c%>">�۹�ȣ</td>
    <td align="center" width="125" align="center"><%=article.getNum()%></td>
    <td align="center" width="125" bgcolor="<%=value_c%>">��ȸ��</td>
    <td align="center" width="125" align="center"><%=article.getReadcount()%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="<%=value_c%>">�ۼ���</td>
    <td align="center" width="125" align="center"><%=article.getWriter()%></td>
    <td align="center" width="125" bgcolor="<%=value_c%>">�ۼ���</td>
    <td align="center" width="125" align="center"><%= sdf.format(article.getReg_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="<%=value_c%>">������</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=article.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125" bgcolor="<%=value_c%>">�۳���</td>
    <td align="left" width="375" colspan="3"><pre><%=article.getContent()%></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" bgcolor="<%=value_c%>" align="right" > 
    <%if(logged){ /* �α��� �����̸� �ۼ��� �ۻ��� ��ư Ȱ��ȭ */%> 
  		<input type="button" value="�ۼ���" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
 		<input type="button" value="�ۻ���" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp; 
	<%    	if(grade.equals("admin")){ /* �������̸� ��۾��� Ȱ��ȭ */%>
			<input type="button" value="��۾���" onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	<%		}else{/* ������ �ƴϸ� ��۾��� ���� */ %>
	<%		} %>
    <%}else {// �α��λ��� �ƴϸ� �۸��(�б�)�� ����%><!-- nothing -->   	
   <% }   
    } %>
       <input type="button" value="�۸��" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
    </td>
  </tr>
</table>    
<%}catch(Exception e){
	e.printStackTrace();	
} %>
</form>      
</body>
</html>      
