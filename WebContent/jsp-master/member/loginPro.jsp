<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "team5.member.LogonDBBean" %>

<% request.setCharacterEncoding("euc-kr");%>

<%
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");
	
	LogonDBBean manager = LogonDBBean.getInstance();
    int check= manager.userCheck(id,passwd);

	if(check==1){ // �α��� ������		
		// ��Ű ����
	    Cookie cooId = new Cookie("cooId", id);
	    Cookie cooPasswd = new Cookie("cooPasswd", passwd);
	    	
    	// ��Ű�� ��ȿ�Ⱓ ����
    	cooId.setMaxAge(6000); // �ʴ���
    	cooPasswd.setMaxAge(6000);
    	
    	// ����.���� ��Ű�� Ŭ���̾�Ʈ���� �ش�.
    	response.addCookie(cooId);
    	response.addCookie(cooPasswd);
		
    	// �Ӽ� ����
		session.setAttribute("memId",id);
		response.sendRedirect("main.jsp");
	}else if(check==0){%>
	<script> 
	  alert("��й�ȣ�� ���� �ʽ��ϴ�.");
      history.go(-1);
	</script>
<%	}else{ %>
	<script>
	  alert("���̵� ���� �ʽ��ϴ�..");
	  history.go(-1);
	</script>
<%}	%>	