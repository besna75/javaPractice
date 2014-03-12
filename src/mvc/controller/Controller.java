package mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator; /*Iterator 확인*/ 
import java.util.Properties; /*Properties 확인*/
import java.util.HashMap; /*map 확인*/

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
			pr.load(f); //properties 파일 로드시키기
			Iterator iter = pr.keySet().iterator();//command.properties에서 가져온 key 활용을 위한 Iterator (Iterator : for문과 유사한 용도)
			while(iter.hasNext()){
				String key = (String)iter.next(); 
				String value = pr.getProperty(key);
				Class className = Class.forName(value);
				Object obj = className.newInstance();
				map.put(key, obj);// String 데이터를 Object화 
			}	
		}catch(Exception e){
			e.printStackTrace();
		}	
	}	

		protected void service(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			String uri = request.getRequestURI();
			Super s = (Super)map.get(uri); //map에서 주소 가져오기 - 형변환하기
			String view = s.action(request, response);
			
			RequestDispatcher rd = 
					request.getRequestDispatcher(view);
			rd.forward(request, response);
	}	
}

	
