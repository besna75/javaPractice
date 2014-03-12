
<%
	Cookie[] coo = request.getCookies();
	if (coo != null) {
		for (Cookie c : coo) { //쿠키의 제한시간 0로 하여 값 없애기
			if (c.getName().equals("cooId")||c.getName().equals("cooPw")||c.getName().equals("cooAuto")){
				c.setMaxAge(0);
			}
		}
	}
	session.invalidate();
	response.sendRedirect("main.jsp");
%>