package test.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import test.db.DAO;

public class LoginProAction implements Super {

		public String action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		//..DB���� user üũ...���
		request.setAttribute("id", id);
		request.setAttribute("pw", pw);
		
		/*DAO ��� ��
		DAO dao = DAO.getInstance();
		int check = dao.userCheck(id,pw);	
		*/
		
		if(check == 1){
			// HttpSession session = request.getSession(): //�ڹٿ��� �������� ����ϱ�
			session.setAttribute("memId", id); //Action���� 
		}
		
		request.setAttribute("check", new Integer(check));
				
		return "/test/loginPro.jsp";
	}

}
