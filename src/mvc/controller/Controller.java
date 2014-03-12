package mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator; /*Iterator Ȯ��*/ 
import java.util.Properties; /*Properties Ȯ��*/
import java.util.HashMap; /*map Ȯ��*/

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import test.action.Super;

public class Controller extends HttpServlet {
	Properties pr = null;
	static HashMap map = new HashMap();
	
	public void init(ServletConfig config) throws ServletException {
		String path = config.getInitParameter("path");
		FileInputStream f = null;
		pr = new Properties();
		try{
			f = new FileInputStream(path);
			pr.load(f); //properties ���� �ε��Ű��
			Iterator iter = pr.keySet().iterator();//command.properties���� ������ key Ȱ���� ���� Iterator (Iterator : for���� ������ �뵵)
			while(iter.hasNext()){
				String key = (String)iter.next(); 
				String value = pr.getProperty(key);
				Class className = Class.forName(value);
				Object obj = className.newInstance();
				map.put(key, obj);// String �����͸� Objectȭ 
			}	
		}catch(Exception e){
			e.printStackTrace();
		}	
	}	

		protected void service(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			String uri = request.getRequestURI();
			Super s = (Super)map.get(uri); //map���� �ּ� �������� - ����ȯ�ϱ�
			String view = s.action(request, response);
			
			RequestDispatcher rd = 
					request.getRequestDispatcher(view);
			rd.forward(request, response);
	}	
}

	
