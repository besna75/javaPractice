<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="team5.member.*" %>
<%@ page import="java.util.ArrayList" %>

<%
	LogonDBBean dao = LogonDBBean.getInstance();
	ArrayList<LogonDataBean> list = dao.getMemberAll();
	for(LogonDataBean dto : list){
%>
	<%=dto.getId() %>
	<%=dto.getPasswd() %>
	<%=dto.getName() %>
	<%=dto.getJumin1() %>
	<%=dto.getJumin2() %>
	<%=dto.getEmail() %>
	<%=dto.getBlog() %>
	<%=dto.getEmail() %>
	<%=dto.getReg_date() %>
	<%=dto.getMember_level() %> <br />
<%		
	}
%>