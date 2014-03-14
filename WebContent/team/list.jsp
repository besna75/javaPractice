<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>

<%!
    int pageSize = 10; //�� ȭ�鿡 ǥ���Ǵ� ���� ���� ����
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm"); //�ð��� ���� �� ǥ���ϱ����� simpledatefomatŬ���� ����ؼ� ��ü�� ������
%>

<%
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    } //list.jsp�� �Ѿ���� pageNum ���� �޴� �κ����� pageNum���� ������ �⺻���� 1�� �����ϴ� �κ�

    int currentPage = Integer.parseInt(pageNum);  //currentPage�� ���� �����ִ� �������� ���Ѵ�. string �̱⿡ ����ȯ �ϴºκ� �Ķ���ͷ� �Ѿ���� �κ��� ��� string�̱� �����̴�.
    int startRow = (currentPage - 1) * pageSize + 1; //startRow�� �������� �۸�Ͽ� ǥ���� ���۱� ��ȣ�� �����ϴ� �κ��̴�. startRow�� ���۱� ��ȣ 
    int endRow = currentPage * pageSize; //endRow�� ������ �۹�ȣ
    int count = 0; //�����ͺ��̽��ȿ� ����Ǿ��ִ� ���� �Ѱ����� ǥ���ϱ�����  int������
    int number=0;

    List articleList = null; //���� �������� ������ list�� �����ϰ��ִ� �κ�
    BoardDBBean dbPro = BoardDBBean.getInstance(); //�̱� �ν��ͽ� ����� �̿��ؼ� DAO��ü�� �����ϴ� �κ�
    count = dbPro.getArticleCount();  //DAO�� �̿� �����ͺ��̽� �ȿ� ����Ǿ��ִ� ���� �� ������ "select count(*) from board" ���� �Ѱ��ְ����ִ�.
    if (count > 0) { //���� ���� �Ѱ� �̻��̶� �ִٸ�
        articleList = dbPro.getArticles(startRow, endRow); //  startRow�� endRow������ �۵��� list�� �������ִ°� �ҷ��ͼ� list�� �����ϴ� �κ�
    } 

	number=count-(currentPage-1)*pageSize; //number= �ѱ� ����-(�����ִ� ������-1)*���������� �����ִ� �� �� �ѹ��� �����ִ� ������������ ����ȭ��Ų����  ���� ū ���ڰ� �ȴ�.
%>
<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
<center><b>�۸��(��ü ��:<%=count%>)</b><!-- count�� ��ü��! DAO�޼ҵ带 ���ؼ�  28���ο��� �ҷ������ִ�.-->  
<table width="700">
<tr>
    <td align="right" bgcolor="<%=value_c%>">
    <a href="writeForm.jsp">�۾���</a> <!--�۾���� �Ѿ�� a��ũ  -->
    </td>
</table>

