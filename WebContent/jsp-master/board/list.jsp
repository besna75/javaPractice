<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="team5.board.BoardDBBean"%>
<%@ page import="team5.board.BoardDataBean"%>
<%@ page import="team5.member.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/view/color.jsp"%>

<%!
	int pageSize = 10; // 한 페이지의 글 목록 갯수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 날짜 형식 "2014-02-26 09:34"%>

<%
	String pageNum = request.getParameter("pageNum"); // "페이지 넘버"를 불러온다.
	if (pageNum == null) { // 넘어오는 페이지 넘버가 없다면
		pageNum = "1"; // 페이지 넘버는 1
	}

	int currentPage = Integer.parseInt(pageNum); // "페이지 넘버"를 현재 페이지 넘버로.
	int startRow = (currentPage - 1) * pageSize + 1; // currentPage가 1이면 1번글에서 시작, 2이면 11번글에서 시작. pageSize에 따라 값이 바뀐다.
	int endRow = currentPage * pageSize; // currentPage가 1이면 10번글이 끝. 2이면 20번글이 끝.
	int count = 0; // 글의 총 갯수
	int number = 0; // 

	List articleList = null; // 한 번에 로드되는 글 목록
	BoardDBBean dbPro = BoardDBBean.getInstance(); // BoardDBBean(DAO)의 인스턴스를 불러온다.
	count = dbPro.getArticleCount(); // getArticleCount()는 글의 총 갯수를 반환한다.
	if (count > 0) { // 글이 있다면(count > 0 이라면)
		articleList = dbPro.getArticles(startRow, endRow); // articleList List에 getArticle()로 ArrayList를 추가한다.
	}

	number = count - (currentPage - 1) * pageSize; // 글 번호. 글 갯수가 11 : 페이지 1일때 10, 페이지2일때 1
	
	// 로그인 여부 체크
	boolean logged = false;
	if (session.getAttribute("memId") != null) {
		logged = true;
	};
	
	// 관리자 여부 체크
	String id = (String)session.getAttribute("memId");
	LogonDBBean manager = LogonDBBean.getInstance();
	boolean isAdmin = manager.isAdmin(id);
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
	<center>
		<%=id %>님 환영합니다. <br />
		<b>글목록(전체 글:<%=count%>)</b>
		<table width="700">
			<tr>
				<td align="right" bgcolor="<%=value_c%>">
					<%
						if (logged) { // 로그인 이면
					%>
						<a href="writeForm.jsp">글쓰기</a>
						<a href="../member/logout.jsp">로그아웃</a>
					<%
						} else { // 아니면
					%>
						<!-- nothing -->
					<%
						}
					%>					
			</td>				
		</table>

		<%
			if (count == 0) { // 글이 없다면
		%>
		
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
			</tr>
		</table>

		<%
			} else { // 글이 있다면
		%>
		
		<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
				<td align="center" width="100">IP</td>
			</tr>
			
			<%			
				/* arcticleList는 한 번에 로드되는 글 목록  */
				for (int i = 0; i < articleList.size(); i++) {
						BoardDataBean article = (BoardDataBean)articleList.get(i);
			%>
			
			<tr height="30">
				<td align="center" width="50"><%=number--%></td><!-- number : 글 번호 -->
				<td width="250">
					<%
						int wid = 0;
						if (article.getRe_level() > 0) {
							wid = 5 * (article.getRe_level());
					%>	<img src="images/level.gif" width="<%=wid%>" height="16">
						<img src="images/re.gif">
					<%
						} else {
					%>	<img src="images/level.gif" width="<%=wid%>" height="16">
					<%	}
					%>
					
						<% if (isAdmin) { // 관리자 이면 바로 글읽기	
						%>						
							<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
						<% } else { // 아니면 비밀번호 프롬트
						%>
							<a href="passForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
						<% }
						%>
					<%
						if (article.getReadcount() >= 20) {
					%>	<img src="images/hot.gif" border="0" height="16">
					<%	}
					%>
				</td>
				<td align="center" width="100"><a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>
				<td align="center" width="150"><%=sdf.format(article.getReg_date())%></td>
				<td align="center" width="50"><%=article.getReadcount()%></td>
				<td align="center" width="100"><%=article.getIp()%></td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			}
		%>

		<%
			/*
				int count : 글의 총 갯수
				int pageSize : 한 페이지의 글 목록 갯수
				int currentPage : 현 페이지 넘버
			*/
			if (count > 0) {
				/*	
					int pageCount : 
					글의 총 갯수가 pageSize로 나눠떨어지면 그대로 pageCount 아니면 +1. 101개의 글은 11개의 페이지가 필요하다.
				*/
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				/*
					int startPage :
					
				*/
				int startPage = (int) (currentPage / 10) * 10 + 1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount)
					endPage = pageCount;

				if (startPage > 10) {
		%>
		<a href="list.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
		<%
			}
				for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<%
			}
				if (endPage < pageCount) {
		%>
		<a href="list.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
		<%
			}
		}
		%>
		<br /> <a href="../member/main.jsp">메인으로</a>
	</center>
</body>
</html>