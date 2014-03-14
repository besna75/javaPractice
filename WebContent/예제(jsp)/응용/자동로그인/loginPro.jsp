<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "db.LogonDBBean" %>

<% request.setCharacterEncoding("euc-kr");%>

<%
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");
	String auto = request.getParameter("auto");
	if(auto==null)
		 auto = "0";
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c: cookies){
			if(c.getName().equals("AuthSid")) auto = c.getValue();
			if(c.getName().equals("AuthId")) id = c.getValue();
			if(c.getName().equals("AuthPw")) passwd = c.getValue();
		}
	}
	LogonDBBean manager = LogonDBBean.getInstance();
    int check= manager.userCheck(id,passwd);
    
    out.println("id : ["+id+"]");
    out.println("pw : ["+passwd+"]");
    out.println("check : ["+check+"]");

	if(check==1){
		if(auto.equals("1")){
			Cookie c0 = new Cookie("AuthSid", auto);
			Cookie c1 = new Cookie("AuthId", id);
			Cookie c2 = new Cookie("AuthPw", passwd);
			c0.setMaxAge(60*60*24*7);
			c1.setMaxAge(60*60*24*7);
			c2.setMaxAge(60*60*24*7);
			response.addCookie(c0);
			response.addCookie(c1);
			response.addCookie(c2);
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