<%
    if (count == 0) {  //����Ǿ��ִ� ���� ������!!
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    �Խ��ǿ� ����� ���� �����ϴ�.
    </td>
</table>

<%  } else {    //����Ǿ��ִ� ���� �ִٸ� %> 
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <td align="center"  width="50"  >�� ȣ</td> 
      <td align="center"  width="250" >��   ��</td> 
      <td align="center"  width="100" >�ۼ���</td>
      <td align="center"  width="150" >�ۼ���</td> 
      <td align="center"  width="50" >�� ȸ</td> 
      <td align="center"  width="100" >IP</td>    
    </tr> <!--����� �κ�  -->
<%  
        for (int i = 0 ; i < articleList.size() ; i++) { //list�ȿ� �ִ� ������ŭ �ݺ��϶�~
          BoardDataBean article = (BoardDataBean)articleList.get(i); //����Ʈ�� �ִ� DTO�� �ϳ��� ������ �κ�
%>
   <tr height="30">
    <td align="center"  width="50" > <%=number-- // �����ִ� ������������ ����ȭ��Ų����  ���� ū ������ �ϳ��� �����ϸ鼭%></td>
    <td  width="250" >
	<%
	      int wid=0; //������ ��Ʈȭ
	      if(article.getRe_level()>0){ //�������� DTO���� ���� ������ �̾ƿ��� �޼ҵ带 �̿� level�� 0���� ũ�� 
	        wid=5*(article.getRe_level()); //������ŭ�� ������ �ø����ִ�.
	%>
	  <img src="images/level.gif" width="<%=wid%>" height="16">
	  <img src="images/re.gif"> <!--����̶�� ǥ���ϴ� �̹������� -->
	<%}else{%>
	  <img src="images/level.gif" width="<%=wid%>" height="16"> 
	<%}%>
           
      <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"> 
           <%=article.getSubject()%></a> <!--�̺κ��� �߿��ѵ� DTO���� ������ ���񿡴ٰ�  a��ũ�� content.jsp�� �� �ѹ��� ���� �������� �ּ��ٿ� �߰��ؼ� �Ѱ��ִ� ������� �����ϰ��ִ�-->
          <% if(article.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td align="center"  width="100"> <!--20�� �̻� Ŭ���� ���Ͻ� ��¦��¦ ������ HOT�̹��� ����-->
       <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td><!--�ۼ��� ���̵� �̸��� a��ũ��-->
    <td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
    <td align="center"  width="50"><%=article.getReadcount()%></td>
    <td align="center" width="100" ><%=article.getIp()%></td> <!--�ۼ��� ��ȸ�� �� �ۼ��� ip�� DTO���� �����ͼ� �־���-->
  </tr>
     <%} //���� for�� ����%>
</table>
<%} //���� ���� �ִٸ�!!�� ����%>

<%
    if (count > 0) {  //����Ǿ��ִ�  ���� �ִٸ�~ ���� �����ٰ� �ٺ����ְ� �Ʒ� ��ũ�ϴ� �κ��� ����� ���ؼ�
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 //������ ī��Ʈ�� �� ��ü���� ������� ������ + ��ü��%������� �� �������� 0 �ȶ������� 1�� ���Ѵ� �� 100���� ���� �ְ� ���������� �����ִ� ���� 10����� ���� 10�̵ȴ� �� ���� å ����? �� ����ϴ�.
        int startPage = (int)(currentPage/10)*10+1; //���� �������� 1~10���̸� ���۵Ǵ� ���� 1 2~20���̸� ���۵Ǵ°��� 11 �� �Ʒ� ǥ�õǴ� ������ ������ ���۰�
		int pageBlock=10; //�Ʒ� ǥ�õǴ� ������ ������ ��Ʈȭ
        int endPage = startPage + pageBlock-1; //��ŸƮ�������� �̿� ������������ �����ϰ��ִ�. ������� 10�������� ������ ���۰� ���� ���̴� 10
        if (endPage > pageCount) endPage = pageCount; //���̻� ǥ���� �� ������ 7���ε� ������������ 10�̸� 8,9�������� �����ټ� ������ 7���������� ǥ���Ϸ��� ���������� �缳��
        
        if (startPage > 10) {    %>
        <a href="list.jsp?pageNum=<%= startPage - 10 %>">[����]</a>
<%      //11���� �����ϴ� �κ��̸� [����]�� a��ũ �̿� list�� �Ѱ��ִ� �κ� a��ũ�� pagenum=��ŸƮ������-10���� �Ѱ��ش�}
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%		//for���� ���� ��ŸƮ �������� ������������ ���̸�ŭ �ݺ��ؼ� [i]�������� a��ũ�� ���� Ŭ���� list.jsp�� pagenum�� �����ش�.
        }
        if (endPage < pageCount) {  %>
        <a href="list.jsp?pageNum=<%= startPage + 10 %>">[����]</a>
<%      //������ ������ ī���ͺ��� ������ �� ���� ���� �� ǥ���ؾ��� ���� ������ [����] ���� a��ũ�� �ɾ��ش� list��  �������ѹ�=��ŸƮ������+10��
        }
    }
%>
</center>
</body>
</html>