<%@ page contentType = "text/html; charset=euc-kr" %>

<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.FileItem" %>

<%@ page import = "image.ImageUtil" %>
<%@ page import = "image.FileUploadRequestWrapper" %>

<%@ page import = "image.Theme" %>
<%@ page import = "image.ThemeManager" %>
<%@ page import = "image.ThemeManagerException" %>

<%
    FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(
        request, -1, -1,
        "C:\\Tomcat 5.5\\webapps\\java\\temp");
    HttpServletRequest tempRequest = request;
    request = requestWrap;
%>
<jsp:useBean id="theme" class="image.Theme">
    <jsp:setProperty name="theme" property="*" />
</jsp:useBean>
<%
    FileItem imageFileItem = requestWrap.getFileItem("imageFile");
    String image = "";
    if (imageFileItem.getSize() > 0) {
        image = Long.toString(System.currentTimeMillis());
        
        // �̹����� ������ ��ο� ����
        File imageFile = new File(
            "C:\\Tomcat 5.5\\webapps\\java\\image",
            image);
        // ���� �̸��� �����̸� ó��
        if (imageFile.exists()) {
            for (int i = 0 ; true ; i++) {
                imageFile = new File(
                    "C:\\Tomcat 5.5\\webapps\\java\\image",
                    image+"_"+i);
                if (!imageFile.exists()) {
                    image = image + "_" + i;
                    break;
                }
            }
        }
        imageFileItem.write(imageFile);
        
        // ����� �̹��� ����
        File destFile = new File(
            "C:\\Tomcat 5.5\\webapps\\java\\image",
            image+".small.jpg");
        ImageUtil.resize(imageFile, destFile, 50, ImageUtil.RATIO);
    }
    
    theme.setRegister(new Timestamp(System.currentTimeMillis()));
    theme.setImage(image);
    
    ThemeManager manager = ThemeManager.getInstance();
    manager.insert(theme);
%>
<script>
alert("���ο� �̹����� ����߽��ϴ�.");
location.href = "list.jsp";
</script>
