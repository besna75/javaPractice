<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ch11.logon.*"%>
<%@ page import="board.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/view/color.jsp"%>



<%! /* 선언문(Declaration) */
    int pageSize = 10; // 한 페이지의 글 목록수 지정
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // SimpleDateFormat 클래스 사용한 작성일시 객체생성  
%>

<% /*스크립트릿(Scriptlet) 페이지번호 만들기 */
    String pageNum = request.getParameter("pageNum"); // pageNum값 요청하여 받기
    
    if (pageNum == null) { // 초기 화면 받는값 없음
        pageNum = "1"; // 시작페이지 번호 1 설정
    }

    int currentPage = Integer.parseInt(pageNum); //pageNum을 현재페이지(currentPage)로 선언, pageNum 형변환(DTO로 받을 때 String로 값을 받았기 때문에 형변환을 필요)
    int startRow = (currentPage - 1) * pageSize + 1; // 시작글 행번호 = (시작페이지-1)*한페이지의 글수 + 1  [currentPage가 1이면 1번글에서 시작, 2이면 11번 글에서 시작과 같이 시작]
    int endRow = currentPage * pageSize; // 마지막글 행번호 = 시작페이지*한페이지의 글수 [currentPage가 1이면 10번글이 끝. 2이면 20번글이 끝]
    int count = 0; // 데이터베이스 저장글의 총갯수
    int number = 0; // 행번호
    
    BoardDBBean dbPro = BoardDBBean.getInstance(); // BoardDBBean(DAO) 사용을 위한 인스턴스 생성
    count = dbPro.getArticleCount(); //DAO의 getArticleCount() 메소드를 사용하여 데이터베이스 내 저장글의 총 갯수 가져오기
    List articleList = null; //현재 페이지에 보여줄 list를 선언 (한 번에 로드되는 글 목록)
    if (count > 0) {  
        articleList = dbPro.getArticles(startRow, endRow); // 확인할 페이지의 범위
       // getArticles(startRow, endRow) => startRow와 endRow사이의 글들의 list에 그룹화하는 메소드             
    }    

   		number = count-(currentPage-1)*pageSize; // 여기의 number은 목록의 행번호임 (글번호와 혼동하지 않도록!!)
   //number= 총글 갯수-(현재페이지-1)*한페이지에 보여주는 글의 행수 (즉 넘버는 보여주는 페이지에서의 숫자화시킨것중  가장 큰 숫자가 된다.)   
   
  		String id = (String)session.getAttribute("memId"); //session이므로 별도의 requset 없이 사용 
 	 	LogonDBBean manager = LogonDBBean.getInstance(); //DAO의 메소드 사용을 위한 인스턴스 생성
 	 	LogonDataBean c = manager.getMember(id); // 로그인 되어 있는 사용자 정보 담기  		
 	 	String grade =""; // 지역 변수는 초기화 해야된다.
 	 	
 		boolean logged = false; 
		if (session.getAttribute("memId") != null) {
			logged = true;
			grade = c.getGrade();	//지역변수
		}
		
%>

<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<b>글목록(전체 글:<%=count%>)
</b>

<!-- 로그인 여부에 따른 글쓰기와 로그아웃 연동 -->
<table width="700">
	<tr>
	<%
	if (logged) { // 로그인 상태면
	%>
		<td><%=id%> <%=grade%>님 접속중</td>
		<td align="right" bgcolor="<%=value_c%>">
			<a href="writeForm.jsp">글쓰기</a> <a href="../member/logout.jsp">로그아웃</a>
		</td> 
	<%
 	} else {// 로그인상태 아니면
 	%> <td>guest 접속중</td>
		<td align="right" bgcolor="<%=value_c%>">글쓰기 로그아웃 기능 사용불가
		</td>
	<%
		}
	%>
	</tr>
</table>

