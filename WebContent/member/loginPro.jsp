<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="ch11.logon.*"%>

<% request.setCharacterEncoding("euc-kr");%>

<% 
	System.out.println("�α��� üũ");
	/* Parameter �ޱ� */
    String id = request.getParameter("id"); //���̵�
	String passwd  = request.getParameter("passwd"); //��й�ȣ
	String auto = request.getParameter("auto"); //�ڵ� �α���
	/* main�� ��Ű üũ */
	if(auto==null)auto="0";		
	Cookie [] coo = request.getCookies(); //�迭�� ��Ű �ޱ�
	for(Cookie d:coo){
		if(d.getName().equals("cooId")) id = d.getValue();
		if(d.getName().equals("cooPw")) passwd = d.getValue();
		if(d.getName().equals("cooAuto")) auto = d.getValue();					
	}

	/* DAO�� �޼ҵ� ������ */
	LogonDBBean manager = LogonDBBean.getInstance();
    int check= manager.userCheck(id,passwd);
    
	if(check==1){//main���� ���ǰ� ���� ����
			/* ��Ű ���� */
			if(auto.equals("1")){//�ڵ��α��ΰ� �ް�, ��Ű�����ϱ�
				//�ʿ� ��Ű ����
				Cookie coo1 = new Cookie("cooId",id);
				Cookie coo2 = new Cookie("cooPw",passwd);
				Cookie coo3 = new Cookie("cooAuto",auto);
				//��Ű ���ѽð� ����
				coo1.setMaxAge(60*60*24);
				coo2.setMaxAge(60*60*24);
				coo3.setMaxAge(60*60*24);
				//��Ű�� ����
				response.addCookie(coo1);
				response.addCookie(coo2);
				response.addCookie(coo3);
			}
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