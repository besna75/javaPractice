<%@ page contentType="text/html; charset=EUC-KR"%>
<!-- 1. �ش� DB import �ؿ��� -->
<%@ page import="test.db.*"%>

    <% 
    /* 2.DB�� id,pw�� Ȯ�� */    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    /* 3.dao�� ���� �α��� ���� �� Ȯ�� */
    DAO dao = DAO.getInstance();
    boolean result = dao.loginCh(id,pw);
    if(result){
    	session.setAttribute("sessionId", id);
    	session.setAttribute("sessionPw", pw);
    	out.println("�α��� �Ϸ�!!");
    }else{
    	out.println("id�� pw�� Ȯ�����ּ���!!");
    }
    %>
    
    
<%--  �ּ� ����
    <% /* cookie */
    /* 1.DB�� id,pw�� Ȯ�� */    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    /* 2. Cookie ���� */
    Cookie coo1 = new Cookie("cooId",id); //("��Ű��", ��Ű��)
    Cookie coo2 = new Cookie("cooPw",pw);
    /* 3. ��Ű�� ��ȿ�Ⱓ ���� */
    coo1.setMaxAge(60); //(60*60*24) = 60��*60��*24�Ϸ�
    coo2.setMaxAge(10); // (10) = 10��
    /* 4. ��Ű�� Ŭ���̾�Ʈ���� �ֱ� */
    response.addCookie(coo1);
    response.addCookie(coo2);
    out.println("��Ű �����Ϸ�!!");
    %> 
    
    <% /* session */
    /* 1.DB�� id,pw�� Ȯ�� */    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    /* 2. session ���� */
    session.setAttribute("sessionId", id); // IP ������ �ڵ����
    session.setAttribute("sessionPw", pw);
    out.println("���� �����Ϸ�.!!");
    %>    
�ּ� ��--%>