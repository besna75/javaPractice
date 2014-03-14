<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
InputStream is = null;
out.println("[");
out.print(request.getContentType());
out.println("]");
try{
	is=request.getInputStream();
	int data = -1;
	while((data=is.read())!=-1){
		out.print((char)data);
	}
}finally{
	if(is !=null)try{is.close();}catch(IOException ex){}
}
 %>
</body>
</html>