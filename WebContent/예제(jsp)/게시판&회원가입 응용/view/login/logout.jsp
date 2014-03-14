<% 
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c: cookies){
			if(c.getName().equals("AuthSid") || c.getName().equals("AuthId")||c.getName().equals("AuthPw")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
	}
	session.invalidate();
	response.sendRedirect("main.jsp");
%>