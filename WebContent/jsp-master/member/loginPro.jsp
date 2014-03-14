<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "team5.member.LogonDBBean" %>

<% request.setCharacterEncoding("euc-kr");%>

<%
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");
	
	LogonDBBean manager = LogonDBBean.getInstance();
    int check= manager.userCheck(id,passwd);

	if(check==1){ // 로그인 성공시		
		// 쿠키 생성
	    Cookie cooId = new Cookie("cooId", id);
	    Cookie cooPasswd = new Cookie("cooPasswd", passwd);
	    	
    	// 쿠키의 유효기간 설정
    	cooId.setMaxAge(6000); // 초단위
    	cooPasswd.setMaxAge(6000);
    	
    	// 응답.만든 쿠키를 클라이언트에게 준다.
    	response.addCookie(cooId);
    	response.addCookie(cooPasswd);
		
    	// 속성 설정
		session.setAttribute("memId",id);
		response.sendRedirect("main.jsp");
	}else if(check==0){%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%	}else{ %>
	<script>
	  alert("아이디가 맞지 않습니다..");
	  history.go(-1);
	</script>
<%}	%>	