<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/view/color.jsp"%>
<%@ page import = "db.*,java.util.List,java.text.SimpleDateFormat" %>
<%

	request.setCharacterEncoding("euc-kr");
	LogonDBBean db = LogonDBBean.getInstance();
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
	int pageSize = 10;
	int count = 0;
	count = db.countDB();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	
//	List list = db.getList(stRow,edRow);
%>
<%=count%>