<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="ch11.logon.*"%>

<% request.setCharacterEncoding("euc-kr");%>

<% 
	System.out.println("로그인 체크");
	/* Parameter 받기 */
    String id = request.getParameter("id"); //아이디
	String passwd  = request.getParameter("passwd"); //비밀번호
	String auto = request.getParameter("auto"); //자동 로그인
	/* main의 쿠키 체크 */
	if(auto==null)auto="0";		
	Cookie [] coo = request.getCookies(); //배열로 쿠키 받기
	for(Cookie d:coo){
		if(d.getName().equals("cooId")) id = d.getValue();
		if(d.getName().equals("cooPw")) passwd = d.getValue();
		if(d.getName().equals("cooAuto")) auto = d.getValue();					
	}

	/* DAO의 메소드 연결사용 */
	LogonDBBean manager = LogonDBBean.getInstance();
    int check= manager.userCheck(id,passwd);
    
	if(check==1){//main으로 세션과 정보 전송
			/* 쿠키 생성 */
			if(auto.equals("1")){//자동로그인값 받고, 쿠키생성하기
				//필요 쿠키 생성
				Cookie coo1 = new Cookie("cooId",id);
				Cookie coo2 = new Cookie("cooPw",passwd);
				Cookie coo3 = new Cookie("cooAuto",auto);
				//쿠키 제한시간 설정
				coo1.setMaxAge(60*60*24);
				coo2.setMaxAge(60*60*24);
				coo3.setMaxAge(60*60*24);
				//쿠키값 전송
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