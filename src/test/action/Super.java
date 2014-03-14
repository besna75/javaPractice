package test.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*interface 조상 클래스*/
public interface Super { 
	public String action(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException;
}