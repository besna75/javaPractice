<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>

<%!
    int pageSize = 10; //한 화면에 표현되는 글의 수를 지정
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm"); //시간을 좀더 잘 표현하기위해 simpledatefomat클래스 사용해서 객체를 생성함
%>

<%
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    } //list.jsp로 넘어오는 pageNum 값을 받는 부분으로 pageNum값이 없으면 기본값을 1로 지정하는 부분

    int currentPage = Integer.parseInt(pageNum);  //currentPage는 현재 보여주는 페이지를 뜻한다. string 이기에 형변환 하는부분 파라미터로 넘어오는 부분이 모두 string이기 때문이다.
    int startRow = (currentPage - 1) * pageSize + 1; //startRow는 현페이지 글목록에 표시할 시작글 번호를 설정하는 부분이다. startRow는 시작글 번호 
    int endRow = currentPage * pageSize; //endRow는 마지막 글번호
    int count = 0; //데이터베이스안에 저장되어있는 글의 총갯수를 표현하기위해  int선언함
    int number=0;

    List articleList = null; //현제 페이지에 보여줄 list를 선언하고있는 부분
    BoardDBBean dbPro = BoardDBBean.getInstance(); //싱글 인스터스 방식을 이용해서 DAO객체를 생성하는 부분
    count = dbPro.getArticleCount();  //DAO를 이용 데이터베이스 안에 저장되어있는 글의 총 갯수를 "select count(*) from board" 통해 넘겨주고이있다.
    if (count > 0) { //만약 글이 한개 이상이라도 있다면
        articleList = dbPro.getArticles(startRow, endRow); //  startRow와 endRow사이의 글들의 list에 묶여져있는걸 불러와서 list에 저장하는 부분
    } 

	number=count-(currentPage-1)*pageSize; //number= 총글 갯수-(보여주는 페이지-1)*한페이지에 보여주는 글 즉 넘버는 보여주는 페이지에서의 숫자화시킨것중  가장 큰 숫자가 된다.
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
<center><b>글목록(전체 글:<%=count%>)</b><!-- count는 전체글! DAO메소드를 통해서  28라인에서 불러오고있다.-->  
<table width="700">
<tr>
    <td align="right" bgcolor="<%=value_c%>">
    <a href="writeForm.jsp">글쓰기</a> <!--글쓰기로 넘어가는 a링크  -->
    </td>
</table>

<%
    if (count == 0) {  //저장되어있는 글이 없으면!!
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {    //저장되어있는 글이 있다면 %> 
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조 회</td> 
      <td align="center"  width="100" >IP</td>    
    </tr> <!--상단의 부분  -->
<%  
        for (int i = 0 ; i < articleList.size() ; i++) { //list안에 있는 갯수만큼 반복하라~
          BoardDataBean article = (BoardDataBean)articleList.get(i); //리스트에 있는 DTO를 하나씩 꺼내는 부분
%>
   <tr height="30">
    <td align="center"  width="50" > <%=number-- // 보여주는 페이지에서의 숫자화시킨것중  가장 큰 숫자중 하나씩 감소하면서%></td>
    <td  width="250" >
	<%
	      int wid=0; //공백을 인트화
	      if(article.getRe_level()>0){ //가져오는 DTO에서 글의 레벨을 뽑아오는 메소드를 이용 level이 0보다 크면 
	        wid=5*(article.getRe_level()); //레벨만큼의 공백을 늘리고있다.
	%>
	  <img src="images/level.gif" width="<%=wid%>" height="16">
	  <img src="images/re.gif"> <!--답글이라고 표시하는 이미지삽입 -->
	<%}else{%>
	  <img src="images/level.gif" width="<%=wid%>" height="16"> 
	<%}%>
           
      <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"> 
           <%=article.getSubject()%></a> <!--이부분이 중요한데 DTO에서 가져온 제목에다가  a링크로 content.jsp로 글 넘버랑 현재 페이지를 주소줄에 추가해서 넘겨주는 방식으로 전달하고있다-->
          <% if(article.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td align="center"  width="100"> <!--20번 이상 클릭된 글일시 반짝반짝 빛나는 HOT이미지 삽입-->
       <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td><!--작성자 아이디에 이메일 a링크함-->
    <td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
    <td align="center"  width="50"><%=article.getReadcount()%></td>
    <td align="center" width="100" ><%=article.getIp()%></td> <!--작성일 조회수 와 작성자 ip를 DTO에서 꺼내와서 넣어줌-->
  </tr>
     <%} //드디어 for문 끝남%>
</table>
<%} //드디어 글이 있다면!!이 끝남%>

<%
    if (count > 0) {  //저장되어있는  글이 있다면~ 이제 보여줄거 다보여주고 아래 링크하는 부분의 계산을 위해서
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 //페이지 카운트는 즉 전체글을 사이즈로 나누고 + 전체글%사이즈로 딱 떨어지면 0 안떨어지면 1을 더한다 즉 100개의 글이 있고 한페이지에 보여주는 글이 10개라면 값은 10이된다 즉 거의 책 목차? 랑 비슷하다.
        int startPage = (int)(currentPage/10)*10+1; //현재 페이지가 1~10사이면 시작되는 값은 1 2~20사이면 시작되는값은 11 즉 아래 표시되는 페이지 숫자의 시작값
		int pageBlock=10; //아래 표시되는 숫자의 갯수를 인트화
        int endPage = startPage + pageBlock-1; //스타트페이지를 이용 엔드페이지를 설정하고있다. 블락수를 10개단위로 끊으니 시작과 끝의 차이는 10
        if (endPage > pageCount) endPage = pageCount; //더이상 표현할 즉 목차가 7개인데 엔드페이지가 10이면 8,9페이지를 보여줄수 없으니 7페이지까지 표시하려고 엔드페이지 재설정
        
        if (startPage > 10) {    %>
        <a href="list.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      //11부터 시작하는 부분이면 [이전]을 a링크 이용 list로 넘겨주는 부분 a링크로 pagenum=스타트페이지-10으로 넘겨준다}
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%		//for문을 통해 스타트 페이지와 엔드페이지의 사이만큼 반복해서 [i]페이지를 a링크를 통해 클릭시 list.jsp로 pagenum을 보내준다.
        }
        if (endPage < pageCount) {  %>
        <a href="list.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%      //목차가 페이지 카운터보다 많으면 즉 글이 많고 더 표시해야할 글이 많을때 [다음] 으로 a링크를 걸어준다 list로  페이지넘버=스타트페이지+10을
        }
    }
%>
</center>
</body>
</html>