<!-- 글목록 불러오기 -->
<%
	if (count == 0) { //글이 없다면 (0일 경우 저장글 없음)
%>
<table border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">게시판에 저장된 글이 없습니다.</td>
	</tr>
</table>

<%
	} else { //글 있다면
%>
<table border="1" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c%>">
		<td align="center" width="50">번 호</td>
		<td align="center" width="250">제 목</td>
		<td align="center" width="100">작성자</td>
		<td align="center" width="150">작성일</td>
		<td align="center" width="50">조 회</td>
		<td align="center" width="100">IP</td>
	</tr>
	<%
		/* 글의 우선순위(Re_level) 설정하기 ※ arcticleList는 한 번에 로드되는 글 목록 */
		for (int i = 0; i < articleList.size(); i++) { //articleList의 갯수만큼 반복
			BoardDataBean article = (BoardDataBean) articleList.get(i); //DAO의 List getArticles() 메소드에서 articleList = new ArrayList(end);로 변환하였던 것을 원래 타입으로 다시 만듬]
	%>
	<tr height="30">
		<td align="center" width="50"><%=number--%></td>
		<!-- number : 글의 행번호 -->
		<td width="250">
		<%	// 답글공백 설정하기
			int wid = 0; //공백을 인트화

			if (article.getRe_level() > 0) { // DTO에서 글의 레벨을 뽑아오는 메소드(getRe_level = 글의 우선순위)를 가져와서 사용함. level이 0보다 크면 
				wid = 5 * (article.getRe_level()); //레벨만큼의 공백을 늘리고, 답글이라고 표시하는 이미지삽입
		%> 
				<img src="images/level.gif" width="<%=wid%>" height="16"> <img src="images/re.gif"> <%
 		} else {
 		%>
 				<img src="images/level.gif" width="<%=wid%>" height="16">
		<%
 		}
		 %> 
 		<!-- 글제목 클릭하여 글내용 보기  
			﻿ 1. 회원등급에 따른 글읽기 설정
			 	1-1)관리자 글읽기
					글목록의 num값과 pageNum값을 content 파일로 전송함 
					a태그로 데이터값 전송 (아이디 중복체크에서  url+id값으로 데이터 전송하던 것과 비교 이해)
					DTO에서 가져온 제목과  a링크를 사용하여, 다른화면(content.jsp)에  pageNum과 현재 페이지를 주소줄에 추가 전달 
				1-2)일반유저 글읽기
					비밀번호 확인창으로 이동 -->
				
	<% 	/* 회원등급에 따른 글읽기 설정 */
 		if (grade.equals("admin")) {// 관리자면 바로 글읽기
	 %> 
 			<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"> <%=article.getSubject()%></a> 
	<%
 		} else {// 일반유저면 비밀번호 위치로 프롬프트 이동
 	%>
 			<a href="pwch.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">	<%=article.getSubject()%></a>
	<%
 	}
	 %> 
 
 
 
	 <!-- 레코드 정보 가져오기	
				 1. 조회수가 높을 것을 hot 표시하기  
				 2. 데이터(제목,작성자 및 이메일,작성일,조회수,Ip 가져와서 보여주기 	 -->
	<%
	 	if (article.getReadcount() >= 20) { //조회수 가져오기
	 %> 
	 		<img src="images/hot.gif" border="0" height="16"> <!-- 조회수가 20회 이상이면 hot.gif 이미지 표시 -->
	<%
	}
	%>
		</td>
		<td align="center" width="100">
			<a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a> <!--작성자 아이디에 이메일 a링크함--></td>
		<td align="center" width="150"><%=sdf.format(article.getReg_date())%></td> <!--작성일 조회수 와 작성자 ip를 DTO에서 꺼내와서 넣어줌-->		
		<td align="center" width="50"><%=article.getReadcount()%></td>
		<td align="center" width="100"><%=article.getIp()%></td>
	</tr>
	<%
		} // for구문 완료
	%>
</table>

<%
	} //글이 있다면(else구문) 완료
%>

<%
	/* 페이지 이전 다음 만들기 
	int count : 글의 총 갯수
	int pageSize : 한 페이지의 글 목록 갯수
	int currentPage : 현 페이지 넘버 */

	if (count > 0) {
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		/* 한페이지수 = 전체글수/한페이지에 들어갈 글수 + (전체글수%한페이지에들어갈 글 수가 0인가 확인)
		 pageCount는 즉 전체글을 사이즈로 나누고 + 전체글%사이즈로 딱 떨어지면 0 안떨어지면 1을 더한다
		  즉 100개의 글이 있고 한페이지에 보여주는 글이 10개라면, 페이지수(pageCount)는 10이된다 */
		int startPage = (int) (currentPage / 10) * 10 + 1; // (현재화면/10)*10+1 → 나머지값을 버리는 / 	
		// 현재 페이지가 1~10사이면 시작되는 값은 1  	
		// 2~20사이면 시작되는값은 11 즉 아래 표시되는 페이지 숫자의 시작값
		int pageBlock = 10; //게시판 하단 페이지수를 10개 단위로 인트화 (예. [다음] 9 8 7 6 5 4 3 2 1 [이전])
		int endPage = startPage + pageBlock - 1; //startPage를 이용한 endPage 설정 (pageBlock를 10단위로 하였으므로, 시작과 끝의 차이는 10)
		/* endPage 재설정 */
		if (endPage > pageCount)
			endPage = pageCount;

		if (startPage > 10) { /* 시작페이지>10 이상일 경우→  [이전] 버튼에 a링크를 활용하여 list로 정보전송 */
%>
			<a href="list.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
<%
		}
		for (int i = startPage; i <= endPage; i++) { //for문을 통해 startPage와 endPage 사이만큼 반복.[i]페이지를 a링크를 통해 클릭시 list.jsp로 pagenum을 보내준다.
%>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%
		}
		/* 끝페이지가 페이지수보다 적을 경우→ [다음] 버튼에 a링크를 활용하여 list로 정보전송 */
		if (endPage < pageCount) { // 즉 글이 많고 더 표시해야할 글이 많을때 [다음] 으로 a링크를 걸어준다
%>
			<a href="list.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
<%
		}
	}
%>

</center>
</body>
</html>
