package mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties; /*java.util.Properties »Æ¿Œ*/

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Hello extends HttpServlet {
	Properties pr = null;
	public void init(ServletConfig config) throws ServletException {
		String path = config.getInitParameter("path");
		FileInputStream f = null;
		try{
		pr = new Properties();
		pr.load(f);
		}catch(IOException e){
			e.printStackTrace();
		}	
	}	

		protected void service(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			String uri = request.getRequestURI();
			String view = pr.getProperty(uri);
			
			RequestDispatcher rd = 
					request.getRequestDispatcher(view);
			rd.forward(request, response);
	}	
}

	
