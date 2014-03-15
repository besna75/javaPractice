<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>

<%!
    int pageRow = 10;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageRow + 1;
    int endRow = currentPage * pageRow;
    int count = 0;
    int number=0;

    List articleList = null;
    BoardDBBean dbPro = BoardDBBean.getInstance();
    String id = (String)session.getAttribute("memId");
    count = dbPro.getMyArticleCount(id);
    if (count > 0) {
articleList = dbPro.getMyArticles(startRow, endRow,id);
    }

	number=count-(currentPage-1)*pageRow;
%>
<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
<center><b>�۸��(��ü ��:<%=count%>)</b>
<% if(session.getAttribute("memId") != null){ %>
<table width="700">
<tr>
    <td align="right" bgcolor="<%=value_c%>">
    <a href="writeForm.jsp">�۾���</a>
    </td>
</table>
<%} %>
<%
    if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    �Խ��ǿ� ����� ���� �����ϴ�.
    </td>
</table>

<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <td align="center"  width="50"  >�� ȣ</td> 
      <td align="center"  width="250" >��   ��</td> 
      <td align="center"  width="100" >�ۼ���</td>
      <td align="center"  width="150" >�ۼ���</td> 
      <td align="center"  width="50" >�� ȸ</td> 
      <td align="center"  width="100" >IP</td>    
    </tr>
<%  
        for (int i = 0 ; i < articleList.size() ; i++) {
          BoardDataBean article = (BoardDataBean)articleList.get(i);
%>
   <tr height="30">
    <td align="center"  width="50" > <%=number--%></td>
    <td  width="250" >
	<%
	      int wid=0; 
	      if(article.getRe_level()>0){
	        wid=20*(article.getRe_level());
	%>
	  <img src="images/level.gif" width="<%=wid%>" height="16">
	  <img src="images/re.gif">
	<%}else{%>
	  <img src="images/level.gif" width="<%=wid%>" height="16">
	<%}%>
           
      <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           <%=article.getSubject()%></a> 
          <% if(article.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td align="center"  width="100"> 
       <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>
    <td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
    <td align="center"  width="50"><%=article.getReadcount()%></td>
    <td align="center" width="100" ><%=article.getIp()%></td>
  </tr>
     <%}%>
</table>
<%}%>

<%
    if (count > 0) {
        int pageCount = count / pageRow + ( count % pageRow == 0 ? 0 : 1);
		 
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="mylist.jsp?pageNum=<%= startPage - 10 %>">[����]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="mylist.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="mylist.jsp?pageNum=<%= startPage + 10 %>">[����]</a>
<%
        }
    }
%>
</center>
</body>
</html>