<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="ch11.logon.*"%>
<%@ page import="board.*"%>
<h2> ���Ե� ȸ���˻�</h2>
<%	
	/* �α��� �� ȸ����� üũ */
	String id = (String) session.getAttribute("memId"); //session�̹Ƿ� ������ requset ���� ��� 
	LogonDBBean manager = LogonDBBean.getInstance(); //DAO�� �޼ҵ� ����� ���� �ν��Ͻ� ����
	LogonDataBean c = manager.getMember(id); // �α��� �Ǿ� �ִ� ����� ���� ���  		
	String grade =""; // ���� ������ �ʱ�ȭ �ؾߵȴ�.
	
	List<LogonDataBean> list = null;
	
	if (session.getAttribute("memId") != null) { 		
		grade = c.getGrade(); // ȸ�����Ȯ��
		
		if (grade.equals("admin")) {			
			list = manager.getMember();
			for (LogonDataBean dto : list) {%>
					<%=dto.getId()%>
					<%=dto.getName()%>
					<%=dto.getReg_date()%>
					<br />
			<%}%>
			<%} else {%> <!-- nothing --><%}%>
	<%}%>

	
	
