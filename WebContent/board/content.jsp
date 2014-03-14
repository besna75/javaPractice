<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "board.*" %>
<%@ page import = "ch11.logon.*"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   /* 로그인 및 회원등급 체크 */   		
	String id = (String)session.getAttribute("memId"); //session이므로 별도의 requset 없이 사용 
 	LogonDBBean manager = LogonDBBean.getInstance(); //DAO의 메소드 사용을 위한 인스턴스 생성
 	LogonDataBean c = manager.getMember(id); // 로그인 되어 있는 사용자 정보 담기  		
 	String grade =""; // 지역 변수는 초기화 해야된다.
 	
	boolean logged = false; 
	if (session.getAttribute("memId") != null) {
		logged = true;
		grade = c.getGrade();	//지역변수
	}

   try{
      BoardDBBean dbPro = BoardDBBean.getInstance();
      BoardDataBean article = dbPro.getArticle(num); //글번호를 변수로 하여 글 불러오기
  
	  int ref=article.getRef();
	  int re_step=article.getRe_step();
	  int re_level=article.getRe_level();
%>
<body bgcolor="<%=bodyback_c%>">  
<center><b>글내용 보기</b>
<!-- 로그인 여부 표시 -->
<table width="700">
	<tr>
	<%
	if (logged) { // 로그인 상태면
		if (grade.equals("admin")) {
		%>
			<td><%=id%> <%=grade%>님 접속중 <br /> 글내용보기</td>
		<%}else if(grade.equals("grade1")){%>
			<td><%=id%> <%=grade%>님 접속중 <br /> 우수회원(grade1) 글내용보기</td>
			
		<%}else if(grade.equals("grade2")){%>
		<td><%=id%> <%=grade%>님 접속중 <br /> 준회원(grade2)글내용보기</td>		
		
	<%}else {// 로그인상태 아니면
 	%> <td>guest 접속중 <br /> 글내용을 보려면 비밀번호를 확인해주세요.</td>
	<%
		}
	%>
	</tr>
</table>

<form>
<table width="500" border="1" cellspacing="0" cellpadding="0"  bgcolor="<%=bodyback_c%>" align="center">  
  <tr height="30">
    <td align="center" width="125" bgcolor="<%=value_c%>">글번호</td>
    <td align="center" width="125" align="center"><%=article.getNum()%></td>
    <td align="center" width="125" bgcolor="<%=value_c%>">조회수</td>
    <td align="center" width="125" align="center"><%=article.getReadcount()%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="<%=value_c%>">작성자</td>
    <td align="center" width="125" align="center"><%=article.getWriter()%></td>
    <td align="center" width="125" bgcolor="<%=value_c%>">작성일</td>
    <td align="center" width="125" align="center"><%= sdf.format(article.getReg_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="<%=value_c%>">글제목</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=article.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125" bgcolor="<%=value_c%>">글내용</td>
    <td align="left" width="375" colspan="3"><pre><%=article.getContent()%></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" bgcolor="<%=value_c%>" align="right" > 
    <%if(logged){ /* 로그인 상태이면 글수정 글삭제 버튼 활성화 */%> 
  		<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
 		<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp; 
	<%    	if(grade.equals("admin")){ /* 관리자이면 답글쓰기 활성화 */%>
			<input type="button" value="답글쓰기" onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	<%		}else{/* 관리자 아니면 답글쓰기 없음 */ %>
	<%		} %>
    <%}else {// 로그인상태 아니면 글목록(읽기)만 가능%><!-- nothing -->   	
   <% }   
    } %>
       <input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
    </td>
  </tr>
</table>    
<%}catch(Exception e){
	e.printStackTrace();	
} %>
</form>      
</body>
</html>      
