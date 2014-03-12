<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "ch11.logon.LogonDBBean" %>

<% request.setCharacterEncoding("euc-kr");%>

<%
	System.out.println("로그인 처리.");
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");
	String auto = request.getParameter("auto");
	Cookie [] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cooId"))
			  id = c.getValue();
		if(c.getName().equals("cooPasswd"))
			  passwd = c.getValue();
		if(c.getName().equals("cooAuto"))
			  auto = c.getValue();	  
	}
	
	LogonDBBean manager = LogonDBBean.getInstance();
    int check= manager.userCheck(id,passwd);

	if(check==1){
		if(auto != null){
			Cookie coo1 = new Cookie("cooId",id);
			Cookie coo2 = new Cookie("cooPasswd",passwd);
			Cookie coo3 = new Cookie("cooAuto",auto);
			coo1.setMaxAge(60*60*24);
			coo2.setMaxAge(60*60*24);
			coo3.setMaxAge(60*60*24);
			response.addCookie(coo1);
			response.addCookie(coo2);
			response.addCookie(coo3);
		}
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
