<%@ page contentType="text/html; charset=EUC-KR"%>
<!-- 1. 해당 DB import 해오기 -->
<%@ page import="test.db.*"%>

    <% 
    /* 2.DB의 id,pw의 확인 */    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    /* 3.dao를 통한 로그인 정보 비교 확인 */
    DAO dao = DAO.getInstance();
    boolean result = dao.loginCh(id,pw);
    if(result){
    	session.setAttribute("sessionId", id);
    	session.setAttribute("sessionPw", pw);
    	out.println("로그인 완료!!");
    }else{
    	out.println("id와 pw를 확인해주세요!!");
    }
    %>
    
    
<%--  주석 시작
    <% /* cookie */
    /* 1.DB의 id,pw의 확인 */    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    /* 2. Cookie 생성 */
    Cookie coo1 = new Cookie("cooId",id); //("쿠키명", 쿠키값)
    Cookie coo2 = new Cookie("cooPw",pw);
    /* 3. 쿠키의 유효기간 설정 */
    coo1.setMaxAge(60); //(60*60*24) = 60초*60분*24하루
    coo2.setMaxAge(10); // (10) = 10초
    /* 4. 쿠키를 클라이언트에게 주기 */
    response.addCookie(coo1);
    response.addCookie(coo2);
    out.println("쿠키 생성완료!!");
    %> 
    
    <% /* session */
    /* 1.DB의 id,pw의 확인 */    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    /* 2. session 전송 */
    session.setAttribute("sessionId", id); // IP 정보의 자동기록
    session.setAttribute("sessionPw", pw);
    out.println("세션 생성완료.!!");
    %>    
주석 끝--%>