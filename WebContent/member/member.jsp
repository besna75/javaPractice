<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="ch11.logon.*"%>
<%@ page import="board.*"%>
<h2> 가입된 회원검색</h2>
<%	
	/* 로그인 및 회원등급 체크 */
	String id = (String) session.getAttribute("memId"); //session이므로 별도의 requset 없이 사용 
	LogonDBBean manager = LogonDBBean.getInstance(); //DAO의 메소드 사용을 위한 인스턴스 생성
	LogonDataBean c = manager.getMember(id); // 로그인 되어 있는 사용자 정보 담기  		
	String grade =""; // 지역 변수는 초기화 해야된다.
	
	List<LogonDataBean> list = null;
	
	if (session.getAttribute("memId") != null) { 		
		grade = c.getGrade(); // 회원등급확인
		
		if (grade.equals("admin")) {			
			list = manager.getMember();
			for (LogonDataBean dto : list) {%>
					<%=dto.getId()%>
					<%=dto.getName()%>
					<%=dto.getReg_date()%>
					<br />
			<%}%>
			<%} else {%> <!-- nothing --><%}%>
	<%}%>

	
	
