<% 
	Cookie [] coo = request.getCookies();
	for(Cookie c : coo){
	  if(c.getName().equals("cooId")){
		c.setMaxAge(0);
		response.addCookie(c);
	  }
	  if(c.getName().equals("cooPasswd")){
		c.setMaxAge(0);
		response.addCookie(c);
	  }
	  if(c.getName().equals("cooAuto")){
		c.setMaxAge(0);
		response.addCookie(c);
	  }
	}


	session.invalidate();
	response.sendRedirect("main.jsp");
	%>